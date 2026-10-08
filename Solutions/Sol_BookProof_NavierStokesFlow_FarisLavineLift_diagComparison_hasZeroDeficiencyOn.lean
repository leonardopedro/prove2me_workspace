-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_diagComparison_eq
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes ℕ) (diagComparisonData d p q).comparison :=
  sis whatsoever on the symbols: this is
  the fiber-space form of the
