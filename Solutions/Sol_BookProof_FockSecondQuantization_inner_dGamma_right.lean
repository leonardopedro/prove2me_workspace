-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.inner_dGamma_right
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_annA_eq_zero_of_not_mem_modes
import Theorems.Thm_BookProof_FockSecondQuantization_toLpL_apply
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_eq_sum
import Theorems.Thm_BookProof_FockSecondQuantization_toLp_zero
import Theorems.Thm_BookProof_FockSecondQuantization_inner_annA_creVec
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) {L : Finset ℕ}
    (hv : modes v ⊆ L)
    (hL : ∀ k ∈ modes u ∪ modes v, (col k).support ⊆ L) :
    (inner ℂ (toLp u) (toLp (dGamma col v)) : ℂ)
      = ∑ j ∈ L, ∑ k ∈ L,
        (col j) k * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by

  have hsum : toLp (dGamma col v) = ∑ j ∈ L, toLp (creVec (col j) (annA j v)) := by
    rw [dGamma_eq_sum col hv, ← toLpL_apply, map_sum]
    rfl
  rw [hsum, inner_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases hjv : j ∈ modes v
  · exact inner_annA_creVec col u v j (hL j (Finset.mem_union_right _ hjv))
  · have h0 : annA j v = 0 := annA_eq_zero_of_not_mem_modes hjv
    rw [h0, map_zero]
    simp
