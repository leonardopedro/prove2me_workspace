-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.irreducible_iff_no_conj_subsystem
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_ChapterA
import Definitions.Def_Complexification
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]
variable [CompleteSpace W]


open scoped RealInnerProductSpace
open BookProof.ChapterA



theorem BookProof.Complexification.irreducible_iff_no_conj_subsystem [CompleteSpace W] (M : System ℝ W) :
    M.IsIrreducible ↔
      ∀ X : Submodule ℂ (Cx W), (cxSystem M).IsSubsystem X →
        (∀ x ∈ X, Cx.cxConj x ∈ X) → X = ⊥ ∨ X = ⊤ := by sorry
