-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.Cx.complexify_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA4
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]
variable [CompleteSpace W]


open scoped RealInnerProductSpace
open BookProof.ChapterA



theorem BookProof.Complexification.Cx.complexify_isSubsystem (M : System ℝ W) {Y : Submodule ℝ W}
    (hY : (M).IsSubsystem Y) : (cxSystem M).IsSubsystem (complexify Y) := by sorry
