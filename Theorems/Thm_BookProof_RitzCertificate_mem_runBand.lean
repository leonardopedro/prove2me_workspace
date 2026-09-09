-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.mem_runBand
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate













noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzCertificate.mem_runBand {lo hi : ℕ → ℝ} {lam : ℝ} (h : ∀ m, lam ∈ Set.Icc (lo m) (hi m)) (m : ℕ) :
    lam ∈ Set.Icc (runLo lo m) (runHi hi m) := by sorry
