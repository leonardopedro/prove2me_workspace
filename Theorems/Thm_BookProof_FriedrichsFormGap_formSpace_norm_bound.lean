-- Generated from ChapterFriedrichsFormGap.lean — theorem BookProof.FriedrichsFormGap.formSpace_norm_bound
import Mathlib
import Definitions.Def_ChapterFriedrichsFormGap
open BookProof.FriedrichsFormGap







noncomputable section


open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.FriedrichsFormGap.formSpace_norm_bound (P : PosSymOp F) {mu : ℝ}
    (hmu : ∀ x : P.dom, mu * ‖(x : F)‖ ^ 2 ≤ quadForm P.op x) (k : FormSpace P) :
    (1 + mu) * ‖formExt P k‖ ^ 2 ≤ ‖k‖ ^ 2 := by sorry
