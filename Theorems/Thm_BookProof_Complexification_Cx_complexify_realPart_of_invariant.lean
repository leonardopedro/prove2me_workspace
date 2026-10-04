-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.Cx.complexify_realPart_of_invariant
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open BookProof.ChapterA



theorem BookProof.Complexification.Cx.complexify_realPart_of_invariant {X : Submodule ℂ (Cx W)}
    (hX : ∀ x ∈ X, cxConj x ∈ X) : complexify (realPart X) = X := by sorry
