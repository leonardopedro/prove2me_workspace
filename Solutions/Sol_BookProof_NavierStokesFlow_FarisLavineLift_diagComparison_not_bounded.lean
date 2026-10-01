-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_diagComparison_eq
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_not_bounded
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

set_option maxHeartbeats 1000000 in
atement that `−Δ + V² + I` with `V² ≥ 0` is
essentially self-adjoint on a core. -/
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes ℕ) (diagComparisonData d p q).comparison := by
  rw [diagComparison_eq]
  exact diagOp_hasZeroDeficiencyOn _

/-- And it is genuinely unbounded as soon as one of the symbols is: essential
self-ad :=
  jointness here is not a boundedness phenomenon. -/
  theorem diagC
