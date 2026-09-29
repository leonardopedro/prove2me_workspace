-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.fock_energy_one_particle
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_confEnergy_single
import Theorems.Thm_BookProof_FockOneParticleGap_re_inner_dGamma_diagCol
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (k : ℕ) :
    (inner ℂ (toLp (Finsupp.single (Finsupp.single k 1) (1 : ℂ)))
        (toLp (dGamma (diagCol e) (Finsupp.single (Finsupp.single k 1) (1 : ℂ)))) : ℂ).re
      = e k := by

  classical
  rw [re_inner_dGamma_diagCol,
    show (Finsupp.single (Finsupp.single k 1) (1 : ℂ)).support = {Finsupp.single k 1} from
      Finsupp.support_single_ne_zero _ one_ne_zero]
  simp [confEnergy_single]
