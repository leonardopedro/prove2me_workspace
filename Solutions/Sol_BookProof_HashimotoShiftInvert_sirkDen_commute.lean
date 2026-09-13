-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.sirkDen_commute
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.HashimotoShiftInvert



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {Xm T : F →L[ℂ] F} (c : ℕ → ℂ) (hT : T ∘L Xm = Xm ∘L T) (k : ℕ) :
    T ∘L sirkDen Xm c k = sirkDen Xm c k ∘L T := by

  induction k with
  | zero => ext u; simp
  | succ k ih =>
      have h1 : T ∘L (ContinuousLinearMap.id ℂ F - c k • Xm)
          = (ContinuousLinearMap.id ℂ F - c k • Xm) ∘L T := by
        ext u
        have := congrArg (fun S : F →L[ℂ] F => S u) hT
        simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at this
        simp only [ContinuousLinearMap.coe_comp', Function.comp_apply,
          ContinuousLinearMap.sub_apply, ContinuousLinearMap.id_apply,
          ContinuousLinearMap.coe_smul', Pi.smul_apply, map_sub, map_smul, this]
      calc T ∘L ((ContinuousLinearMap.id ℂ F - c k • Xm) ∘L sirkDen Xm c k)
          = (T ∘L (ContinuousLinearMap.id ℂ F - c k • Xm)) ∘L sirkDen Xm c k := rfl
        _ = ((ContinuousLinearMap.id ℂ F - c k • Xm) ∘L T) ∘L sirkDen Xm c k := by rw [h1]
        _ = (ContinuousLinearMap.id ℂ F - c k • Xm) ∘L (T ∘L sirkDen Xm c k) := rfl
        _ = (ContinuousLinearMap.id ℂ F - c k • Xm) ∘L (sirkDen Xm c k ∘L T) := by rw [ih]
        _ = ((ContinuousLinearMap.id ℂ F - c k • Xm) ∘L sirkDen Xm c k) ∘L T := rfl
