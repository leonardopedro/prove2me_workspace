-- Generated from ChapterSphericalBesselODE.lean — solution of BookProof.ChapterSphericalBesselODE.contDiffAt_sbessel
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_sbessel_eq
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_contDiffOn_gIter
open BookProof.ChapterSphericalBesselODE




open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (l : ℕ) {x : ℝ} (hx : x ≠ 0) : ContDiffAt ℝ 2 (sbessel l) x := by

  have hg : ContDiffAt ℝ (⊤ : ℕ∞) (gIter l) x :=
    (contDiffOn_gIter l).contDiffAt (isOpen_ne.mem_nhds hx)
  have hpow : ContDiffAt ℝ (⊤ : ℕ∞) (fun s : ℝ => s ^ l) x := (contDiff_id.pow l).contDiffAt
  have hmul : ContDiffAt ℝ (⊤ : ℕ∞) (fun s : ℝ => s ^ l * gIter l s) x := hpow.mul hg
  have hfun : sbessel l = fun s : ℝ => s ^ l * gIter l s := by
    funext s; rw [sbessel_eq]
  rw [hfun]
  exact hmul.of_le ENat.LEInfty.out
