-- Generated from ChapterNonnegUnitaryGroup.lean — theorem BookProof.NonnegUnitaryGroup.hasDerivAt_expU_apply
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterStoneEvolution
open BookProof.NonnegUnitaryGroup

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace


theorem BookProof.NonnegUnitaryGroup.hasDerivAt_expU_apply (B : F →L[ℂ] F) (t : ℝ) (x : F) :
    HasDerivAt (fun s : ℝ => expU B s x) ((expU B t) (((-Complex.I) • B) x)) t := by sorry
