-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.not_forall_norm_sum_le_of_pointwise
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}




open FullEsa

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
state on which th := by sorry
