-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.runHi_antitone
import Mathlib
import Definitions.Def_ChapterRitzCertificate
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
theorem solution (hi : ℕ → ℝ) {m n : ℕ} (hmn : m ≤ n) : runHi hi n ≤ runHi hi m :=
  Finset.inf'_mono hi
      (Finset.range_subset.mpr fun k hk => Finset.mem_range.mpr (by omega)) _
