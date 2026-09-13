-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.inner_vac
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockSecondQuantization_inner_toLp
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (u : FockAlg) : (inner ℂ (toLp vac) (toLp u) : ℂ) = u 0 := by

  classical
  have hs : vac.support = {(0 : Conf)} := Finsupp.support_single_ne_zero _ one_ne_zero
  rw [inner_toLp vac u, hs]
  simp [vac]
