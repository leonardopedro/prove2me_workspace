-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.isUniformInducing_toComplL
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
iformSpace.Completion.denseRange_coe (α := FormDom P)

theorem solution (P : PosSymOp F) :
    IsUniformInducing (UniformSp :=
  ace.Completion.toComplL (𝕜 := ℂ) (E := FormDom P)) := by
    simpa [UniformSpace.Completion.coe_toComplL] using
      U
