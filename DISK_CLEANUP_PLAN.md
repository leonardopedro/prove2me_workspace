# Disk Cleanup Plan — prove2me workspace

**Status: PARTIALLY EXECUTED — updated 2026-09-24 after your deletions.**
This file is a living ledger: each item is marked `DONE`, `REMAINING`, or
`KEEP`. No commands from this update have been run; only the plan text changed.

## Current state (after your deletions, 2026-09-24)

| Mount | Used | Free | % | vs. original survey |
|---|---|---|---|---|
| data drive `/media/leo/e7ed9d6f-…/` | 151 G / 224 G | **69 G** | 69% | was 212 G used / ~9.9 G free (96%) |
| root `/` | 78 G / 100 G | **20 G** | 80% | was 93 G / 5.5 G free (95%) |
| `/home/leo` (on `/`) | 28 G | — | — | was 45 G |

**Approx. reclaimed so far: ~61 G on data drive + ~15 G on root.**

Active repos (pushed clean, DO NOT TOUCH): `../unfer`, `../timepiece`,
`../test`, and this workspace.

---

## Tier 1 — Safe & rebuildable

### Cargo target trees

| Path | Size | Status |
|---|---|---|
| `unfer/src-rust/target` | 51 G | **DONE** (gone) |
| `claurst/src-rust/target` | 23 G | **DONE** (gone) |
| `zentinel/target` | 9.3 G | **DONE** (gone) |
| `pattern/target` | 4.2 G | **DONE** (gone) |
| `fock-sirk/target` | 3.5 G | **DONE** (gone) |
| `claurst_old/src-rust/target` | 6.7 G | **DONE** (gone; empty 4 K stub left — harmless) |
| `matchlock_bk/persistence/target` etc. | ~5 G | **DONE** (gone with matchlock cleanup) |
| `australVM/safestos/cranelift/target` | 28 G | **DONE** 2026-09-24 (was mislabeled “VM disk”; source 5.3 M kept, git clean) |
| **`velysterm/target`** | **56 G** | **REMAINING** — largest single reclaim left; `cargo build` rebuilds |
| **`unfer/target`** (workspace root, not `src-rust/`) | **52 G** | **REMAINING** — plan originally pointed at `src-rust/target`; the live tree is `unfer/target` (mtime 2026-07-01) |
| **`unfer/demo_module/data_source/target`** | **2.3 G** | **REMAINING** |
| `verifiedUniqueAliases (copy 3–4)/target` | ~4–6 G inside copies | counted under Tier 2 copies |
| `australVM/arctic_authority/target` | 405 M | **REMAINING** (optional) |
| `cloud-hypervisor-build/crosvm/target` | 530 M | **REMAINING** (optional) |
| `aeneas/charon/charon/target` + others | ~490 M | **REMAINING** (optional) |

### Lean `.lake` trees

| Path | Size | Status |
|---|---|---|
| `/home/leo/.lake` | 7.6 G | **DONE** (gone) |
| **`prove2me_workspace/.lake`** | **8.4 G** | **REMAINING** — optional; `PROVE2ME_SKIP_LOCAL_COMPILE=1` users don't need it |
| **`timepiece/.lake`** | **8.3 G** | **REMAINING** — rebuild via `lake update` / `lake build` if needed |
| **`timepiece331/.lake`** | **8.3 G** | **REMAINING** — inside Tier 2 `timepiece331` snapshot |
| **data-drive root `…/eb154ba/.lake`** | **7.6 G** | **REMAINING** (was already in plan; not under `~`) |
| `australVM/arctic_authority/verify/.lake` | 593 M | **REMAINING** (optional) |

### Caches (`~/.cache`, npm, apt, journal)

| Path | Size now | Status |
|---|---|---|
| `~/.cache` (whole) | **2.1 G** (was 8.2 G) | **DONE** per Tier 1C note below |
| `~/.npm` / `_cacache` | **~174 M** (`_npx` only; `_cacache` gone) | **DONE** (was 3.7 G) |
| `~/.cache/uv` | 35 M | **DONE** (was 1.4 G; cleaned) |
| `~/.cache/mozilla` | 256 K | **DONE** (was 1.8 G) |
| `~/.cache/mathlib` | 878 M | **KEEP** (active Lean) |
| `~/.cache/zotero` + thumbnails | gone / 1.3 M | **DONE** |
| `/var/cache/apt` | 0 archives / 119 M lists | **DONE** (`apt clean` ran) |
| `/var/log/journal` | 173 M | **DONE** (was 533 M; under 200 M vacuum) |

**Tier 1 estimated remaining reclaim: ~130 G** if you take `velysterm/target` +
`unfer/target` + the four large `.lake` trees + npm cache.

---

## Tier 1B — Installed packages

| Package(s) | Status |
|---|---|
| `nsight-compute` / `nsight-systems` / `cuda-nsight*` (~2839 MB) | **DONE** — none installed |
| `nvidia-cuda-dev` (2292 MB) | **DONE** — not installed; `libcuda1` + toolkit config metas remain (runtime OK) |
| `qemu-system-{arm,mips,ppc,sparc,misc}` (~390 MB) | **DONE** — only `qemu-system-x86` + common/gui remain |
| Old kernels `6.18.34` / `6.18.36` (~400 MB) | **DONE** — only running `6.18.48` + `linux-image-deepin-amd64` |
| `cherrystudio` (534 M) | **DONE** — not installed (`pinokio` still installed) |
| Doc pkgs (`bzip2-doc`, `golang-doc`, `nvidia-cuda-toolkit-doc`, …) | **PARTIAL** — many gone; still installed: `nodejs-doc`, `ruby3.3-doc` |
| antigravity apt source | **DONE** — removed from `/etc/apt/sources.list.d` |
| **`deepin-theme-{flow,hazy-color,macaron,nirvana,organic-glass,origin,square,vintage}`** | **REMAINING** — all still installed except macaron already absent; keep `bloom` (+ `bloom-dark` if you use dark mode) |
| **`deepin-desktop-theme` + `deepin-desktop-environment-core`** | **REMAINING** — only purge if you accept losing the default Bloom desktop theme meta (apps/DDE itself stay) |
| **`deepin-systemassistant-knowledge`** | **REMAINING** — 740 MB offline KB |
| **`oci-cli` + `google-cloud-cli` + `google-cloud-cli-anthoscli`** | **REMAINING** — ~1126 MB; `gcloud`/`oci` on PATH |
| **`pinokio`** | **REMAINING** — 383 MB |
| **`golang` full stack** | **REMAINING** — ~350 MB if you don't write Go |
| **`flatpak`** | **REMAINING** — store still 4 K; remove package if unused |
| **linglong store `/var/lib/linglong`** | **REMAINING** — **5.6 G** |
| Purge-remnants (`rc` = config-only) | **~140 pkgs still `rc`** — `dpkg --purge` after reviewing list |
| **Stale apt source `intel-sgx.list`** | **REMAINING** — still present (focal SGX repo) |

**Tier 1B estimated remaining reclaim: ~8–10 G** (linglong + themes + cloud CLIs + systemassistant + docs + rc purge).

Dry-run before any purge (unchanged rule):

```bash
apt-get -s purge <pkgs>     # always inspect
sudo apt-get purge <pkgs>
```

---

## Tier 1C — `~/.cache` and `~/.local`

**DONE 2026-09-24** (user-approved safe list). Result then: `~/.cache` 8.2 G → 2.5 G, `~/.local` 6.6 G → 5.2 G, root free 9.4 G → 15 G (~6 G). Now: `~/.cache` **2.1 G**, `~/.local` **5.3 G**.

Kept as planned: mathlib, nix cache, `opencode.db` (active), mise, deepin-anything index, playwright 1.57.0, Claude `2.1.205`.

Claude versions dir now only `2.1.205` — **DONE**.

---

## Tier 2 — Stale duplicates

| Item | Size now | Status |
|---|---|---|
| **`verifiedUniqueAliases` + copies** (`(copiar)`, `(copy)`, `(copy 1–4)`) | **~21 G** total (original 7.8 G + copies; copy 4 alone had 9.8 G → now ~3.9 G after partial target wipe inside copies) | **REMAINING** — keep original with `.git`; copies deletable after glance |
| **`timepiece331`** (snapshot of `timepiece`, no `.git`) | **8.4 G** (incl. its `.lake` 8.3 G) | **REMAINING** |
| **`claurst_old`** | **14 M** (was 6.7 G) | **DONE** effectively — only tiny remnant left |
| **`matchlock_bk` / `matchlock_persistence`** | **355 M / 229 M** (was 2.5 G / 2.4 G — tars gone) | **DONE** mostly; optional remainder |
| `matchlock (copy)` × many + patch-kit dirs | ~50–72 M each | **REMAINING** (small; optional) |
| **`Old Firefox Data`** | **1.4 G** | **REMAINING** |
| **`usbdrive`** | **1.1 G** | **REMAINING** |
| `Definitions.backup` | — | **REMAINING** (check before rm) |
| **`/home/leo/Downloads`** | **1.1 G** | **REMAINING** — review individually |

**Tier 2 estimated remaining reclaim: ~33 G.**

---

## Tier 3 — Explicit confirmation (likely keep unless you say otherwise)

| Item | Size now | Status / consideration |
|---|---|---|
| **`leonardo`** | — | **DONE** (gone; was 31 G, mtime 2023) |
| **`nix` store + disk images** | store remains (was ~14 G total; **both `nixos-disk-image` stores gone**) | **PARTIAL** — GC roots `zentinel/result`, `cloud-hypervisor-build/result` may still point at nothing useful; `nix-collect-garbage -d` / `sudo /nix/var/nix/profiles/default/bin/nix-store --delete` still open |
| **`ostree` `/ostree/repo`** | **9.8 G** | **KEEP** — live booted deployment (see Tier R) |
| **Deepin “First backup” snapshot** | **117 M** | **KEEP** unless abandoning rollback (Tier R) |
| **`/persistent/ostree/repo` (pkg history)** | **20 G** | audit with `ostree prune --no-prune` only (Tier R-b) |
| **`containers` storage** | **0 / gone** | **DONE** |
| **`australVM/safestos`** | 5.3 M source only | **DONE** (target deleted; not a VM disk) |
| **`/persistent`** | **41 G** | **KEEP** overall — breakdown in Tier R (`ostree` 20 G / `var` 15 G / `overlay` 6.2 G) |
| **`~/.gemini`** | — | **DONE** (gone; was 4.7 G) |
| **`~/.opam`** | **4.8 G** (default 2.7 G + 5.3.0 2.1 G) | **REMAINING decide** — prune unused opam switches if no OCaml work |
| **`~/.rustup`** + `~/.cargo` | **1.4 G + 419 M** | **REMAINING decide** — `rustup toolchain uninstall` unused |
| **`~/.config`** | **1.3 G** | **KEEP** (tool configs; review only if bloated) |
| **`~/.recoll`** | **932 M** | **REMAINING decide** — search index, costly to rebuild |
| **`~/.elan`** *(new — not in original survey)* | **5.5 G** | **REMAINING decide** — Lean/elan toolchains; keep the one `lake` uses, `elan toolchain remove` the rest |

**Tier 3 estimated remaining reclaim (if you clear opam switches + rustup + recoll + optional nix GC): ~5–8 G**, plus **~0 from persistent/ostree unless you explicitly authorize**.

---

## Tier R — Root partition `/` (survey 2026-09-24)

Target: root is **78 G / 100 G (80%)**; goal ≈60%. Everything below lives on
`/dev/nvme0n1p5` (btrfs) — the data drive (`p8`) is separate.

### Why `du /` ≈ 90 G but `df` says 78 G (double-count map)

| Path | Real role | Do not also count as… |
|---|---|---|
| `/var` | bind of `/persistent/var` (15 G) | `/persistent` total |
| `/usr/local` ≡ `/var/usrlocal` ≡ `/persistent/var/usrlocal` | same inode (29:275035) | any second copy |
| `/sysroot/ostree` ≡ `/ostree` | same inode (29:258) | each other |
| `/persistent` | 41 G root store: `ostree` 20 G + `var` 15 G + `overlay` 6.2 G | its children again |
| `/ostree` vs `/persistent/ostree` | **two different repos** (9.8 G / 20 G; 2 vs 6 commits) | not hardlink-identical |

Approximate unique bulk: `/home` **28 G** + `/usr` **14 G** + `/persistent` **41 G**
(includes var/usrlocal) + `/ostree` **9.8 G** + `/opt` **2.6 G** ≈ matches `df`.

### Deepin / ostree backup (yes — there is one)

| What | Where | Size | Notes |
|---|---|---|---|
| **First system backup** (“System initialization backup”, 2025-07-30) | `/persistent/ostree/snapshot/e9e3412c32574aa1` + refs in both repos | **117 M** metadata | `setting.conf` names it; incremental. Keep unless you refuse all rollback. |
| **Deepin package/object repo** (immutable packages: samba, libpam, …) | `/persistent/ostree/repo` | **20 G** | 6 commits; remote `community-packages.deepin.com` … `immutable-repos`. Re-fetchable if needed; **not** a casual `rm`. Prune via `ostree prune` only. |
| **Live OS object store** | `/ostree/repo` | **9.8 G** | refs: `deployment/0/0` + snapshot. **KEEP** — booted system (`/run/ostree-booted`). |
| Overlay uppers (modified `/usr` `/opt` `/etc`) | `/persistent/overlay/data` | **6.2 G** (opt layer 6.1 G) | live upperdirs — **do not rm** |
| Rollback tooling | `dde-rollback`, `deepin-immutable-cleanup.{service,timer}` | — | timer enabled; `uos-recovery` is `rc` only |

```bash
# Safe audit only (no delete):
sudo ostree --repo=/persistent/ostree/repo prune --no-prune --refs-only -v
sudo ostree --repo=/persistent/ostree/repo refs
# Delete only after you understand refs (example — NOT run by default):
# sudo ostree --repo=/persistent/ostree/repo prune --refs-only --depth=1 -v   # dry: add --no-prune first
```

**Verdict:** the “backup” itself is **117 M**; the **20 G** is the immutable
package object DB + history, not a full disk image. Highest-risk item on `/`.

### R-a. High value / likely safe (user home + caches)

| Candidate | Size | Status / action |
|---|---|---|
| **linglong store** `/var/lib/linglong` | **5.6 G** | REMAINING — purge if no linglong apps |
| **Global npm** `/usr/local/lib/node_modules` | **2.1–2.8 G** | REMAINING — `@kilocode`, `kanban`, `@mimo-ai`, `opencode-ai`, `cline`, … `npm -g rm` unused |
| **`~/.elan` Lean toolchains** | **5.5 G** (v4.33.1 2.9 G + v4.28.0 2.6 G) | KEEP both while timepiece needs **v4.28.0** and prove2me **v4.33.1**; remove only after projects agree |
| **`~/.opam/default`** (ocaml 4.13) | **2.7 G** | REMAINING — active switch is `5.3.0`; `opam switch remove default` |
| **`opencode.db`** | **2.4 G** | **KEEP** — active sessions (Tier 1C rule) |
| **Firefox profile** `~/.mozilla/firefox` | **1.2 G** | REMAINING decide — mtime 2025-07-30 |
| **deepin fulltext-index** | **1.1 G** | REMAINING decide — DE reindexes slowly |
| **`~/Downloads`** | **1.1 G** | REMAINING — triage (also Tier 2) |
| **`~/.recoll`** | **932 M** | REMAINING decide (Tier 3) |
| **gcloud** `/opt/google` + `/usr/lib/google-cloud-sdk` + `~/.config/gcloud` | **~1.4 G** | REMAINING — purge `google-cloud-cli*` if unused |
| **oci-cli** `/opt/oci-cli` | **667 M** | REMAINING — purge `oci-cli` if unused |
| **`deepin-systemassistant-knowledge`** | **741 M** | REMAINING (Tier 1B) |
| **Brave profile** `~/.config/BraveSoftware` | **639 M** | REMAINING decide |
| **`~/.sdkman`** scala+sbt | **472 M** | REMAINING if no Scala |
| **`~/.vibe`** (mostly logs) | **463 M** | REMAINING — logs safe to wipe |
| **`~/.risc0`** (incl. 290 M 2025 tarball) | **424 M** | REMAINING if no RISC Zero |
| **`~/.wasmer`** (2025-10) | **410 M** | REMAINING if no Wasmer |
| **pinokio** `/opt/Pinokio` | **385 M** | REMAINING (Tier 1B) |
| **deepin-anything index** | **480 M** | KEEP while DE search runs |
| **apt lists** `/var/lib/apt/lists` | **302 M** | REMAINING — `sudo rm` lists then `apt update` |
| **appstore-daemon lists** | **297 M** | REMAINING if not using Deepin store |
| **lastore** `/var/cache/lastore` | **142 M** | REMAINING — updater cache |
| **opencode snapshot/log** | **89 + 32 M** | optional wipe (not `opencode.db`) |
| **old modules `6.12.33`** | **171 M** | REMAINING — keep running `6.18.48` only |
| **ucf cache** | **107 M** | REMAINING — sudo clean |
| **`/var/mail/leo`** | **42 M** | review then truncate |
| **`intel-sgx.list`** stale apt source | small | REMAINING — delete file |
| **Themes** flow/hazy/nirvana/organic/origin/square/vintage (+ optional bloom-dark) | ~400 M pkg | REMAINING (Tier 1B) |
| **Go stack**, **flatpak** (store 4 K), **`zig-0`** | ~350 M + small + 365 M | REMAINING decide |
| **i386 multiarch** `/usr/lib/i386-linux-gnu` | **616 M** | only if drop `i386` foreign arch |
| **`rc` packages** | ~136 pkgs | tidy, small disk win |

### R-b. Needs explicit authorization (system / immutable)

| Candidate | Size | Rule |
|---|---|---|
| **CUDA 13.1** `/usr/local/cuda-13.1` + apt `cuda-*-dev` / `libcublas-dev` … | **4.8 G tree + multi-G pkgs** | only if never compile CUDA; **keep** `libcuda1` + driver + runtime |
| **`/persistent/ostree/repo` package history** | **20 G** | `ostree prune` with dry-run only; never `rm -rf` |
| **`/ostree/repo`** | **9.8 G** | **KEEP** — live deployment |
| **Deepin “First backup” snapshot** | **117 M** | keep unless abandoning rollback |
| **`/persistent/overlay`** | **6.2 G** | **KEEP** — live upperdirs |
| **`/persistent/var`** | **15 G** | = `/var`; clean via normal `/var` paths only |

**Tier R estimated reclaim without touching R-b system items: ~12–18 G**
(linglong + npm globals + opam default + browser/CLI junk + indexes + themes).
With CUDA-dev purge + i386 drop: **+4–8 G** more. Reaching **~60%** may
require an R-b decision (CUDA toolkit or ostree package prune), not one hidden file.

---

## Suggested order of operations (remaining only)

1. **Biggest win:** `velysterm/target` (56 G) + `unfer/target` (52 G) + optional `unfer/demo_module/data_source/target` (2.3 G) → ~110 G data drive.
2. `.lake` trees you don't need right now: data-root 7.6 G, `timepiece331` with snapshot, workspace 8.4 G if skip-local-compile.
3. Tier 2 spot-check then delete: `verifiedUniqueAliases` copies, `Old Firefox Data`, `usbdrive`, `Downloads` review.
4. Tier 1B purges (dry-run first): linglong 5.6 G, themes you don't use, cloud CLIs, systemassistant, `rc` purge, remove `intel-sgx.list`.
5. Tier 3: elan toolchains, opam switches, rustup, recoll; nix GC if roots are dead.
6. **Tier R (root):** R-a first (npm -g, opam default, gcloud/oci, Downloads, indexes); only then decide R-b (CUDA-dev, i386, ostree prune dry-run).
7. Re-run `df -h` and record actual reclaim here.

## Safety rules (unchanged)

- `credentials.json` and `/home/leo/.config/opencode/opencode.json` are **never** touched (gitignored; plaintext keys).
- Active repos: only their **gitignored** `target` / `.lake` are candidates, never tracked files.
- No `lake build` / `cargo build` as a matter of course — only after you ask for a compile.
- Nothing is pushed or committed as part of cleanup.
- Package removal: **always `apt-get -s purge` first**; never bulk-purge `dde-*`/core `deepin-*`; keep NVIDIA driver + `libcuda1`/CUDA runtime.
- **Root/`/persistent`:** never `rm -rf` under `/ostree`, `/persistent/ostree`, `/persistent/overlay`; use `ostree prune --no-prune` to audit first. Deepin “First backup” snapshot is only 117 M — keep unless you drop rollback.

---
*Updated 2026-09-24: ledger reflects user-executed deletions + **Tier R (root)** survey (ostree/Deepin backup, double-count map). Plan text only — no new deletions were run.*
