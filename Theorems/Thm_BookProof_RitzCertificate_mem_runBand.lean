-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.mem_runBand
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterBandEnclosure
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure



theorem BookProof.RitzCertificate.mem_runBand {lo hi : ℕ → ℝ} {lam : ℝ} (h : ∀ m, lam ∈ Set.Icc (lo m) (hi m)) (m : ℕ) :
    lam ∈ Set.Icc (runLo lo m) (runHi hi m) := by sorry
