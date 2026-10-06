-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.re_inner_factor
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



theorem BookProof.RitzCertificate.re_inner_factor {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) (l b : ℝ) (x : F) :
    (inner ℂ x ((((A - (l : ℝ) • (1 : F →L[ℂ] F)) *
        (A - (b : ℝ) • (1 : F →L[ℂ] F))) x)) : ℂ).re
      = ‖A x‖ ^ 2 - (l + b) * rayleigh A x + l * b * ‖x‖ ^ 2 := by sorry
