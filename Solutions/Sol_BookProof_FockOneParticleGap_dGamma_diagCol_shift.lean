-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.dGamma_diagCol_shift
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_confEnergy_one
import Theorems.Thm_BookProof_FockOneParticleGap_confEnergy_add_const
import Theorems.Thm_BookProof_FockOneParticleGap_dGamma_diagCol_apply
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (mu : ℝ) (u : FockAlg) :
    dGamma (diagCol fun k => e k + mu) u
      = dGamma (diagCol e) u + ((mu : ℝ) : ℂ) • dGamma numberCol u := by

  refine Finsupp.ext fun β => ?_
  rw [Finsupp.add_apply, Finsupp.smul_apply, dGamma_diagCol_apply, dGamma_diagCol_apply,
    numberCol, dGamma_diagCol_apply, confEnergy_add_const, confEnergy_one]
  push_cast
  simp only [smul_eq_mul]
  ring
