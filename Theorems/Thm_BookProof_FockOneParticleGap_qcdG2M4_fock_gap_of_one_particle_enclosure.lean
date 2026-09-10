-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.qcdG2M4_fock_gap_of_one_particle_enclosure
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.qcdG2M4_fock_gap_of_one_particle_enclosure {e : ℕ → ℝ} {lo hi : ℕ → ℝ} {lam : ℝ}
    (hband : ∀ m, lam ∈ Set.Icc (lo m) (hi m)) {m₀ : ℕ}
    (hlo : (1.932 : ℝ) ≤ lo m₀) (hedge : ∀ k, lam ≤ e k) :
    (1.932 : ℝ) ≤ lam ∧ dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (1.932 : ℝ) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by sorry
