-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.le_confEnergy
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_confNumber_pos
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {e : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu) (he : ∀ k, mu ≤ e k)
    {β : Conf} (hβ : β ≠ 0) : mu ≤ confEnergy e β := by

  classical
  have hstep : mu * (confNumber β : ℝ) ≤ confEnergy e β := by
    rw [confEnergy, confNumber, Nat.cast_sum, Finset.mul_sum]
    refine Finset.sum_le_sum fun k _ => ?_
    have hk : (0 : ℝ) ≤ (β k : ℝ) := by positivity
    nlinarith [he k]
  have h1 : (1 : ℝ) ≤ (confNumber β : ℝ) := by exact_mod_cast confNumber_pos hβ
  nlinarith
