-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.mem_runBand
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
theorem solution {lo hi : ℕ → ℝ} {lam : ℝ} (h : ∀ m, lam ∈ Set.Icc (lo m) (hi m)) (m : ℕ) :
    lam ∈ Set.Icc (runLo lo m) (runHi hi m) := by

  constructor
  · exact Finset.sup'_le _ lo fun k _ => (h k).1
  · exact Finset.le_inf' _ hi fun k _ => (h k).2
