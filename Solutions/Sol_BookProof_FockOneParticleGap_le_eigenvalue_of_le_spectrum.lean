-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.le_eigenvalue_of_le_spectrum
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_le_rayleigh_iff_le_spectrum
open BookProof.FockOneParticleGap



noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {b : HilbertBasis ℕ ℂ F} {e : ℕ → ℝ}
    (heig : ∀ k, A (b k) = ((e k : ℝ) : ℂ) • b k) {mu : ℝ}
    (hspec : ∀ lam ∈ spectrum ℝ A, mu ≤ lam) : ∀ k, mu ≤ e k := by

  intro k
  have hray := (le_rayleigh_iff_le_spectrum A hA mu).mpr hspec (b k)
  have hnorm : ‖b k‖ = 1 := b.orthonormal.1 k
  have hinner : (inner ℂ (b k) (A (b k)) : ℂ) = ((e k : ℝ) : ℂ) := by
    rw [heig k, inner_smul_right, inner_self_eq_norm_sq_to_K, hnorm]
    norm_num
  rw [hinner, hnorm] at hray
  simpa using hray
