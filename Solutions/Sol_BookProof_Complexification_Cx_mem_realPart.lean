-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.mem_realPart
import Mathlib
import Definitions.Def_ChapterA1b



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution {X : Submodule ℂ (Cx W)} {w : W} :
    w ∈ realPart X ↔ ofReal w ∈ X := Iff.rfl
