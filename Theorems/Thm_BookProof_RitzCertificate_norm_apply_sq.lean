-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.norm_apply_sq
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



theorem BookProof.RitzCertificate.norm_apply_sq (A : F →L[ℂ] F) (x : F) (hx : ‖x‖ = 1) :
    ‖A x‖ ^ 2 = resid A x ^ 2 + rayleigh A x ^ 2 := by sorry
