-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_diagComparison_eq
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_not_bounded
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ)
    (hunb : ∀ C : ℝ, ∃ k, C < |(∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1|) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ℕ,
      ‖(diagComparisonData d p q).comparison f‖ ≤ C * ‖f‖ :=
  jointness here is not a boundedness phenomenon. -/
  theorem diagC
