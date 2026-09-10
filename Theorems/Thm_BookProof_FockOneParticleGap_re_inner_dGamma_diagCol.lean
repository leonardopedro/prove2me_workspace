-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.re_inner_dGamma_diagCol
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.re_inner_dGamma_diagCol (e : ℕ → ℝ) (u : FockAlg) :
    (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re
      = ∑ α ∈ u.support, confEnergy e α * ‖u α‖ ^ 2 := by sorry
