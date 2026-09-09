-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.runBand_width_le
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate













noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzCertificate.runBand_width_le (lo hi : ℕ → ℝ) (m : ℕ) :
    runHi hi m - runLo lo m ≤ hi m - lo m := by sorry
