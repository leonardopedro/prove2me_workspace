-- Generated from ChapterNonnegUnitaryGroup.lean — theorem BookProof.NonnegUnitaryGroup.commute_yosidaCLM_invCLMAt
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup



open BookProof.ClosureUniqueness
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

theorem BookProof.NonnegUnitaryGroup.commute_yosidaCLM_invCLMAt (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) :
    Commute (yosidaCLM hT ha) (invCLMAt hT hb) := by sorry
