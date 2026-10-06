-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.isSelfAdjoint_of_nonneg
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.UnboundedPolar BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : 0 ≤ A) : IsSelfAdjoint A :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2
      ((ContinuousLinearMap.nonneg_iff_isPositive A).1 hA).1
