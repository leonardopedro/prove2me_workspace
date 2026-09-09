-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.runHi_le
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
theorem solution (hi : ℕ → ℝ) (m : ℕ) : runHi hi m ≤ hi m := Finset.inf'_le hi (Finset.self_mem_range_succ m)
