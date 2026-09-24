# Disk Cleanup Plan — prove2me workspace

**Status: PROPOSED — awaiting your review. NOTHING has been deleted.**
Survey date: 2026-09-24. Every command below is *suggested only*; review each
tier and approve before any execution.

## Current state

| Mount | Used | Free | % |
|---|---|---|---|
| data drive `/media/leo/e7ed9d6f-…/` | 212 G / 224 G | ~9.9 G | 96% |
| root `/` | 93 G / 100 G | 5.5 G | 95% |
| `/home/leo` (on `/`) | 45 G | — | — |

`du` reports ~403 G on the data drive vs 212 G allocated — the gap is
duplicate/overlapping trees (copies, `target`, `.lake`). Cleanup target: reclaim
**~150–200 G** safely without touching active repos or credentials.

Active repos (pushed clean, DO NOT TOUCH): `../unfer`, `../timepiece`,
`../test`, and this workspace.

---

## Tier 1 — Safe & rebuildable (approve freely)

Build artifacts and caches. All gitignored / regenerable with a standard
command. Low risk; worst case is a slower first rebuild.

| What | Where | Size | Rebuild / restore |
|---|---|---|---|
| Cargo debug+release build trees | `unfer/src-rust/target` (48 G debug + 3.5 G release), `velysterm/target` 56 G, `claurst/src-rust/target` 23 G, `zentinel/target` 9.3 G, `claurst_old/target` 6.7 G, `pattern/target` 4.2 G, `fock-sirk/target` 3.5 G, `matchlock_bk/persistence/target` ~5 G, verifiedUniqueAliases copies `target` ~10 G | **~170 G** | `cargo build` |
| Lean `.lake` trees | workspace `.lake` 8.4 G, `timepiece/.lake` 8.3 G, `timepiece331/.lake` 8.3 G, root `.lake` 7.6 G | **~33 G** | `lake build` / `lake update` |
| npm cache | `/home/leo/.npm/_cacache` | 3.5 G | auto on next install |
| uv cache | `/home/leo/.cache/uv` | 1.4 G | auto |
| Mozilla cache | `/home/leo/.cache/mozilla` | 1.8 G | auto |
| mathlib cache | `/home/leo/.cache/mathlib` | 878 M | re-download as needed |
| Zotero + thumbnails | `/home/leo/.cache/zotero` 749 M, `…/thumbnails` 379 M | 1.1 G | regenerate |
| apt package cache | `/var/cache/apt` | 110 M | `apt clean` |
| systemd journal | `/var/log/journal` | 533 M | `journalctl --vacuum-size=200M` |

Suggested commands (Tier 1 only):

```bash
# Cargo target dirs — run from each project root, or the blanket form:
rm -rf /media/leo/e7ed9d6f-…/unfer/src-rust/target \
       /media/leo/e7ed9d6f-…/velysterm/target \
       /media/leo/e7ed9d6f-…/claurst/src-rust/target \
       /media/leo/e7ed9d6f-…/zentinel/target \
       /media/leo/e7ed9d6f-…/claurst_old/target \
       /media/leo/e7ed9d6f-…/pattern/target \
       /media/leo/e7ed9d6f-…/fock-sirk/target

# .lake trees (active workspace = optional keep)
rm -rf /media/leo/e7ed9d6f-…/prove2me_workspace/.lake \
       /media/leo/e7ed9d6f-…/timepiece/.lake \
       /media/leo/e7ed9d6f-…/timepiece331/.lake \
       /home/leo/.lake

# Caches
rm -rf /home/leo/.npm/_cacache /home/leo/.cache/uv \
       /home/leo/.cache/mozilla /home/leo/.cache/thumbnails
sudo apt clean
sudo journalctl --vacuum-size=200M
```

**Tier 1 estimated reclaim: ~200 G** (mostly cargo `target`).

> Note: `PROVE2ME_SKIP_LOCAL_COMPILE=1` users never need the workspace `.lake`;
> rebuilding is via `lake env lean` when a Lean toolchain is present.

---

## Tier 2 — Stale duplicates (approve after a glance)

Old copies/backups of trees that also exist elsewhere. Verify the survivor is
current before deleting.

| Item | Size | Why it looks stale |
|---|---|---|
| `verifiedUniqueAliases (copy 1–4)` + `(copy …)` fragments | ~18 G total (copy 4 alone 9.8 G, mtime 2026-04-27) | desktop-style duplicates; original `verifiedUniqueAliases` 7.8 G has a live `.git` |
| `timepiece331` | 8.4 G | snapshot copy of `timepiece` (no `.git`) |
| `claurst_old` | 6.7 G | superseded by `claurst` (2026-04-29) |
| `matchlock (copy N)` × many, `matchlock_bk`, `matchlock_persistence` | ~150 M + 2.5 G + 2.4 G | backups from 2026-02-19 |
| `Definitions.backup` | — | explicit backup |
| `Old Firefox Data` | 1.4 G | 2026-04-08 browser migration leftover |
| `usbdrive` | 1.1 G | external-copy remnant |
| `/home/leo/Downloads` | 1.1 G | old web-page saves + PDFs, review individually |

```bash
# Example — review each before rm; keep the original verifiedUniqueAliases/.git
rm -rf "/media/leo/e7ed9d6f-…/verifiedUniqueAliases (copy 1)" \
       "/media/leo/e7ed9d6f-…/verifiedUniqueAliases (copy 2)" \
       "/media/leo/e7ed9d6f-…/verifiedUniqueAliases (copy 3)" \
       "/media/leo/e7ed9d6f-…/verifiedUniqueAliases (copy 4)"
rm -rf /media/leo/e7ed9d6f-…/timepiece331 \
       /media/leo/e7ed9d6f-…/claurst_old \
       /media/leo/e7ed9d6f-…/matchlock_bk \
       /media/leo/e7ed9d6f-…/matchlock_persistence \
       "/media/leo/e7ed9d6f-…/Old Firefox Data" \
       /media/leo/e7ed9d6f-…/usbdrive
```

**Tier 2 estimated reclaim: ~45 G.**

---

## Tier 3 — Needs your explicit confirmation (likely keep)

Large but potentially load-bearing. Do **not** delete without a decision.

| Item | Size | Consideration |
|---|---|---|
| `leonardo` | 31 G | mtime 2023-03-30 — very stale, but confirm it's not a source of truth |
| `nix` store + disk images | 43 G (incl. `nixos.img` 3.9 G + 3.4 G) | use `nix-collect-garbage` rather than `rm`; images may be install media |
| `ostree` | 22 G | system/OS images — managed, don't hand-delete |
| `containers` (storage 6.7 G + tmp 1.4 G) | 8.1 G | `podman system prune` / `docker system prune` if applicable |
| `australVM` `safestos` | 28 G | VM disk — delete only if VM is retired |
| `/persistent` | 42 G | system persistence — out of scope unless you say so |
| `/home/leo/.gemini`, `.opam`, `.rustup`, `.config` | 4.7 G + 4.8 G + 1.4 G + 3.0 G | toolchains/configs; prune only unused ones |
| `/home/leo/.recoll` | 932 M | search index; rebuildable but reindex is costly |

Safer variants for Tier 3:

```bash
nix-collect-garbage -d            # nix, instead of rm
sudo podman system prune -af      # or docker system prune -af
# australVM/safestos, leonardo, /persistent: manual decision only
```

---

## Suggested order of operations

1. Approve **Tier 1** → run → re-check `df -h` and the four repos' `git status`.
2. Spot-check **Tier 2** survivors (open originals, confirm mtimes) → run.
3. Decide item-by-item on **Tier 3**.
4. Re-run survey (`df -h`, `du -sh` per tree) and record actual reclaim here.

## Safety rules

- `credentials.json` and `/home/leo/.config/opencode/opencode.json` are
  **never** touched (gitignored; contains plaintext keys).
- Active repos `../unfer`, `../timepiece`, `../test`, this workspace: only
  their **gitignored** `target` / `.lake` are candidates, never tracked files.
- No `lake build` / `cargo build` is run as a matter of course — only after you
  ask for a compile.
- Nothing is pushed or committed as part of cleanup.

---
*Plan only — no commands from this file have been executed.*
