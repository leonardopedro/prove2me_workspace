-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.fock_energy_one_particle
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.fock_energy_one_particle (e : ℕ → ℝ) (k : ℕ) :
    (inner ℂ (toLp (Finsupp.single (Finsupp.single k 1) (1 : ℂ)))
        (toLp (dGamma (diagCol e) (Finsupp.single (Finsupp.single k 1) (1 : ℂ)))) : ℂ).re
      = e k := by sorry
