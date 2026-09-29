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

## Tier 1B — Installed packages (Debian + Deepin / linglong) — survey added 2026-09-24

System: **Deepin V23 (crimson)** base — 3342 packages installed, of which
~1379 carry `deepin`/`dde` branding (the desktop itself: keep).
`linglong` is Deepin's own package format (`linglong-bin/builder/pica/…`);
its store at `/var/lib/linglong` holds **5.6 G** of app payloads.

Nothing below is executed — check each box mentally before approving.

### 1B-a. Clearly unneeded / safe to purge (large wins)

| Package(s) | Size | Why unneeded |
|---|---|---|
| `nvidia-cuda-dev` | **2292 MB** | CUDA *headers/static libs* for app builds; runtime GPU stack (`libcuda1`, driver, `nvidia-smi`) stays — you have a working GTX 1060 + `nvcc 12.2`, but the -dev tree is only needed if you *compile* CUDA code |
| Nsight profilers: `nsight-compute` (2023.2 + 2025.4 + targets), `nsight-systems` (2023.2 + 2025.1 + 2025.5 + targets), `cuda-nsight*` | **~2839 MB** across 10 pkgs | GPU profiling tools; 6 overlapping versions installed. Keep one set max, or all if you actively profile CUDA |
| `qemu-system-{arm,mips,ppc,sparc,misc}` | **~390 MB** | non-x86 emulation; you only need `qemu-system-x86` for local VMs (unless you cross-test ARM images) |
| Old kernels `linux-image-6.18.34` + `6.18.36` + matching `linux-headers-*` (running = **6.18.48**) | **~400 MB** | keep running kernel + one backup; remove 34 & 36 |
| `deepin-theme-{organic-glass,hazy-color,macaron,square,bloom,bloom-dark,flow,origin,nirvana,vintage}` (keep 1–2 you actually use) | **~551 MB** total | 10 optional themes; default theme remains |
| `deepin-systemassistant-knowledge` | **740 MB** | offline knowledge base for Deepin's assistant; removable if you don't use it |
| `oci-cli` (Oracle Cloud) + `google-cloud-cli` + `google-cloud-cli-anthoscli` | **~1126 MB** | cloud CLIs; remove any cloud you don't actively use (`.oci`/`.config/gcloud` configs are tiny/146 M) |
| `cherrystudio` (534 M) + `pinokio` (383 M) | **~917 MB** | GUI app launchers; remove if unused |
| Doc packages: `bzip2-doc`, `golang-doc`, `golang-1.22-doc`, `nvidia-cuda-toolkit-doc`, `libcupti-doc`, `nodejs-doc`, `ruby3.3-doc`, … | **~682 MB** (doc+dbg) | man/doc trees; pure reference |
| Duplicate Java: keep one of `openjdk-17-{jdk,jdk-headless,jre,jre-headless}` + `default-jdk` stack; drop `nvidia-openjdk-8-jre` (Nsight dep) with Nsight | ~300–400 MB | several JRE/JDK flavors coinstalled |
| Go full stack if you don't write Go: `golang`, `golang-1.22{,-go,-src,-doc}` | ~350 MB | remove if unused |
| `flatpak` (store is empty, 4 K) | ~small | installed but no apps; remove package if unused |
| linglong store: `/var/lib/linglong` | **5.6 G** | data dir for linglong apps — clear only if you don't use linglong-installed apps |

**Purge-remnants (`rc` = config-only, 139 pkgs)** — files already gone, configs
left: `thunderbird` (240 M recorded), `antigravity` (690 M recorded — repo key
still in `/etc/apt`), `libreoffice-*` (98 pkgs, only 4 `ii`), `cpis-base`,
`deepin-wine-helper`, old `linux-image-6.18.{24,27}`. Purge frees `/etc` bits
and dpkg metadata (actual disk win is small but tidy).

Suggested (dry-run first — **always** inspect the list):

```bash
# Dry-run any set before real removal:
apt-get -s purge <pkgs>       # shows exactly what would go
sudo apt-get purge <pkgs>
sudo apt-get autoremove       # currently only: libwtmpdb0 ncurses-term

# Example large block (edit to taste after reviewing the dry-run):
sudo apt-get purge nvidia-cuda-dev \
  nsight-compute nsight-compute-2025.4.0 nsight-compute-target \
  nsight-systems nsight-systems-2025.1.3 nsight-systems-2025.5.2 nsight-systems-target \
  cuda-nsight-13-1 cuda-nsight-compute-13-1 cuda-nsight-systems-13-1 \
  qemu-system-arm qemu-system-mips qemu-system-ppc qemu-system-sparc qemu-system-misc \
  linux-image-6.18.34-amd64-desktop-rolling linux-headers-6.18.34-amd64-desktop-rolling \
  linux-image-6.18.36-amd64-desktop-rolling linux-headers-6.18.36-amd64-desktop-rolling \
  deepin-systemassistant-knowledge \
  oci-cli google-cloud-cli google-cloud-cli-anthoscli \
  cherrystudio pinokio \
  bzip2-doc golang-doc golang-1.22-doc nvidia-cuda-toolkit-doc

# Themes: keep your favorites, purge the rest (list first):
dpkg -l 'deepin-theme-*' | awk '/^ii/{print $2}'

# Config remnants + stale apt sources (antigravity, azure-cli, docker, intel-sgx…):
dpkg -l | awk '$1=="rc"{print $2}' | xargs sudo dpkg --purge   # review list first!
sudo rm /etc/apt/sources.list.d/{antigravity.list,azure-cli.sources,docker.list,intel-sgx.list}  # if repos unused

# linglong app store payload (only if you don't use linglong apps):
sudo rm -rf /var/lib/linglong    # OR linglong's own uninstall flow
```

**Tier 1B estimated reclaim: ~13–15 G** (mostly Nsight + cuda-dev + linglong
store + themes/docs/CLIs). Keep CUDA runtime/driver — only `-dev`/profilers go.

### 1B-b. Decide yourself (installed but maybe wanted)

| Package | Size | Notes |
|---|---|---|
| Browsers ×3: `firefox` (315 M) + `brave-browser` (462 M) + `google-chrome-stable` (434 M) | ~1.2 G pkgs; profiles `~/.mozilla` 1.2 G, Brave 639 M, Chrome 181 M | Chrome profile touched most recently (Jun 2); Firefox profile Jul 30 2025, Brave Dec 10 2025 — drop the two you don't use |
| `warp-terminal` | — | if you don't use Warp |
| `deepin-app-store` + `deepin-app-store-runtime` + `deepin-home` + `deepin-home-appstore-daemon` + `deepin-sync-daemon` | ~60–70 M + store data | Deepin's store/sync — only if you never install via it |
| `deepin-*` suite at large (1379 pkgs) | — | this *is* the Deepin desktop; don't bulk-remove `dde-*`/core `deepin-*` without knowing the DE |

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
2. **Tier 1B packages**: dry-run (`apt-get -s purge …`) every block → approve →
   `sudo apt-get purge` → `autoremove`. Keep CUDA runtime/driver.
3. Spot-check **Tier 2** survivors (open originals, confirm mtimes) → run.
4. Decide item-by-item on **Tier 3**.
5. Re-run survey (`df -h`, `du -sh` per tree, `df -h /` after purge) and record
   actual reclaim here.

## Safety rules

- `credentials.json` and `/home/leo/.config/opencode/opencode.json` are
  **never** touched (gitignored; contains plaintext keys).
- Active repos `../unfer`, `../timepiece`, `../test`, this workspace: only
  their **gitignored** `target` / `.lake` are candidates, never tracked files.
- No `lake build` / `cargo build` is run as a matter of course — only after you
  ask for a compile.
- Nothing is pushed or committed as part of cleanup.
- Package removal: **always `apt-get -s purge` first** and read the list;
  never bulk-purge `dde-*`/core `deepin-*` (that's the desktop); keep NVIDIA
  driver + `libcuda1`/`cuda-runtime` — only `-dev`/Nsight/old kernels go.

---
*Plan only — no commands from this file have been executed.*
