-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.Cx.mem_realPart
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_ChapterA4

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open BookProof.ChapterA



theorem BookProof.Complexification.Cx.mem_realPart {X : Submodule ℂ (Cx W)} {w : W} :
    w ∈ realPart X ↔ ofReal w ∈ X := by sorry
