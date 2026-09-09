-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.runLo_mono
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate













noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzCertificate.runLo_mono (lo : ℕ → ℝ) {m n : ℕ} (hmn : m ≤ n) : runLo lo m ≤ runLo lo n := by sorry
