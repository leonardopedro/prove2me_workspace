-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.runBand_widths_tendsto_zero
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Theorems.Thm_BookProof_RitzCertificate_mem_runBand
import Theorems.Thm_BookProof_RitzCertificate_runBand_width_le
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {lo hi : ℕ → ℝ} {lam : ℝ}
    (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    Tendsto (fun m => runHi hi m - runLo lo m) atTop (𝓝 0) := by

  refine squeeze_zero_norm (fun m => ?_) hwidth
  have hlam := mem_runBand hmem m
  have hnn : 0 ≤ runHi hi m - runLo lo m := by
    have := hlam.1; have := hlam.2; linarith
  rw [Real.norm_eq_abs, abs_of_nonneg hnn]
  exact runBand_width_le lo hi m
