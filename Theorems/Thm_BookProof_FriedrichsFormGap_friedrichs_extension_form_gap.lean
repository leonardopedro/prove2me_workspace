-- Generated from ChapterFriedrichsFormGap.lean — theorem BookProof.FriedrichsFormGap.friedrichs_extension_form_gap
import Mathlib
import Definitions.Def_ChapterFriedrichsFormGap
open BookProof.FriedrichsFormGap







noncomputable section


open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.FriedrichsFormGap.friedrichs_extension_form_gap (P : PosSymOp F) (hdense : Dense (P.dom : Set F))
    {mu : ℝ} (hmu : ∀ x : P.dom, mu * ‖(x : F)‖ ^ 2 ≤ quadForm P.op x) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (S : F →L[ℂ] F),
      IsPositiveSelfAdjointExtension P.op A ∧ IsShiftInvert A 1 S ∧
        IsSelfAdjoint S ∧ (∀ y : Dom, mu * ‖(y : F)‖ ^ 2 ≤ quadForm A y) := by sorry
