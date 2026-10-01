-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.not_forall_norm_sum_le_of_pointwise
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_hEx
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_sum_hEx_vEx
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_nEx
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_vEx_sq
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_sum_nEx_vEx
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

set_option maxHeartbeats 1000000 in
nSpace.single (0 : Fin 2) (1 : ℂ) := by
  simp only [LinearMap.add_apply, hEx, LinearMap.smulRight_apply, ← add_smul]
  rw [show (EuclideanSpace.projₗ (𝕜 := ℂ) (0 : Fin 2)) vEx = vEx 0 from rfl,
    show (EuclideanSpace.projₗ (𝕜 := ℂ) (1 : Fin 2)) vEx = vEx 1 from rfl,
    vEx_apply, vEx_apply]
  norm_num

/-- **The informal Fock-space argument for the operator bound is not valid.**
The step `∑ₖ ‖hₖΨ‖ ≤ c ∑ₖ ‖nₖΨ‖ ≤ c ‖N̂Ψ‖` uses the triangle inequality in the
wrong direction: `∑ₖ ‖nₖΨ‖` can exceed `‖∑ₖ nₖΨ‖`.  Concretely there are two
pairs of operators with `‖hₖ x‖ ≤ ‖nₖ x‖` for every `x` and every `k`, and a
state on which th :=
  e sums violate the same bound.  This is why
  `norm_sum_le_of_pairwise` assumes the *pairwise* domination. -/
  theorem not_forall_norm_sum_le_of_pointwise :
      ∃ (h n : Fin 2 → (E2 →ₗ[ℂ] E2)) (v : E2),
        (∀ (k : Fin 2) (x : E2), ‖h k x‖ ≤ ‖n k x‖) ∧
          ‖(n 0 + n 1) v‖ < ‖(h 0 + h 1) v‖ := by
    refine ⟨hEx, nEx, vEx, fun
