-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.factor_nonneg_of_separation
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Theorems.Thm_BookProof_RitzCertificate_factor_nonneg
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {l b : ℝ}
    (hsep : SpectralSeparation A l b) :
    0 ≤ (A - (l : ℝ) • (1 : F →L[ℂ] F)) * (A - (b : ℝ) • (1 : F →L[ℂ] F)) := by

  refine factor_nonneg hA ?_
  intro t ht
  rcases hsep.2 t ht with h | h
  · simp [h]
  · have h1 : 0 ≤ t - l := by linarith [hsep.1]
    have h2 : 0 ≤ t - b := by linarith
    positivity
