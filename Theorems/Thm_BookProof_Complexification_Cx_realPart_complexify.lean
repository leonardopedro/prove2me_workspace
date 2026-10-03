-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.Cx.realPart_complexify
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_ChapterA4

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open BookProof.ChapterA



theorem BookProof.Complexification.Cx.realPart_complexify (Y : Submodule ℝ W) : realPart (complexify Y) = Y := by sorry
