-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.conj_mul_re
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (z : ℂ) : ((starRingEnd ℂ) z * z).re = ‖z‖ ^ 2 := by

  have h : (starRingEnd ℂ) z * z = ((Complex.normSq z : ℝ) : ℂ) := by
    rw [mul_comm]; exact Complex.mul_conj z
  rw [h, Complex.ofReal_re, Complex.normSq_eq_norm_sq]
