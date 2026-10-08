-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.Cx.complexify_cxConj_invariant
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_Complexification
open BookProof.Complexification
open BookProof.Complexification.Cx


open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


theorem BookProof.Complexification.Cx.complexify_cxConj_invariant (Y : Submodule ℝ W) :
    ∀ x ∈ complexify Y, cxConj x ∈ complexify Y := by sorry
