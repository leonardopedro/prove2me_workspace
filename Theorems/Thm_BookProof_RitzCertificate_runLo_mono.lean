-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.runLo_mono
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



theorem BookProof.RitzCertificate.runLo_mono (lo : ℕ → ℝ) {m n : ℕ} (hmn : m ≤ n) : runLo lo m ≤ runLo lo n := by sorry
