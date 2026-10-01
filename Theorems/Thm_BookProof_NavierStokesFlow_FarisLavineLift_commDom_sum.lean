-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.commDom_sum
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

_apply (A B : D →ₗ[ℂ] D) (v : D) :
    commDom A B v = A (B v) - B (A v) := rfl

theorem BookProof.NavierStokesFlow.FarisLavineLift.commDom_sum (A B : D →ₗ[ℂ] D) :
    commDom A (B + LinearMap.id) = commDom A B := by
  ext v
  simp [commDom]

/-- **The commutator of second-quantized operators is the second quantization of
the commutators**: if operators belonging to differe := by sorry
