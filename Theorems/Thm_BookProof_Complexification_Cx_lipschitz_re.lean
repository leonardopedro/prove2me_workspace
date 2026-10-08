-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.Cx.lipschitz_re
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_Complexification
open BookProof.Complexification
open BookProof.Complexification


open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


theorem BookProof.Complexification.Cx.lipschitz_re : LipschitzWith 1 (Cx.re : Cx W → W) := by sorry
