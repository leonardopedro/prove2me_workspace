-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.runLo_mono
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
theorem solution (lo : ℕ → ℝ) {m n : ℕ} (hmn : m ≤ n) : runLo lo m ≤ runLo lo n :=
  Finset.sup'_mono lo
      (Finset.range_subset.mpr fun k hk => Finset.mem_range.mpr (by omega)) _
