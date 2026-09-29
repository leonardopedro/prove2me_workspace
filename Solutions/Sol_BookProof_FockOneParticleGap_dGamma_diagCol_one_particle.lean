-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.dGamma_diagCol_one_particle
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_confEnergy_single
import Theorems.Thm_BookProof_FockOneParticleGap_dGamma_diagCol_single
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (k : ℕ) :
    dGamma (diagCol e) (Finsupp.single (Finsupp.single k 1) (1 : ℂ))
      = ((e k : ℝ) : ℂ) • Finsupp.single (Finsupp.single k 1) (1 : ℂ) := by

  rw [dGamma_diagCol_single, confEnergy_single]
