#!/usr/bin/env python3
"""Build the `Def_ChapterLeafGaps` aux bundle (§ leaf-selection gaps).

The generated def bundles carry only the decls their chapter's selected
statement-leaves reference (leaf selection).  Sols that cite anything else
fail platform-side with `Unknown identifier`, and published bundles are
IMMUTABLE (references/contribute.md), so the fix is a single new definition
that re-carries the dropped clusters in their original namespaces; affected
sols add one `import Definitions.Def_ChapterLeafGaps`.

This tool extracts, for each (source file, missing name) pair given on the
command line as `File.lean:NAME1,NAME2,...` (file path relative to the
timepiece checkout), the decl blocks with same-file closure over names the
published mirror (/tmp/published_mirror) does NOT provide at their FULL
(namespace-qualified) name.  A bare-name check is wrong: another chapter may
declare the same bare name, which does not make it reachable from here.

Namespaces are rebuilt from the source `namespace`/`section` stack:
  * `section`/`noncomputable section` push markers, so their `end` pops the
    section (not the enclosing namespace), and each decl remembers exactly
    which `variable` lines were active where it was declared — Lean's
    last-declaration-wins shadowing is reproduced by re-emitting those lines
    inside the matching `section` blocks, in source order.
  * `set_option ... in` lines attach to the following decl through blank
    lines and comments (they are NOT emitted into namespace preambles).
  * namespaces are emitted dependencies-first (a decl must exist before it
    is used), tie-broken by nesting depth.

Output: Definitions/Def_ChapterLeafGaps.lean (written only with --write).

Usage:
  python3 debug/build_leafgap_bundle.py --spec /tmp/leafgap_spec.txt [--write]
    spec lines: <source-file-relative-to-timepiece331> : NAME1,NAME2,...
    a line `#import:Definitions.Def_X` forces an extra import.
"""
import argparse
import glob
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TP = os.path.join(os.path.dirname(WS), "timepiece331")
MIRROR = "/tmp/published_mirror"
DECL = re.compile(r'^(?:noncomputable\s+)?(?:def|theorem|lemma|abbrev|structure|instance)\s+([^\s:({⟨\[]+)')
STAGED = ("Def_ChapterLeafGaps.lean", "Def_ChapterNsKoopman.lean",
          "Def_ChapterNsNonlinearFarisLavine.lean")
IDENT = re.compile(r"[A-Za-z_ℕℤℚℝℂ][A-Za-z_0-9'ₙ₀-₉ₗₕ]*")
CMD = re.compile(
    r"^(namespace\b|end\b|section\b|open\b|variable\b|set_option\b|attribute\b|"
    r"local\s|private\s|protected\s|noncomputable\s|mutual\b|example\b|theorem\b|"
    r"lemma\b|def\b|abbrev\b|structure\b|instance\b|macro\b|elab\b|syntax\b|"
    r"scoped\b|@\[)")


def is_marker(x):
    return x.startswith("§")


def block_delta(l):
    """Net block-comment nesting introduced by a line (`/-` vs `-/`)."""
    d, i = 0, 0
    while True:
        a = l.find("/-", i)
        b = l.find("-/", i)
        if a == -1 and b == -1:
            return d
        if a != -1 and (b == -1 or a < b):
            d += 1
            i = a + 2
        else:
            d -= 1
            i = b + 2


def sec_name(marker):
    return marker[1:]


def ns_key(st):
    """Namespace part of the stack: section markers ('§...') are filtered out."""
    return ".".join(x for x in st if not is_marker(x))


def src_full(ns, nm):
    """Full name of a source decl written as `nm` inside namespace `ns`."""
    if not ns or nm.startswith(ns + "."):
        return nm
    return ns + "." + nm


def parse_namespaces(path):
    """-> (lines, blocks, preambles, global_pre, first_ns).

    blocks[name] = (start, end, ns, sec_path, var_lines)
      sec_path  : tuple of '§...' markers open at the decl line
      var_lines : [(idx, depth, line)] active section-level `variable` lines
    preambles[ns] = [(ns, idx, line)] namespace-level (section-depth-0)
      `open`/`variable` lines, in source order.
    """
    lines = open(path, encoding="utf-8").read().splitlines()
    stack, preambles = [], {}
    global_pre = []
    first_ns = None
    active = []          # (idx, depth, line) section-scoped variables, open
    starts = []          # (i, name, ns, sec_path, var_lines)
    in_block = 0

    def depth():
        return sum(1 for x in stack if is_marker(x))

    def prune():
        d = depth()
        active[:] = [a for a in active if a[1] <= d]

    for i, l in enumerate(lines):
        # skip anything inside a block comment (prose docstrings contain
        # col-0 words like `instance with ...` that would parse as decls)
        bd = block_delta(l)
        if in_block > 0:
            in_block += bd
            continue
        if bd > 0:
            in_block = bd
            continue
        in_block = 0
        if l.startswith("namespace "):
            parts = l.split()
            if len(parts) >= 2:
                stack.append(parts[1])
                preambles.setdefault(ns_key(stack), [])
                if first_ns is None:
                    first_ns = ns_key(stack)
            continue
        if l.startswith("end"):
            parts = l.split()
            if len(parts) >= 2 and "." in parts[1]:
                while stack and is_marker(stack[-1]):
                    stack.pop(); prune()
                target = parts[1]
                while stack and ns_key(stack) != target and stack[-1] != target.split(".")[-1]:
                    if is_marker(stack[-1]):
                        stack.pop(); prune()
                    else:
                        stack.pop()
                if stack:
                    stack.pop(); prune()
            elif stack:
                stack.pop(); prune()
            continue
        tok = l.split()
        if tok and (tok[0] == "section"
                    or (tok[0] == "noncomputable" and len(tok) > 1 and tok[1] == "section")):
            if tok[0] == "section":
                stack.append("§" + ".".join(tok[1:]))
            else:
                stack.append("§noncomputable section")
            continue
        key = ns_key(stack)
        if l.startswith("open "):
            if key:
                preambles.setdefault(key, []).append((key, i, l))
            else:
                global_pre.append(l)
            continue
        if l.startswith("variable "):
            # absorb continuation lines: Lean 4 commands are not line-
            # terminated — a following indented `[`/`{`/`(` continues the
            # binder list (`  [MeasurableSpace E] [BorelSpace E]`).
            chunk = [l]
            k = i + 1
            while k < len(lines):
                nxt = lines[k].strip()
                if nxt == "" or nxt.startswith("--"):
                    k += 1
                    continue
                if nxt.startswith(("[", "{", "(")):
                    chunk.append(lines[k])
                    k += 1
                    continue
                break
            lv = "\n".join(chunk)
            if not key:
                global_pre.append(lv)
            elif depth() == 0:
                preambles.setdefault(key, []).append((key, i, lv))
            else:
                active.append((i, depth(), lv))
            continue
        m = DECL.match(l)
        nm = m.group(1) if m else None
        if not m and l.startswith("@["):
            br = l.find("]")
            if br > 0:
                m2 = DECL.match(l[br + 1:].lstrip())
                if m2:
                    nm = m2.group(1)
        if nm:
            starts.append((i, nm, ns_key(stack), tuple(x for x in stack if is_marker(x)),
                           list(active)))
    blocks = {}
    for i, name, ns, sec_path, var_lines in starts:
        # block ends at the next col-0 command line (decl or sectioning)
        j = None
        for t in range(i + 1, len(lines)):
            if lines[t] and not lines[t][0].isspace() and CMD.match(lines[t]):
                j = t
                break
        if j is None:
            j = len(lines)
        # walk back over blank/comment/`set_option ... in`/standalone-attribute
        # lines so the decl carries exactly the option lines Lean attaches to it
        # (never a preceding decl's `@[simp] theorem prev` line).
        s = i
        while s > 0:
            p = lines[s - 1].rstrip()
            ps = p.strip()
            if ps == "" or ps.startswith("--") or ps.startswith("/-") \
                    or (ps.startswith("set_option") and ps.endswith(" in")):
                s -= 1
                continue
            if ps.startswith("@["):
                br = p.find("]")
                rest = p[br + 1:].lstrip() if br >= 0 else ""
                if rest and DECL.match(rest):
                    break
                s -= 1
                continue
            break
        blocks[name] = (s, j, ns, sec_path, var_lines)
    return lines, blocks, preambles, global_pre, first_ns


def full_names(path):
    """All full decl names declared by a .lean file (namespace- and
    section-aware)."""
    names = set()
    stack = []
    in_block = 0
    for l in open(path, encoding="utf-8"):
        bd = block_delta(l)
        if in_block > 0:
            in_block += bd
            continue
        if bd > 0:
            in_block = bd
            continue
        in_block = 0
        if l.startswith("namespace "):
            parts = l.split()
            if len(parts) >= 2:
                stack.append(parts[1])
            continue
        if l.startswith("end"):
            parts = l.split()
            if len(parts) >= 2 and "." in parts[1]:
                while stack and is_marker(stack[-1]):
                    stack.pop()
                target = parts[1]
                while stack and ".".join(x for x in stack if not is_marker(x)) != target \
                        and stack[-1] != target.split(".")[-1]:
                    stack.pop()
                if stack:
                    stack.pop()
            elif stack:
                stack.pop()
            continue
        tok = l.split()
        if tok and (tok[0] == "section"
                    or (tok[0] == "noncomputable" and len(tok) > 1 and tok[1] == "section")):
            stack.append("§")
            continue
        m = DECL.match(l)
        if not m and l.startswith("@["):
            br = l.find("]")
            if br > 0:
                m = DECL.match(l[br + 1:].lstrip())
        if m:
            names.add(src_full(ns_key(stack), m.group(1)))
    return names


def mirror_names():
    names = set()
    for f in glob.glob(f"{MIRROR}/Definitions/*.lean"):
        if any(f.endswith(s) for s in STAGED):
            continue      # our own staged bundles are not the published world
        names |= full_names(f)
    return names


def broaden_opens(lines):
    out = []
    for l in lines:
        if l.startswith("open ") and "(" in l:
            l = l.split("(")[0].rstrip()
        out.append(l)
    return out


def strip_tail(chunk):
    ls = chunk.splitlines()
    while True:
        while ls and ls[-1].strip() == "":
            ls.pop()
        if not ls:
            break
        if ls[-1].rstrip().endswith("-/"):
            k = len(ls) - 1
            while k >= 0 and not (ls[k].startswith("/--") or ls[k].startswith("/-!")):
                k -= 1
            if k >= 0:
                del ls[k:]
                continue
        if re.match(r"^end(\s|$)", ls[-1].strip()):
            ls.pop()
            continue
        break
    return "\n".join(ls)


def binder_names(var_line):
    """Binder variable names declared by a `variable ...` line.

    `{D : T}` / `(a b : T)` -> names left of the first top-level ':'
    (or all names if there is no ':');  `[C x y]` -> names after the
    first token (the class reference).
    """
    body = var_line.split(" ", 1)[1] if " " in var_line else ""
    for pre in ("include ", "omitting "):
        if body.startswith(pre):
            body = body[len(pre):]
    names, i, n = [], 0, len(body)
    while i < n:
        c = body[i]
        if c in "({[":
            d = 0
            j = i
            while j < n:
                if body[j] in "({[":
                    d += 1
                elif body[j] in ")}]":
                    d -= 1
                    if d == 0:
                        break
                j += 1
            inner = body[i + 1:j]
            if c == "[":
                toks = IDENT.findall(inner)
                names += toks[1:] if len(toks) > 1 else []
            else:
                head = inner.split(":", 1)[0]
                names += IDENT.findall(head)
            i = j + 1
        else:
            i += 1
    return names


def project_vars(ctx_lines):
    """Reproduce Lean's last-declaration-wins shadowing: keep only the last
    `variable` line declaring each binder name (earlier ones are dead)."""
    names = [binder_names(l) if l.startswith("variable ") else []
             for l in ctx_lines]
    last = {}
    for k, nms in enumerate(names):
        for nm in nms:
            last[nm] = k
    drop = set()
    for nm, k in last.items():
        for q, nms in enumerate(names):
            if q != k and nm in nms:
                drop.add(q)
    return [l for q, l in enumerate(ctx_lines) if q not in drop]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--spec", required=True)
    ap.add_argument("--write", action="store_true")
    args = ap.parse_args()

    mir = mirror_names()
    ns_blocks = {}      # namespace -> [entry]
    ns_preamble = {}    # namespace -> [(ns, idx, line)] depth-0 opens/variables
    global_pres = []    # per-file global preambles (outside any namespace)
    imports = set()
    forced_imports = set()
    files = {}          # rel -> dict(lines, blocks, first_ns)
    roots = []          # (rel, want-set) in spec order
    for raw in open(args.spec):
        raw = raw.strip()
        if not raw:
            continue
        if raw.startswith("#import:"):
            forced_imports.add(raw.split(":", 1)[1].strip())
            continue
        if raw.startswith("#"):
            continue
        rel, _, names_csv = raw.partition(":")
        rel = rel.strip()
        want = {n.strip() for n in names_csv.split(",") if n.strip()}
        path = os.path.join(TP, rel)
        if not os.path.exists(path):
            print(f"  MISSING SOURCE {rel}", file=sys.stderr)
            continue
        lines, blocks, preambles, global_pre, first_ns = parse_namespaces(path)
        files[rel] = dict(lines=lines, blocks=blocks, first_ns=first_ns)
        roots.append((rel, want))
        for _k, _v in preambles.items():
            if _v:
                ns_preamble.setdefault(_k, []).extend(_v)
        if global_pre:
            global_pres.append((rel, broaden_opens(global_pre)))
        # import the published bundle(s) of this chapter (best effort by dir name)
        m = re.search(r'Chapter[A-Za-z0-9]+', rel)
        if m:
            imports.add(f"Definitions.Def_{m.group(0)}")

    # union locator over all spec files (decl keys may be dotted, e.g.
    # `CoreRep.coe_op`).  Matching rules:
    #   plain key  -> exact bare token;
    #   dotted key -> bare token equal to its LAST component when that carries
    #                 an underscore (structure-dot notation `Φ.coe_op`), or an
    #                 exact qualified path from the text (`RealCoeff.sum`).
    # Generic bare names (`sum`, `add`, `with`) must NOT match dotted keys —
    # that over-pulls unrelated clusters.
    loc_plain, loc_dot_last, loc_dotted = {}, {}, []
    for rel, fd in files.items():
        for n in fd["blocks"]:
            if "." in n:
                last = n.split(".")[-1]
                if "_" in last:
                    loc_dot_last.setdefault(last, []).append((rel, n))
                loc_dotted.append((rel, n))
            else:
                loc_plain.setdefault(n, []).append((rel, n))
    QUAL = re.compile(r"[A-Za-z_][A-Za-z_0-9']*(?:\.[A-Za-z_][A-Za-z_0-9']*)+")

    def cands(text):
        out = []
        for mm in re.findall(r'\b([A-Za-z_][A-Za-z_0-9\']*)\b', text):
            out += loc_plain.get(mm, [])
            out += loc_dot_last.get(mm, [])
        for p in QUAL.findall(text):
            for rel, n in loc_dotted:
                if n == p or n.endswith("." + p):
                    out.append((rel, n))
        return out

    def avail(rel, n):
        fd = files[rel]
        ns = fd["blocks"][n][2] or fd["first_ns"]
        return src_full(ns, n) in mir

    # Lazy index of decl bare names -> source files, used to AUTO-EXTEND the
    # closure across chapter files the spec does not list (a carried decl can
    # reference a leaf gap in a chapter the spec never mentions).
    AUTO_DENY = {"add", "sum", "sub", "mul", "neg", "inv", "with", "map",
                 "comp", "apply", "ext", "of", "le", "lt", "eq", "mem",
                 "one", "zero", "smul", "prod", "norm", "conj", "real",
                 "abs", "pow", "sqrt", "cast", "ring", "simp", "map_zero",
                 "map_add", "comp_apply", "conj_comm"}
    _src_idx = [None]
    MAX_FILES = 60

    def ensure_file(rel2):
        if rel2 in files:
            return
        if len(files) >= MAX_FILES:
            return
        lines, blocks, preambles, global_pre, first_ns = parse_namespaces(
            os.path.join(TP, rel2))
        files[rel2] = dict(lines=lines, blocks=blocks, first_ns=first_ns)
        for _k, _v in preambles.items():
            if _v:
                ns_preamble.setdefault(_k, []).extend(_v)
        if global_pre:
            global_pres.append((rel2, broaden_opens(global_pre)))
        mm = re.search(r'Chapter[A-Za-z0-9]+', rel2)
        if mm:
            imports.add(f"Definitions.Def_{mm.group(0)}")
        for n in blocks:
            e = (rel2, n)
            if "." in n:
                last = n.split(".")[-1]
                if "_" in last:
                    loc_dot_last.setdefault(last, []).append(e)
                loc_dotted.append(e)
            else:
                loc_plain.setdefault(n, []).append(e)

    def src_candidates(bare):
        if _src_idx[0] is None:
            idx = {}
            for f in glob.glob(f"{TP}/BookProof/**/*.lean", recursive=True):
                try:
                    for n in full_names(f):
                        idx.setdefault(n.split(".")[-1], set()).add(
                            os.path.relpath(f, TP))
                except OSError:
                    pass
            _src_idx[0] = idx
        return _src_idx[0].get(bare, set())

    roots_set = {(rel, n) for rel, want in roots for n in want}
    needed, seen, queue = [], set(), []
    for rel, want in roots:
        for n in sorted(want):
            if n in files[rel]["blocks"]:
                queue.append((rel, n))
            else:
                c = loc_plain.get(n, []) + loc_dot_last.get(n, [])
                if len(c) == 1:
                    queue.append(c[0])
                else:
                    print(f"  NOT-FOUND {rel}:{n}", file=sys.stderr)
    # closure over names (any spec file) missing from the published mirror
    while queue:
        rel, n = queue.pop(0)
        if (rel, n) in seen:
            continue
        seen.add((rel, n))
        if n not in files[rel]["blocks"]:
            continue
        if avail(rel, n):
            if (rel, n) in roots_set:
                print(f"  AVAILABLE-ROOT {rel}:{n} (already published at its "
                      f"full name, not carried)", file=sys.stderr)
            continue
        needed.append((rel, n))
        s, j, ns, _sp, _vl = files[rel]["blocks"][n]
        text = "\n".join(files[rel]["lines"][s:j])
        for r2, n2 in cands(text):
            if (r2, n2) not in seen and not avail(r2, n2):
                queue.append((r2, n2))
        # auto-extend: tokens no spec file declares may name a leaf gap in
        # another chapter — look it up in the source tree and pull it in.
        for mm in set(re.findall(r'\b([A-Za-z_][A-Za-z_0-9\']*)\b', text)):
            # underscored names only: bare generic words (`adjoint`, `map_zero`)
            # hit unrelated chapters and bloat the bundle.
            if "_" not in mm or len(mm) < 4 or mm in AUTO_DENY:
                continue
            if mm in loc_plain or mm in loc_dot_last:
                continue
            cands_f = [r for r in src_candidates(mm)]
            if len(cands_f) != 1:
                continue
            ensure_file(cands_f[0])
            fd2 = files.get(cands_f[0])
            if not fd2:
                continue
            for n2 in fd2["blocks"]:
                if n2.split(".")[-1] != mm:
                    continue
                if (cands_f[0], n2) not in seen and not avail(cands_f[0], n2):
                    print(f"  AUTO-PULL {cands_f[0]}:{n2} <- token {mm!r} "
                          f"in {rel}:{n}", file=sys.stderr)
                    queue.append((cands_f[0], n2))
    for rel, n in sorted(needed,
                         key=lambda rn: (rn[0], files[rn[0]]["blocks"][rn[1]][0])):
        fd = files[rel]
        s, j, ns, sec_path, var_lines = fd["blocks"][n]
        ns = ns or fd["first_ns"]
        if not ns:
            print(f"  NO-NAMESPACE {rel}:{n} - skipped", file=sys.stderr)
            continue
        text = strip_tail("\n".join(fd["lines"][s:j]).strip())
        ns_blocks.setdefault(ns, []).append(
            dict(rel=rel, s=s, name=n, text=text, sec_path=sec_path,
                 vars=var_lines, full=src_full(ns, n)))

    out = []
    out.append("-- Auto-generated by debug/build_leafgap_bundle.py: the decl clusters the")
    out.append("-- published chapter bundles dropped by leaf selection, re-carried in their")
    out.append("-- original namespaces so red sols can import them with one line.")
    out.append("import Mathlib")
    for imp in sorted(imports | forced_imports):
        # only import bundles that exist locally AND are safe
        if os.path.exists(f"{WS}/{imp.replace('.', '/')}.lean"):
            out.append("import " + imp)
    # a namespace `open`ed by any preamble must exist in the environment: map it
    # to the bundle that declares it and import that bundle too.
    ns_owner = {}
    for f in glob.glob(f"{WS}/Definitions/Def_*.lean"):
        for l in open(f, encoding="utf-8"):
            if l.startswith("namespace "):
                parts = l.split()
                if len(parts) >= 2:
                    ns_owner.setdefault(parts[1], f)
    extra = set()
    for ns, pre in ns_preamble.items():
        for _r, _i, l in pre:
            if l.startswith("open "):
                for tok in l.split()[1:]:
                    if "." not in tok:
                        continue
                    owner = ns_owner.get(tok)
                    if owner:
                        mod = "Definitions." + os.path.basename(owner)[:-5]
                        extra.add(mod)
    for imp in sorted(extra - imports - forced_imports):
        out.append("import " + imp)
    out.append("")
    out.append("variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]")
    seen_pre = set()
    SAFE_VARS = {"Type", "Prop", "outParam", "inOut", "self", "Submodule",
                 "NormedAddCommGroup", "NormedSpace", "InnerProductSpace",
                 "CompleteSpace", "ENNReal", "ℕ", "ℤ", "ℚ", "ℝ", "ℂ"}
    for rel, pre in global_pres:
        curated = []
        for l in pre:
            if l.rstrip().endswith(" in"):
                continue          # dangling 'set_option ... in' belongs to the next decl
            if l.startswith("variable "):
                toks = re.findall(r"[A-Za-z_ℕℤℚℝℂ][A-Za-z_0-9']*", l)
                bad = [t for t in toks
                       if len(t) > 1 and t[0].isupper() and t not in SAFE_VARS]
                if bad:
                    continue      # variable references chapter-specific types
            curated.append(l)
        if not curated:
            continue
        key = tuple(curated)
        if key in seen_pre:
            continue
        seen_pre.add(key)
        out.append("")
        out.append(f"-- global preamble carried over from {rel}")
        for l in curated:
            out.append(l)
    # Emission order: a namespace whose decls are referenced by another must be
    # emitted FIRST (Lean needs the declaration before the use).  Topo-sort by
    # cross-namespace references among emitted decls, tie-break by depth/name.
    decl_owner = {}
    for _ns, _es in ns_blocks.items():
        for _e in _es:
            decl_owner.setdefault(_e["name"], set()).add(_ns)
            if "." in _e["name"]:
                decl_owner.setdefault(_e["name"].split(".")[-1], set()).add(_ns)
    ns_deps = {k: set() for k in ns_blocks}
    for _ns, _es in ns_blocks.items():
        for _e in _es:
            for _tok in re.findall(r"[A-Za-z_][A-Za-z_0-9']*", _e["text"]):
                _owners = decl_owner.get(_tok, ())
                # only single-owner bare names give a reliable ordering edge;
                # ambiguous ones (same bare name in several carried namespaces)
                # create false cycles.
                if len(_owners) == 1:
                    _o = next(iter(_owners))
                    if _o != _ns:
                        ns_deps[_ns].add(_o)
    _ns_state = {}
    ns_order = []

    def _ns_visit(_k):
        st = _ns_state.get(_k, 0)
        if st == 2:
            return
        if st == 1:
            print(f"  NS-CYCLE involving {_k}", file=sys.stderr)
            return
        _ns_state[_k] = 1
        for _d in sorted(ns_deps[_k], key=lambda s: (-s.count("."), s)):
            if _d in ns_blocks:
                _ns_visit(_d)
        _ns_state[_k] = 2
        ns_order.append(_k)

    for _k in sorted(ns_blocks, key=lambda s: (-s.count("."), s)):
        _ns_visit(_k)

    EMITTED_FULL = set()
    for ns in ns_order:
        decls = []
        for e in ns_blocks[ns]:
            if e["full"] in EMITTED_FULL:
                continue
            EMITTED_FULL.add(e["full"])
            decls.append(e)
        decls.sort(key=lambda e: (e["rel"], e["s"]))
        out.append("")
        out.append(f"namespace {ns}")
        out.append("")
        # ancestor opens first: nested namespaces inherit outer opens
        seen_lines = set()
        parts = ns.split(".")
        for k in range(1, len(parts) + 1):
            anc = ".".join(parts[:k])
            for _r, _i, l in ns_preamble.get(anc, []):
                if not l.startswith("open "):
                    continue
                for ol in broaden_opens([l]):
                    if ol not in seen_lines:
                        seen_lines.add(ol)
                        out.append(ol)
        out.append("")
        # depth-0 (ns-level) variables of this namespace + ancestors, source order
        d0_vars, seen_d0 = [], set()
        for k in range(1, len(parts) + 1):
            anc = ".".join(parts[:k])
            for _r, _i, l in ns_preamble.get(anc, []):
                if l.startswith("variable ") and l not in seen_d0:
                    seen_d0.add(l)
                    d0_vars.append(l)
        d0_set = set(d0_vars)
        emitted_d0 = set()
        emitted_at = {}                # section depth -> set(lines)
        cur_path = ()
        last_cluster = None

        def in_scope(level):
            s = set(emitted_d0)
            for dd in range(1, level + 1):
                s |= emitted_at.get(dd, set())
            return s

        for e in decls:
            sec_path = e["sec_path"]
            sec_vars = [(d, l) for (_i, d, l) in e["vars"]]
            projected = project_vars(d0_vars + [l for (_d, l) in sec_vars])
            d0_part = [l for l in projected if l in d0_set]
            sec_part = [l for l in projected if l not in d0_set]
            # 1. close sections down to a common prefix
            while cur_path and (len(cur_path) > len(sec_path)
                                or sec_path[:len(cur_path)] != cur_path):
                d = len(cur_path)
                emitted_at.pop(d, None)
                nm = sec_name(cur_path[-1])
                out.append("end " + nm if nm and nm != "noncomputable section" else "end")
                out.append("")
                cur_path = cur_path[:-1]
            # 2. new depth-0 variables live outside every section: if any is
            #    new and a section is physically open, close them all first
            #    (step 4 reopens what this decl needs; emitted_at is pruned so
            #    the reopened levels re-emit their variables).
            new_d0 = [l for l in d0_part if l not in emitted_d0]
            while new_d0 and cur_path:
                d = len(cur_path)
                emitted_at.pop(d, None)
                nm = sec_name(cur_path[-1])
                out.append("end " + nm if nm and nm != "noncomputable section" else "end")
                out.append("")
                cur_path = cur_path[:-1]
            for l in new_d0:
                emitted_d0.add(l)
                out.append(l)
            # 3. section-scoped variables whose section is already open:
            #    emit them now, before opening anything deeper, and register
            #    them at their own depth so they survive deeper closes.
            scope = in_scope(len(cur_path))
            depth_of = {l: d for (d, l) in sec_vars}
            for l in sec_part:
                if l not in scope and depth_of.get(l, 99) <= len(cur_path):
                    out.append(l)
                    emitted_at.setdefault(depth_of[l], set()).add(l)
                    scope.add(l)
            if os.environ.get("LEAFGAP_DEBUG"):
                print(f"DBG {ns} {e['name']} sec_path={sec_path} d0={d0_part} "
                      f"sec_part={sec_part} depth_of={depth_of}", file=sys.stderr)
            # 4. open the sections this decl needs, emitting each level's
            #    fresh variables right after its `section` line
            for k in range(len(cur_path), len(sec_path)):
                nm = sec_name(sec_path[k])
                out.append(nm if nm == "noncomputable section" else
                           (f"section {nm}" if nm else "section"))
                emitted_at.setdefault(k + 1, set())
                cur_path = sec_path[:k + 1]
                scope = in_scope(len(cur_path))
                for l in sec_part:
                    if l not in scope and depth_of.get(l, 99) == k + 1:
                        out.append(l)
                        emitted_at[k + 1].add(l)
                        scope.add(l)
            # 5. anything still fresh at the deepest level (defensive)
            scope = in_scope(len(cur_path))
            for l in sec_part:
                if l not in scope and depth_of.get(l, 99) == len(cur_path):
                    out.append(l)
                    emitted_at.setdefault(len(cur_path), set()).add(l)
            # 6. emit the decl, with a cluster marker on each run boundary
            cluster = (e["rel"], e["sec_path"])
            if cluster != last_cluster:
                out.append(f"-- [{e['name']} cluster]")
                last_cluster = cluster
            out.append(e["text"])
            out.append("")
        while cur_path:
            nm = sec_name(cur_path[-1])
            out.append("end " + nm if nm and nm != "noncomputable section" else "end")
            out.append("")
            cur_path = cur_path[:-1]
        out.append("end " + ns)
    body = "\n".join(out).rstrip() + "\n"
    n_decls = sum(len(v) for v in ns_blocks.values())
    print(f"{len(ns_blocks)} namespace(s), {n_decls} decl(s), {len(body.splitlines())} line(s)")
    if args.write:
        with open(f"{WS}/Definitions/Def_ChapterLeafGaps.lean", "w") as fh:
            fh.write(body)
        print("wrote Definitions/Def_ChapterLeafGaps.lean")
    return 0


if __name__ == "__main__":
    sys.exit(main())
