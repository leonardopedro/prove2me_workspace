-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.Cx.mem_complexify
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_ChapterA4

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open BookProof.ChapterA



theorem BookProof.Complexification.Cx.mem_complexify {Y : Submodule ℝ W} {x : Cx W} :
    x ∈ complexify Y ↔ x.re ∈ Y ∧ x.im ∈ Y := by sorry
