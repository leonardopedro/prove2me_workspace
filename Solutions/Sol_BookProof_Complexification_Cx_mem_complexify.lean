-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.mem_complexify
import Mathlib
import Definitions.Def_ChapterA1b



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution {Y : Submodule ℝ W} {x : Cx W} :
    x ∈ complexify Y ↔ x.re ∈ Y ∧ x.im ∈ Y := Iff.rfl
