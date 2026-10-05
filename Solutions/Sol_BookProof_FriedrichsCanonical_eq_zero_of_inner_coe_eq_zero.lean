-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.eq_zero_of_inner_coe_eq_zero
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (k : FormSpace P)
    (h : ∀ v : FormDom P, (inner ℂ (v : FormSpace P) k : ℂ) = 0) : k = 0 := by

  have hall : ∀ z : FormSpace P, (inner ℂ z k : ℂ) = 0 := by
    intro z
    refine UniformSpace.Completion.induction_on z ?_ h
    exact isClosed_eq (by fun_prop) (by fun_prop)
  simpa using hall k
