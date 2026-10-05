-- Generated from ChapterNonnegSemigroup.lean — solution of BookProof.NonnegSemigroup.expNeg_add
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup
open BookProof.NonnegSemigroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F) (s t : ℝ) :
    expNeg A (s + t) = expNeg A s * expNeg A t := by

  have hc : Commute ((-s : ℝ) • A) ((-t : ℝ) • A) :=
    ((Commute.refl A).smul_right _).smul_left _
  have hsum : ((-(s + t) : ℝ) • A) = ((-s : ℝ) • A) + ((-t : ℝ) • A) := by
    rw [← add_smul]; congr 1; ring
  simp only [expNeg, hsum, NormedSpace.exp_add_of_commute hc]
