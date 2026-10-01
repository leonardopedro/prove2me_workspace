-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.confNumber_pos
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockOneParticleGap


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.confNumber_pos {β : Conf} (h : β ≠ 0) : 1 ≤ confNumber β := by sorry
