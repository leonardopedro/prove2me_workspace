-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.psi_den_pos
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (r : ℝ) : 0 < Real.sqrt r + Real.sqrt (1 - r) := by

  rcases le_or_gt r 0 with hr | hr
  · have : 0 < Real.sqrt (1 - r) := Real.sqrt_pos.2 (by linarith)
    have := Real.sqrt_nonneg r
    linarith
  · have : 0 < Real.sqrt r := Real.sqrt_pos.2 hr
    have := Real.sqrt_nonneg (1 - r)
    linarith
