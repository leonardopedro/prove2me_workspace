-- Generated from ChapterNonnegUnitaryGroup.lean — theorem BookProof.NonnegUnitaryGroup.approxU_add
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
variable {T : Submodule ℂ (F × F)} {a b : ℝ}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace


theorem BookProof.NonnegUnitaryGroup.approxU_add (hT : IsNonnegSelfAdjoint T) (n : ℕ) (s t : ℝ) :
    approxU hT n (s + t) = approxU hT n s * approxU hT n t := by sorry
