-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.runBand_width_le
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



theorem BookProof.RitzCertificate.runBand_width_le (lo hi : ℕ → ℝ) (m : ℕ) :
    runHi hi m - runLo lo m ≤ hi m - lo m := by sorry
