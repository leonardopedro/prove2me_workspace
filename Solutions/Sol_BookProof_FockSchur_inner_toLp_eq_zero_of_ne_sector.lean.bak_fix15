-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.inner_toLp_eq_zero_of_ne_sector
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSecondQuantization_inner_toLp
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n m : ℕ} {u v : FockAlg} (hu : InSector n u)
    (hv : InSector m v) (hnm : n ≠ m) : (inner ℂ (toLp u) (toLp v) : ℂ) = 0 := by

  rw [inner_toLp]
  refine Finset.sum_eq_zero fun α hα => ?_
  have hvz : v α = 0 := by
    by_contra hc
    have h1 := hu α hα
    have h2 := hv α (Finsupp.mem_support_iff.mpr hc)
    exact hnm (h1 ▸ h2 ▸ rfl)
  rw [hvz, mul_zero]
