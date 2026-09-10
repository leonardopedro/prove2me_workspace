-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.fock_mass_gap_of_certified_bands
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.fock_mass_gap_of_certified_bands {e : ℕ → ℝ} {lo hi : ℕ → ℝ} {lam mu : ℝ}
    (hmu : 0 ≤ mu) (hband : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0))
    {m₀ : ℕ} (hlo : mu ≤ lo m₀) (hedge : ∀ k, lam ≤ e k) :
    Tendsto lo atTop (𝓝 lam) ∧ mu ≤ lam ∧ dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by sorry
