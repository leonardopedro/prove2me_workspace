-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.runHi_antitone
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate













noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzCertificate.runHi_antitone (hi : ℕ → ℝ) {m n : ℕ} (hmn : m ≤ n) : runHi hi n ≤ runHi hi m := by sorry
