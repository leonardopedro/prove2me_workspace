-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.temple_lower_bound
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



theorem BookProof.RitzCertificate.temple_lower_bound {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {l b : ℝ} {x : F}
    (hsep : SpectralSeparation A l b) (hx : ‖x‖ = 1) (hlt : rayleigh A x < b) :
    rayleigh A x - resid A x ^ 2 / (b - rayleigh A x) ≤ l := by sorry
