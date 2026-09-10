-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.inner_vac
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.inner_vac (u : FockAlg) : (inner ℂ (toLp vac) (toLp u) : ℂ) = u 0 := by sorry
