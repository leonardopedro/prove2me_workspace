-- Generated from ChapterNonnegSemigroup.lean — solution of BookProof.NonnegSemigroup.isSelfAdjoint_expNeg
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
theorem solution {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) (t : ℝ) :
    IsSelfAdjoint (expNeg A t) := by

  have hstar : IsSelfAdjoint ((-t : ℝ) • A) := by
    change star ((-t : ℝ) • A) = (-t : ℝ) • A
    rw [star_smul, hA.star_eq]
    simp
  exact hstar.exp
