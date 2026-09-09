-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.factor_nonneg
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate













noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzCertificate.factor_nonneg {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {l b : ℝ}
    (hspec : ∀ t ∈ spectrum ℝ A, 0 ≤ (t - l) * (t - b)) :
    0 ≤ (A - (l : ℝ) • (1 : F →L[ℂ] F)) * (A - (b : ℝ) • (1 : F →L[ℂ] F)) := by sorry
