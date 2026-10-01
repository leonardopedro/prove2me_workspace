-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.fock_mass_gap_of_certified_bands_operator
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.fock_mass_gap_of_certified_bands_operator {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {b : HilbertBasis ℕ ℂ F} {e : ℕ → ℝ}
    (heig : ∀ k, A (b k) = ((e k : ℝ) : ℂ) • b k) {lo hi : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu)
    (hband : ∀ m, sInf (spectrum ℝ A) ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0))
    {m₀ : ℕ} (hlo : mu ≤ lo m₀) :
    Tendsto lo atTop (𝓝 (sInf (spectrum ℝ A))) ∧ mu ≤ sInf (spectrum ℝ A) ∧
      dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by sorry
