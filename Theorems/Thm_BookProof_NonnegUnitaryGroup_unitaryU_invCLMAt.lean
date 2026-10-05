-- Generated from ChapterNonnegUnitaryGroup.lean — theorem BookProof.NonnegUnitaryGroup.unitaryU_invCLMAt
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


theorem BookProof.NonnegUnitaryGroup.unitaryU_invCLMAt (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (ha : 0 < a) (t : ℝ) (y : F) :
    unitaryU hT hsv t (invCLMAt hT ha y) = invCLMAt hT ha (unitaryU hT hsv t y) := by sorry
