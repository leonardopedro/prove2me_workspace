-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.creVec_diagCol
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.creVec_diagCol (e : ℕ → ℝ) (k : ℕ) (x : FockAlg) :
    creVec (diagCol e k) x = ((e k : ℝ) : ℂ) • creA k x := by sorry
