-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_eq
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

theorem BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_eq (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    (diagComparisonData d p q).comparison
      = diagOp (fun k => (∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1) := by sorry
