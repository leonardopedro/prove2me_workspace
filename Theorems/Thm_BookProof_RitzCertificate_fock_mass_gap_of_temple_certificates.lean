-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.fock_mass_gap_of_temple_certificates
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate













noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]





















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzCertificate.fock_mass_gap_of_temple_certificates [Nontrivial F] {A : F →L[ℂ] F}
    (hA : IsSelfAdjoint A) {bas : HilbertBasis ℕ ℂ F} {e : ℕ → ℝ}
    (heig : ∀ k, A (bas k) = ((e k : ℝ) : ℂ) • bas k)
    {b delta mu : ℝ} {x : ℕ → F} (hsep : SpectralSeparation A (sInf (spectrum ℝ A)) b)
    (hdelta : 0 < delta) (hmu : 0 ≤ mu) (hx : ∀ m, ‖x m‖ = 1)
    (hle : ∀ m, rayleigh A (x m) ≤ b - delta)
    (hres : Tendsto (fun m => resid A (x m)) atTop (𝓝 0))
    {m₀ : ℕ} (hlo : mu ≤ rayleigh A (x m₀) -
      resid A (x m₀) ^ 2 / (b - rayleigh A (x m₀))) :
    Tendsto (runLo fun m => rayleigh A (x m) -
        resid A (x m) ^ 2 / (b - rayleigh A (x m))) atTop (𝓝 (sInf (spectrum ℝ A))) ∧
      mu ≤ sInf (spectrum ℝ A) ∧ dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by sorry
