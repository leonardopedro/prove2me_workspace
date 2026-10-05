-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.irreducible_iff_no_conj_subsystem
import Mathlib
import Definitions.Def_ChapterA1b
import Theorems.Thm_BookProof_Complexification_Cx_complexify_realPart_of_invariant
import Theorems.Thm_BookProof_Complexification_Cx_complexify_cxConj_invariant
import Theorems.Thm_BookProof_Complexification_Cx_complexify_isSubsystem
import Theorems.Thm_BookProof_Complexification_Cx_realPart_isSubsystem
import Theorems.Thm_BookProof_Complexification_Cx_complexify_bot
import Theorems.Thm_BookProof_Complexification_Cx_complexify_top
import Theorems.Thm_BookProof_Complexification_Cx_realPart_bot
import Theorems.Thm_BookProof_Complexification_Cx_realPart_complexify
import Theorems.Thm_BookProof_Complexification_Cx_realPart_top
open BookProof.Complexification



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]
variable [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace W] (M : System ℝ W) :
    M.IsIrreducible ↔
      ∀ X : Submodule ℂ (Cx W), (cxSystem M).IsSubsystem X →
        (∀ x ∈ X, Cx.cxConj x ∈ X) → X = ⊥ ∨ X = ⊤ := by

  constructor
  · -- real irreducible ⇒ no proper conjugation-invariant complex subsystem
    intro hirr X hX hXinv
    rcases hirr _ (Cx.realPart_isSubsystem M hX) with h | h
    · exact Or.inl <| by
        rw [← Cx.complexify_realPart_of_invariant hXinv, h, Cx.complexify_bot]
    · exact Or.inr <| by
        rw [← Cx.complexify_realPart_of_invariant hXinv, h, Cx.complexify_top]
  · -- the converse, via the round-trip `realPart (complexify Y) = Y`
    intro h Y hY
    rcases h (Cx.complexify Y) (Cx.complexify_isSubsystem M hY)
        (Cx.complexify_cxConj_invariant Y) with h | h
    · refine Or.inl ?_
      have := congrArg Cx.realPart h
      rwa [Cx.realPart_complexify, Cx.realPart_bot] at this
    · refine Or.inr ?_
      have := congrArg Cx.realPart h
      rwa [Cx.realPart_complexify, Cx.realPart_top] at this
