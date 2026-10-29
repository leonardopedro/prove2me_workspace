-- Generated from ChapterNonnegSemigroup.lean — theorem BookProof.NonnegSemigroup.expNeg_add
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup



open BookProof.ClosureUniqueness
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.NonnegSemigroup.expNeg_add (A : F →L[ℂ] F) (s t : ℝ) :
    expNeg A (s + t) = expNeg A s * expNeg A t := by sorry
