-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.runBands_nested
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Theorems.Thm_BookProof_RitzCertificate_runLo_mono
import Theorems.Thm_BookProof_RitzCertificate_runHi_antitone
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
theorem solution (lo hi : ℕ → ℝ) : NestedBands (runLo lo) (runHi hi) :=
  fun m =>
    Set.Icc_subset_Icc (runLo_mono lo (Nat.le_succ m)) (runHi_antitone hi (Nat.le_succ m))
