-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.sInf_spectrum_le_rayleigh
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate













noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzCertificate.sInf_spectrum_le_rayleigh [Nontrivial F] (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    {x : F} (hx : ‖x‖ = 1) : sInf (spectrum ℝ A) ≤ rayleigh A x := by sorry
