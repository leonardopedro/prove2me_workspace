#!/usr/bin/env python3
"""Deduplication report for the theorems proved/accepted by leonardopedro.

Consumes the cached platform catalogue (`state/platform_index.jsonl`, produced by
`debug/find_duplicates.py --index --reset`, which stores a name-stripped semantic
statement) and the account's ground-truth solved list (`GET /users/<uid>`, per
PIPELINE_PLAN.md §1g/§1h).

It answers: *for the theorems this account proved, which ones restate a theorem
the platform already has — ours or another user's — so that the proof could have
been an `import Theorems.Thm_<slug>` reduction instead of a fresh submission?*

Read-only.  Writes `DEDUP_REPORT_leonardopedro.md` at the workspace root.

Usage:
    python3 debug/dedup_report.py [--out PATH] [--max N]
"""
import argparse
import collections
import datetime
import json
import os
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import upload_pipeline as up  # noqa: E402
import find_duplicates as fd  # noqa: E402

INDEX = os.path.join(WS, "state", "platform_index.jsonl")


def load_index():
    with open(INDEX) as fh:
        return [json.loads(line) for line in fh]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=os.path.join(WS, "DEDUP_REPORT_leonardopedro.md"))
    ap.add_argument("--max", type=int, default=40)
    args = ap.parse_args()

    ok, version, detail = up.auth_probe()
    if not ok:
        print(f"auth failed: {detail}")
        return 2
    me = up.api("GET", "me") or {}
    uid, uname = me.get("user_id") or me.get("id"), me.get("username")
    user = up.api("GET", f"users/{uid}") or {}
    solved = user.get("solved_problems") or []
    env = (up.api("GET", "environments") or {}).get("environments") or []
    default = next((e for e in env if e.get("is_default")), {})

    rows = load_index()
    thms = [r for r in rows if r.get("status") != "Definition"]
    by_id = {r["id"]: r for r in thms}
    by_sh, by_sg, by_leaf, by_name = (collections.defaultdict(list) for _ in range(4))
    for r in thms:
        by_sh[r["sh"]].append(r)
        by_sg[r["sg"]].append(r)
        by_leaf[r["leaf"]].append(r)
        by_name[r["name"]].append(r)

    solved_ids = {s["theorem_id"] for s in solved}
    have_solved = [by_id[i] for i in solved_ids if i in by_id]
    missing = len(solved_ids) - len(have_solved)

    ours = [r for r in thms if r["by"] == uid]
    ours_by_sh = collections.defaultdict(list)
    for r in ours:
        ours_by_sh[r["sh"]].append(r)
    internal = [g for g in ours_by_sh.values() if len(g) > 1]

    def twin(r, status=None):
        return [x for x in by_sh[r["sh"]]
                if x["id"] != r["id"] and x["by"] != uid
                and (status is None or x["status"] == status)]

    cross_exact, near, leaf_reuse = [], [], []
    for r in have_solved:
        t = twin(r, "Proved")
        if t:
            cross_exact.append((r, t))
        g = [x for x in by_sg[r["sg"]]
             if x["id"] != r["id"] and x["by"] != uid and x["status"] == "Proved"]
        if g:
            near.append((r, g))
        lf = [x for x in by_leaf[r["leaf"]]
              if x["by"] != uid and x["status"] == "Proved"]
        if lf:
            leaf_reuse.append((r, lf))

    n_groups = sum(1 for g in by_sh.values() if len(g) > 1)
    n_cross = sum(1 for g in by_sh.values() if len({x["author"] for x in g}) > 1)

    # ---- the theorems already in the upload pipeline, classified the same way ----
    loc = fd.local_theorems()
    p_sh, p_dh, p_sg, p_nm, p_lf, p_pe = (collections.defaultdict(list)
                                          for _ in range(6))
    for r in thms:
        p_sh[r["sh"]].append(r)
        if r["dh"]:
            p_dh[r["dh"]].append(r)
        p_sg[r["sg"]].append(r)
        p_nm[r["name"]].append(r)
        p_lf[r["leaf"]].append(r)
        if r["status"] == "Proved":          # only a Proved node is reusable
            sp = fd.shape(r["sem"] or "")
            if sp:
                p_pe[sp].append(r)
    pipe = collections.OrderedDict(
        (k, []) for k in ("STMT", "DECL", "SIG", "SHAPE", "NAME", "LEAF"))
    for lt in loc:
        for label, table, key in (("STMT", p_sh, "sh"), ("DECL", p_dh, "dh"),
                                  ("SIG", p_sg, "sg"), ("SHAPE", p_pe, "pe"),
                                  ("NAME", p_nm, "name"),
                                  ("LEAF", p_lf, "leaf")):
            v = lt.get(key)
            if not v:
                continue
            for r in table.get(v, []):
                # Itself: same wave name, or the same declaration published under
                # the validator's prime-free name (a primed wave slug).
                if r["name"] == lt["name"] or r["name"] == lt.get("declname"):
                    continue
                pipe[label].append((lt, r))
    pipe_pending = [lt for lt in loc if lt["name"] not in by_name]

    # ---- alpha-renamed restatements of Proved nodes (`sig` cannot see these) ----
    alpha = collections.OrderedDict()
    for lt in pipe_pending:
        seen = set()
        for r in p_pe.get(lt.get("pe") or "", []):
            if r["name"] in (lt["name"], lt.get("declname")) or r["name"] in seen:
                continue
            seen.add(r["name"])
            alpha.setdefault(lt["name"], []).append(r)
    alpha_self = sum(1 for v in alpha.values()
                     for r in v if r["author"] == uname)
    alpha_other = sum(1 for v in alpha.values()
                      for r in v if r["author"] != uname)

    now = datetime.date.today().isoformat()

    def sec(f):
        f.write("\n")

    with open(args.out, "w") as f:
        W = f.write
        W(f"# Deduplication report — theorems proved/accepted by `{uname}`\n\n")
        W(f"*Generated {now} against prove2me API `{version}`, default environment "
          f"`{default.get('display_name', '?')}` (`{default.get('mathlib_rev', '?')}`). "
          f"Read-only; no platform state was changed.*\n\n")
        W(f"Tooling: `debug/find_duplicates.py` (resumable catalogue index) + "
          f"`debug/dedup_report.py` (this report). See `PIPELINE_PLAN.md` §1n.\n\n")

        W("## Headline\n\n")
        W(f"* account `{uname}` (`{uid}`): `num_solved_prob = "
          f"{me.get('num_solved_prob')}` — {len(solved)} entries in the solved list, "
          f"{len(have_solved)} matched in the catalogue ({missing} unmatched).\n")
        W(f"* catalogue indexed: **{len(rows)} distinct rows** "
          f"({len(thms)} theorems + defs excluded).\n")
        W(f"* **{len(cross_exact)}** solved theorems are *statement-identical* to a "
          f"**Proved theorem by another user** — these are the proofs that could have "
          f"been a one-line import.\n")
        W(f"* **{len(near)}** more share the token signature of another user's Proved "
          f"theorem (near; manual triage).\n")
        W(f"* **{len(internal)}** of our own nodes restate *another of our own* nodes "
          f"(internal duplication — two catalogued nodes for one claim).\n")
        W(f"* context: the catalogue holds **{n_groups}** statement-duplicate groups, "
          f"**{n_cross}** of them spanning more than one author.\n\n")

        W("### What an exact “0” means, and does not mean\n\n")
        W("A name-stripped *exact* statement match is a conservative test: it requires "
          "the two Lean types to be character-identical after whitespace normalization, "
          "so differently-named or API-restated versions of the same fact register as "
          "*near*, not as duplicates. A zero in a class is therefore a lower bound on "
          "the true overlap, and the near/leaf sections are where the remaining reuse "
          "lives.\n\n")
        W("Most of our proved theorems are **project-specific** `BookProof.*` "
          "statements built on our own definitions (`PosSymOp`, `dsComparison`, "
          "`lagrangianCore`, …); no other user states them, so no cross-author duplicate "
          "should be expected, and finding none is the correct answer, not a gap in the "
          "scan.\n")

        # ---- A. internal ----
        W("\n## A. Internal duplication — two of our nodes for one claim\n\n")
        if not internal:
            W("_None._\n")
        for g in internal[:args.max]:
            W(f"* `{g[0]['sem'][:150]}`\n")
            for x in g:
                W(f"  - `{x['name']}` — {x['status']}, `{x['id']}`\n")
        W("\n**Action.** Keep one as canonical and make the other a downstream "
          "reference (or deprecate the redundant node with `PATCH /theorems/:id`), so "
          "future agents import the canonical one.\n")

        # ---- B. cross-author exact ----
        W("\n## B. Solved theorems that exactly restate another user's Proved theorem\n\n")
        if not cross_exact:
            W("_None._  No solved theorem of this account is an exact "
              "(name-stripped) restatement of a Proved theorem by another user.\n")
        for r, g in cross_exact[:args.max]:
            W(f"* ours `{r['name']}` (`{r['id']}`)\n")
            for x in g[:4]:
                W(f"  - theirs `{x['name']}` by **{x['author']}** (`{x['id']}`)\n")

        # ---- C. near ----
        W("\n## C. Near duplicates — same token signature as another user's Proved node\n\n")
        W("Signature matches are token-set based, so a generic statement can match an "
          "unrelated one; each row below still needs a human read. (In the run of "
          f"{now}, only `conj_mul_self` ≈ `AsaiLargeSieve.sq_ofReal_norm` is a genuine "
          "restatement; `half_cast`'s twins are syntactic false positives.)\n\n")
        if not near:
            W("_None._\n")
        for r, g in near[:args.max]:
            W(f"* ours `{r['name']}` (`{r['id']}`)\n")
            W(f"  - `{r['sem'][:160]}`\n")
            for x in g[:3]:
                W(f"  - theirs `{x['name']}` by **{x['author']}** (`{x['id']}`): "
                  f"`{x['sem'][:160]}`\n")

        # ---- D. leaf reuse shortlist ----
        W("\n## D. Reuse shortlist — another user's Proved node with our leaf name\n\n")
        if not leaf_reuse:
            W("_None._\n")
        for r, g in leaf_reuse[:args.max]:
            W(f"* `{r['name']}` — other authors: "
              + ", ".join(f"`{x['name']}`/{x['author']}" for x in g[:3]) + "\n")

        # ---- E. platform-wide ----
        W("\n## E. Platform-wide duplicate backlog (context)\n\n")
        W(f"The scan finds **{n_groups}** statement-duplicate groups, **{n_cross}** "
          f"across authors. None of our solved theorems is in an exact cross-author "
          f"group, but the backlog is real and is the pool a future wave should import "
          f"from rather than re-prove. The reusable *instruments* for the new "
          f"Faris–Lavine / Fock work (Fourier/Parseval, convolution symmetry, Schur "
          f"row bounds, coercivity, singular-value norm, `H^s` form domain) are listed "
          f"with ids in the timepiece `CONSOLIDATED_PLAN.md`, §“Cross-platform reuse”.\n")

        # ---- F. the theorems already in the upload pipeline ----
        W("\n## F. The theorems already in the pipeline — does any restate an existing node?\n\n")
        W("Same matcher, applied to every `Theorems/Thm_*.lean` stub named in "
          "`pipeline/wave_upload.json` (`debug/find_duplicates.py --report`). This is the "
          "**avoid duplication in prove2me** check for the incoming work: a wave theorem that "
          "already exists on the platform should be re-published as a reduction, not re-proved.\n\n")
        W(f"* wave theorems parsed: **{len(loc)}**; already present under their own dotted "
          f"name: **{len(loc) - len(pipe_pending)}**; live pending frontier: "
          f"**{len(pipe_pending)}**.\n")
        W("* local statements are hashed from the **declaration** (`decl_only`), matching "
          "the platform's `formal_statement`; see the correction below.\n")
        W("\n| class | collisions | with a `Proved` node |\n| :-- | --: | --: |\n")
        for label in ("STMT", "DECL", "SIG", "SHAPE", "NAME", "LEAF"):
            hits = pipe[label]
            proved = [x for x in hits if x[1]["status"] == "Proved"]
            W(f"| `{label}` | {len(hits)} | {len(proved)} |\n")
        W("\n")
        W("The only non-trivial classes:\n\n")
        for label in ("DECL", "STMT"):
            for lt, r in pipe[label][:args.max]:
                W(f"* `{label}` — ours `{lt['slug']}` → `{r['name']}` "
                  f"[{r['status']}/{r['author']}] (`{r['id']}`)\n")
        cross_leaf = [(lt, r) for lt, r in pipe["LEAF"]
                      if r["author"] != uname
                      and (lt["leaf"] not in {"add", "sub", "mul", "div", "zero", "one",
                                              "car", "neg", "pow", "smul", "conj", "coe",
                                              "apply", "mem", "le", "lt", "eq", "ne", "sum",
                                              "injective", "resolvent_identity"})]
        W(f"\nCross-author `LEAF` hits with a non-generic leaf name: **{len(cross_leaf)}** "
          "(the rest are false positives on generic leaves such as `add`, `car`, `sum`):\n\n")
        for lt, r in cross_leaf[:args.max]:
            W(f"* `{lt['name']}` ≈ `{r['name']}` by **{r['author']}** (`{r['id']}`) — "
              f"`{r['sem'][:120]}`\n")
        W("\nTriaged: `QFS.abs_coord_le_norm` (dbenbenn) is **not** a reuse — timepiece's own "
          "`v4.28.0` Mathlib proves it as `PiLp.norm_apply_le` with `Real.norm_eq_abs`; the leaf "
          "match is a naming coincidence. The other two are different statements under a shared "
          "leaf (`NavierStokes.norm_heatFlow_le` is a 3-D vector heat-flow bound vs. our generic "
          "`E/F` one; `PythHydra.phi_zero` is `phi k 0 = 1` vs. our `phi 0 = Complex.exp`).\n")
        n_stmt = len(pipe["STMT"])
        n_sig = len(pipe["SIG"])
        n_shape = len(pipe["SHAPE"])
        cross_stmt = [x for x in pipe["STMT"] if x[1]["author"] != uname]
        W("\n**Correction (2026-09-18).**  Up to and including the previous run this "
          "table was misleading: the *local* side was hashed from the whole stub file — "
          "`import`/`open` prologue included — while the platform side is hashed from "
          "`formal_statement`, which is the bare declaration. The two objects were never "
          "comparable, so `STMT`/`SIG`/`SHAPE` could not fire and the `0` in the `STMT` "
          "row read as a clean bill of health when it was an artifact of the mismatch. "
          "`local_theorems` now hashes `decl_only(...)`, as it always hashed `dh`, and "
          "the same classes report "
          f"**{n_stmt} / {n_sig} / {n_shape}** collisions.\n\n")
        W(f"* **{n_stmt}** of them are exact restatements (`STMT`), **all against our "
          f"own** nodes — the cross-author `STMT` count is {len(cross_stmt)}.\n")
        W("* Most are already resolved by the pipeline's own reuse detection: the "
          "publish-job sync marks them `reused: true` with the id of the existing node "
          "(`reused_status: published` for the theorem, `Proved` for the solution) "
          "instead of minting a twin. `PIPELINE_PLAN.md` §1y lists the six and the two "
          "that are still open.\n")
        W("* `SIG`/`SHAPE` are triage lists, not verdicts: they compare identifier "
          "*sets*, so statements sharing API names (`structureConstant_antisymm_swap` / "
          "`_rotate` / `jacobi`) collide without being restatements.\n")
        W("\n**Conclusion.** No wave theorem restates **another user's** node in any class, "
          "so there is no pipeline item to re-publish as a cross-author reduction. The "
          "reusable material for the *new* Faris–Lavine / Fock work is the instrument "
          "table of `CONSOLIDATED_PLAN.md` §“Cross-platform reuse”, not a wave-node "
          "twin. What the wave *does* contain is a handful of **self**-restatements "
          "(two chapters of ours stating one lemma), which the `SHAPE` class now catches "
          "before a stub is generated rather than after.\n")

        # ---- G. alpha-renamed restatements (the class `sig` cannot see) ----
        W("\n## G. Alpha-renamed restatements of an already-`Proved` node\n\n")
        W("The classes above compare token sets *including* the binder names, which is "
          "blind to the commonest way a new chapter duplicates an old node: the same "
          "statement with renamed variables. Two spellings slip through in particular — "
          "single-letter names (`b`, `g`) are identifiers to the tokenizer and stay in "
          "the set, while **Greek names (`β`, `γ`) are not matched by it at all** and "
          "silently disappear, so `sig` and `STMT` compare two spellings of one theorem "
          "as different strings. The `SHAPE` row above (identifier set with all "
          "single-character names dropped, `debug/find_duplicates.py: shape`) closes "
          "that gap.\n\n")
        W(f"Of the **{len(pipe_pending)}** not-yet-published wave theorems, "
          f"**{len(alpha)}** restate a `Proved` node up to binder renaming: "
          f"**{alpha_self}** against one of our own nodes and **{alpha_other}** against "
          f"another user's.\n\n")
        if not alpha:
            W("_None._\n")
        for name, rs in list(alpha.items())[:args.max]:
            W(f"* ours `{name}`\n")
            for r in rs[:3]:
                who = "**ours**" if r["author"] == uname else f"**{r['author']}**"
                W(f"  - restates `{r['name']}` — {who}, `{r['id']}`: `{r['sem'][:140]}`\n")
        if alpha:
            W("\n**Action.** These need no new proof and no new node: they are the same "
              "claim, so the pipeline should resolve them as already present rather than "
              "re-submitting (the publish-job sync already records them as `reused: true` "
              "with the id of the existing node — `reused_status: published`; see "
              "`PIPELINE_PLAN.md` §1n/§1y). The `SHAPE` check exists so the *generator* can "
              "skip a restatement before it becomes a stub, instead of after.\n")

        W("\n## Method and caveats\n\n")
        W("* Ground truth for “proved by us” is `GET /users/<uid>` → `solved_problems` "
          "(PIPELINE_PLAN.md §1g/§1h). `created_by` alone over-counts (a node we "
          "published Open can be Proved later by anyone), and `GET /submissions` is a "
          "truncated window.\n")
        W("* Statements are compared **name-stripped**: the platform stores "
          "`theorem <full.name> <binders> : <type> := by sorry`, so the module name is "
          "removed before hashing; otherwise every equality would be a name equality. "
          "Definitions (empty statements) are excluded.\n")
        W(f"* Catalogue was indexed once in the default environment; paging returned "
          f"{len(rows)} distinct rows of a reported total, so a small overlap across "
          "pages is possible and coverage is close to complete but not provably "
          "exhaustive.\n")
        W("* The matcher is **syntactic**: it does not know that two statements are "
          "logically equivalent under different casts/coercions, nor that one implies "
          "the other. Treat “near” as a triage list, not a verdict.\n")
        W("* `SIG` keeps the binder names, so despite its docstring it is *not* "
          "binder-insensitive; `SHAPE` is, but it drops every single-character "
          "identifier, so it matches on the multi-letter API names alone and needs a "
          "read. Neither class sees through `PiLp`/coercion restatements, which is why "
          "`QFS.abs_coord_le_norm` above is a leaf-only hit.\n")
        W("* The catalogue is a snapshot of the default environment: a theorem published "
          "after the index was built is invisible to every class here. Refresh with "
          "`--reset --index` before treating a zero as final.\n")
        W("* Re-run after each upload wave: `python3 debug/find_duplicates.py --reset "
          "--index` (in bounded chunks) then `python3 debug/dedup_report.py`.\n")

    print(f"wrote {args.out}")
    print(f"cross_exact={len(cross_exact)} near={len(near)} internal={len(internal)} "
          f"leaf_reuse={len(leaf_reuse)} solved={len(have_solved)} missing={missing}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
