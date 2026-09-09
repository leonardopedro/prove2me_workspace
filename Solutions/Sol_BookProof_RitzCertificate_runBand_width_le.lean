-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.runBand_width_le
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Theorems.Thm_BookProof_RitzCertificate_le_runLo
import Theorems.Thm_BookProof_RitzCertificate_runHi_le
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (lo hi : ℕ → ℝ) (m : ℕ) :
    runHi hi m - runLo lo m ≤ hi m - lo m := by

  have h1 := le_runLo lo m
  have h2 := runHi_le hi m
  linarith
