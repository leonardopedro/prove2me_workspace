-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.numberOp_vac
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_dGamma_diagCol_vac
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution : dGamma numberCol vac = 0 := dGamma_diagCol_vac _
