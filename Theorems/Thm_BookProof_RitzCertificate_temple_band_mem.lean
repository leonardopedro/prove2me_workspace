-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.temple_band_mem
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate













noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzCertificate.temple_band_mem [Nontrivial F] {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {b : ℝ} {x : F}
    (hsep : SpectralSeparation A (sInf (spectrum ℝ A)) b) (hx : ‖x‖ = 1)
    (hlt : rayleigh A x < b) :
    sInf (spectrum ℝ A) ∈
      Set.Icc (rayleigh A x - resid A x ^ 2 / (b - rayleigh A x)) (rayleigh A x) := by sorry
