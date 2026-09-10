-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.confEnergy_single
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (k : ℕ) :
    confEnergy e (Finsupp.single k 1) = e k := by

  classical
  have hsupp : (Finsupp.single k 1 : Conf).support = {k} :=
    Finsupp.support_single_ne_zero k one_ne_zero
  simp [confEnergy, hsupp]
