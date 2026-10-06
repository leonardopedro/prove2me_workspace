-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.runBands_nested
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterSirkRitzSpectrum
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure
open BookProof.RitzCertificate

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure



theorem BookProof.RitzCertificate.runBands_nested (lo hi : ℕ → ℝ) : NestedBands (runLo lo) (runHi hi) := by sorry
