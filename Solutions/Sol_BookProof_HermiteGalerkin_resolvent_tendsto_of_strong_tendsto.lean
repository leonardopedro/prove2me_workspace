-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.resolvent_tendsto_of_strong_tendsto
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Theorems.Thm_BookProof_HermiteGalerkin_isUnit_algebraMap_sub
import Theorems.Thm_BookProof_HermiteGalerkin_norm_resolvent_apply_le
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.HermiteGalerkin













open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {D : Submodule ℂ F}












variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : ℕ → F →L[ℂ] F) (A : F →L[ℂ] F)
    (hT : ∀ n, IsSelfAdjoint (T n)) (hA : IsSelfAdjoint A) {z : ℂ} (hz : z.im ≠ 0)
    (hconv : ∀ u : F, Tendsto (fun n : ℕ => T n u) atTop (nhds (A u))) (u : F) :
    Tendsto (fun n : ℕ => resolvent (T n) z u) atTop (nhds (resolvent A z u)) := by

  have hzpos : 0 < |z.im| := abs_pos.mpr hz
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hbound : ∀ n : ℕ, ‖resolvent (T n) z u - resolvent A z u‖
      ≤ ‖T n (resolvent A z u) - A (resolvent A z u)‖ / |z.im| := by
    intro n
    have hSn : resolvent (T n) z * (algebraMap ℂ (F →L[ℂ] F) z - T n) = 1 :=
      Ring.inverse_mul_cancel _ (isUnit_algebraMap_sub (T n) (hT n) hz)
    have hS : (algebraMap ℂ (F →L[ℂ] F) z - A) * resolvent A z = 1 :=
      Ring.mul_inverse_cancel _ (isUnit_algebraMap_sub A hA hz)
    have hsub : (T n - A)
        = (algebraMap ℂ (F →L[ℂ] F) z - A) - (algebraMap ℂ (F →L[ℂ] F) z - T n) := by abel
    have hid : resolvent (T n) z - resolvent A z
        = resolvent (T n) z * (T n - A) * resolvent A z := by
      rw [hsub, mul_sub, sub_mul, mul_assoc, hS, hSn]
      simp
    have happ : resolvent (T n) z u - resolvent A z u
        = resolvent (T n) z (T n (resolvent A z u) - A (resolvent A z u)) := by
      have := congrArg (fun S : F →L[ℂ] F => S u) hid
      simpa using this
    rw [happ, le_div_iff₀ hzpos, mul_comm]
    exact norm_resolvent_apply_le (T n) (hT n) hz _
  have hconv0 : Tendsto
      (fun n : ℕ => ‖T n (resolvent A z u) - A (resolvent A z u)‖ / |z.im|) atTop (nhds 0) := by
    have h := hconv (resolvent A z u)
    rw [tendsto_iff_norm_sub_tendsto_zero] at h
    simpa using h.div_const |z.im|
  exact squeeze_zero (fun n => norm_nonneg _) hbound hconv0
