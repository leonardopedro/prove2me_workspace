-- Generated from ChapterStoneUnitary.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.continuousAt_stoneU_apply
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_apply_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_tendsto_stoneU_zero
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (x : H) (t₀ : ℝ) :
    ContinuousAt (fun t : ℝ => T.stoneU t x) t₀ := by

  have h1 : Tendsto (fun t : ℝ => t - t₀) (𝓝 t₀) (𝓝 0) := by
    simpa using (continuous_sub_right t₀).tendsto t₀
  have h2 : Tendsto (fun t : ℝ => T.stoneU (t - t₀) x) (𝓝 t₀) (𝓝 x) :=
    (T.tendsto_stoneU_zero x).comp h1
  have h3 : Tendsto (fun t : ℝ => T.stoneU t₀ (T.stoneU (t - t₀) x)) (𝓝 t₀)
      (𝓝 (T.stoneU t₀ x)) :=
    ((T.stoneU t₀).continuous.tendsto x).comp h2
  have heq : (fun t : ℝ => T.stoneU t₀ (T.stoneU (t - t₀) x)) = fun t : ℝ => T.stoneU t x := by
    funext t
    rw [T.stoneU_apply_stoneU]
    have hts : t₀ + (t - t₀) = t := by ring
    rw [hts]
  rw [heq] at h3
  exact h3
