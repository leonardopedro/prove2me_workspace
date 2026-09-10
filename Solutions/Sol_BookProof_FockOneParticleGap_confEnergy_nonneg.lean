-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.confEnergy_nonneg
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {e : ℕ → ℝ} (he : ∀ k, 0 ≤ e k) (β : Conf) :
    0 ≤ confEnergy e β := Finset.sum_nonneg fun k _ => mul_nonneg (by positivity) (he k)
