-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.expU_add
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (B : F →L[ℂ] F) (s t : ℝ) : expU B (s + t) = expU B s * expU B t := by

  rw [expU, expU, expU, add_smul]
  exact exp_add_of_commute (((Commute.refl ((-Complex.I) • B)).smul_left s).smul_right t)
