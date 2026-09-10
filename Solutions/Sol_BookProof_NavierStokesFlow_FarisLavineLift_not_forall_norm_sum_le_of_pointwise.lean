-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.not_forall_norm_sum_le_of_pointwise
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_hEx
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_nEx
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_vEx_sq
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_sum_nEx_vEx
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_sum_hEx_vEx
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift











open FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)











open LpNat DiagonalEsa









variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}















open EuclideanSpace

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (h n : Fin 2 → (E2 →ₗ[ℂ] E2)) (v : E2),
      (∀ (k : Fin 2) (x : E2), ‖h k x‖ ≤ ‖n k x‖) ∧
        ‖(n 0 + n 1) v‖ < ‖(h 0 + h 1) v‖ := by

  refine ⟨hEx, nEx, vEx, fun k x => le_of_eq (by rw [norm_hEx, norm_nEx]), ?_⟩
  have hn : ‖(nEx 0 + nEx 1) vEx‖ ^ 2 = 2 := by
    rw [sum_nEx_vEx]; exact norm_vEx_sq
  have hh : ‖(hEx 0 + hEx 1) vEx‖ = 2 := by
    rw [sum_hEx_vEx, norm_smul, EuclideanSpace.norm_single]
    norm_num
  rw [hh]
  nlinarith [hn, norm_nonneg ((nEx 0 + nEx 1) vEx)]
