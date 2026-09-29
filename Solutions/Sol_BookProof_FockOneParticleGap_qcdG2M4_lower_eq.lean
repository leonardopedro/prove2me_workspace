-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.qcdG2M4_lower_eq
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution : BookProof.SirkCertifiedGap.qcdG2M4.lower = 1.932 := BookProof.SirkCertifiedGap.qcdG2M4_lower
