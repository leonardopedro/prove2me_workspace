-- Generated from ChapterNonnegUnitaryGroup.lean — theorem BookProof.NonnegUnitaryGroup.expU_add
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
open BookProof.NonnegUnitaryGroup

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace


theorem BookProof.NonnegUnitaryGroup.expU_add (B : F →L[ℂ] F) (s t : ℝ) : expU B (s + t) = expU B s * expU B t := by sorry
