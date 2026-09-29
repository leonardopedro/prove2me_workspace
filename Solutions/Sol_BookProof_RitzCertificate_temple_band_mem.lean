-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.temple_band_mem
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Theorems.Thm_BookProof_RitzCertificate_temple_lower_bound
import Theorems.Thm_BookProof_RitzCertificate_sInf_spectrum_le_rayleigh
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterBandEnclosure
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {b : ℝ} {x : F}
    (hsep : SpectralSeparation A (sInf (spectrum ℝ A)) b) (hx : ‖x‖ = 1)
    (hlt : rayleigh A x < b) :
    sInf (spectrum ℝ A) ∈
      Set.Icc (rayleigh A x - resid A x ^ 2 / (b - rayleigh A x)) (rayleigh A x) := ⟨temple_lower_bound hA hsep hx hlt, sInf_spectrum_le_rayleigh A hA hx⟩
