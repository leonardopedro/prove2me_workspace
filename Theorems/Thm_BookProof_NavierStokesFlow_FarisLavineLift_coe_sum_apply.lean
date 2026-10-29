-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.coe_sum_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift













variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)




















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}

theorem BookProof.NavierStokesFlow.FarisLavineLift.coe_sum_apply (s : Finset κ) (A : κ → (D →ₗ[ℂ] D)) (v : D) :
    (((∑ k ∈ s, A k) v : D) : F) = ∑ k ∈ s, ((A k v : D) : F) := by sorry
