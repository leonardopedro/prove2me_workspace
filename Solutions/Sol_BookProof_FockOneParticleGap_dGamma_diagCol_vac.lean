-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.dGamma_diagCol_vac
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_confEnergy_zero
import Theorems.Thm_BookProof_FockOneParticleGap_dGamma_diagCol_single
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) : dGamma (diagCol e) vac = 0 := by

  rw [vac, dGamma_diagCol_single, confEnergy_zero]
  simp
