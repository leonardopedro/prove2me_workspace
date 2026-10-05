-- Generated from ChapterNonnegSemigroup.lean — theorem BookProof.NonnegSemigroup.isSelfAdjoint_expNeg
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup
open BookProof.NonnegSemigroup

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup
open Filter Topology NormedSpace
open scoped InnerProductSpace


theorem BookProof.NonnegSemigroup.isSelfAdjoint_expNeg {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) (t : ℝ) :
    IsSelfAdjoint (expNeg A t) := by sorry
