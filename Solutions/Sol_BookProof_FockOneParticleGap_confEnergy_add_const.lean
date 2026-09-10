-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.confEnergy_add_const
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (mu : ℝ) (β : Conf) :
    confEnergy (fun k => e k + mu) β = confEnergy e β + mu * (confNumber β : ℝ) := by

  classical
  simp only [confEnergy, confNumber, Nat.cast_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun k _ => by ring
