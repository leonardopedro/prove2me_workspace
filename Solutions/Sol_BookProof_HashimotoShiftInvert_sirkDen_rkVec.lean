-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.sirkDen_rkVec
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftInvertC_commute
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftInvertC_comp_one_sub
import Theorems.Thm_BookProof_HashimotoShiftInvert_sirkDen_commute
open BookProof.HashimotoShiftInvert



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℕ → ℂ} {X : ℕ → F →L[ℂ] F} (m : ℕ)
    (hX : ∀ j, IsShiftInvertC A (γ j) (X j)) (v : F) (k : ℕ) :
    sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v := by

  induction k with
  | zero => simp
  | succ k ih =>
      have hcomm : X k ∘L X m = X m ∘L X k :=
        shiftInvertC_commute (hX k) (hX m)
      have hden : X k ∘L sirkDen (X m) (fun i => γ m - γ i) k
          = sirkDen (X m) (fun i => γ m - γ i) k ∘L X k :=
        sirkDen_commute _ hcomm k
      have hkey : (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m) ∘L X k = X m := by
        have h := shiftInvertC_comp_one_sub (hX k) (hX m)
        have hcomm' : X k ∘L (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m)
            = (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m) ∘L X k := by
          ext u
          have := congrArg (fun S : F →L[ℂ] F => S u) hcomm
          simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at this
          simp only [ContinuousLinearMap.coe_comp', Function.comp_apply,
            ContinuousLinearMap.sub_apply, ContinuousLinearMap.id_apply,
            ContinuousLinearMap.coe_smul', Pi.smul_apply, map_sub, map_smul, this]
        rw [← hcomm', h]
      calc sirkDen (X m) (fun i => γ m - γ i) (k + 1) (rkVec X v (k + 1))
          = (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m)
              (sirkDen (X m) (fun i => γ m - γ i) k (X k (rkVec X v k))) := rfl
        _ = (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m)
              (X k (sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k))) := by
              have := congrArg (fun S : F →L[ℂ] F => S (rkVec X v k)) hden
              simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at this
              rw [← this]
        _ = (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m) (X k ((X m ^ k) v)) := by rw [ih]
        _ = ((ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m) ∘L X k) ((X m ^ k) v) := rfl
        _ = (X m ^ (k + 1)) v := by
              rw [hkey, pow_succ']
              rfl
