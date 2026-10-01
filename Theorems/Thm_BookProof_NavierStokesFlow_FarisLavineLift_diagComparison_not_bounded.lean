-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_not_bounded
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

atement that `−Δ + V² + I` with `V² ≥ 0` is
essentially self-adjoint on a core. -/
theorem BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_not_bounded (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes ℕ) (diagComparisonData d p q).comparison := by
  rw [diagComparison_eq]
  exact diagOp_hasZeroDeficiencyOn _

/-- And it is genuinely unbounded as soon as one of the symbols is: essential
self-ad := by sorry
