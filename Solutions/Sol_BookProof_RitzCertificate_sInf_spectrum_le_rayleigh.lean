-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.sInf_spectrum_le_rayleigh
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    {x : F} (hx : ‖x‖ = 1) : sInf (spectrum ℝ A) ≤ rayleigh A x := by

  have h := rayleighInf_mul_normSq_le A x
  rw [hx] at h
  rw [sInf_spectrum_eq_rayleighInf A hA, rayleigh]
  simpa using h
