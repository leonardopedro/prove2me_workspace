-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.norm_formExt_le
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_denseRange_toComplL
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
mExt, UniformSpace.Completion.coe_toComplL] using this

theorem solution :=
  orm_formExt_le (P : PosSymOp F) : ‖formExt P‖ ≤ 1 := by
    have h : ‖(incl P).extend (UniformSpace.Completion.toComplL (𝕜 := ℂ) (E := FormDom P))‖
        ≤ (1 : NNReal) * ‖incl P‖ :=
      ContinuousLinearMap.opNorm_extend_le _ (denseRange_toComplL P)
        (fun x => by simp [UniformSpace.Completion.coe_toComplL])
    have := le_trans h (by
