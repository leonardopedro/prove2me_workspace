-- Generated from ChapterNonnegUnitaryGroup.lean — theorem BookProof.NonnegUnitaryGroup.commute_yosidaCLM_invCLMAt
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterA4
open BookProof.NonnegUnitaryGroup

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}



open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace


theorem BookProof.NonnegUnitaryGroup.commute_yosidaCLM_invCLMAt (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) :
    Commute (yosidaCLM hT ha) (invCLMAt hT hb) := by sorry
