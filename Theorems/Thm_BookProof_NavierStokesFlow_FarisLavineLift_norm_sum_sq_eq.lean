-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.norm_sum_sq_eq
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

theorem BookProof.NavierStokesFlow.FarisLavineLift.norm_sum_sq_eq {κ : Type*} (s : Finset κ) (a : κ → F) :
    ‖∑ k ∈ s, a k‖ ^ 2 = ∑ k ∈ s, ∑ l ∈ s, (inner ℂ (a k) (a l) : ℂ).re := by sorry
