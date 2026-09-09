-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.factor_nonneg
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {l b : ℝ}
    (hspec : ∀ t ∈ spectrum ℝ A, 0 ≤ (t - l) * (t - b)) :
    0 ≤ (A - (l : ℝ) • (1 : F →L[ℂ] F)) * (A - (b : ℝ) • (1 : F →L[ℂ] F)) := by

  have h1 : cfc (fun t : ℝ => (t - l) * (t - b)) A
      = (A - (l : ℝ) • (1 : F →L[ℂ] F)) * (A - (b : ℝ) • (1 : F →L[ℂ] F)) := by
    rw [cfc_mul _ _ A, cfc_sub _ _ A, cfc_sub _ _ A, cfc_id' ℝ A, cfc_const l A, cfc_const b A,
      Algebra.algebraMap_eq_smul_one, Algebra.algebraMap_eq_smul_one]
  rw [← h1]
  exact cfc_nonneg hspec
