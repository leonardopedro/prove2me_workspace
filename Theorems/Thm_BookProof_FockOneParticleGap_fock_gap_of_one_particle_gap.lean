-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.fock_gap_of_one_particle_gap
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.fock_gap_of_one_particle_gap {e : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu)
    (he : ∀ k, mu ≤ e k) :
    dGammaOp (diagCol e) (fockEquiv vac) = 0 ∧
      ∀ x : lpFiniteModes Conf, (inner ℂ (toLp vac) ((x : Fock)) : ℂ) = 0 →
        mu * ‖(x : Fock)‖ ^ 2 ≤ quadForm (dGammaOp (diagCol e)) x := by sorry
