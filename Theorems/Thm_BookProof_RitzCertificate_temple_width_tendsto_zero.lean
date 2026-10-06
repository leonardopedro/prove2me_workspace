-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.temple_width_tendsto_zero
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



theorem BookProof.RitzCertificate.temple_width_tendsto_zero {A : F →L[ℂ] F} {b delta : ℝ} {x : ℕ → F}
    (hdelta : 0 < delta) (hle : ∀ m, rayleigh A (x m) ≤ b - delta)
    (hres : Tendsto (fun m => resid A (x m)) atTop (𝓝 0)) :
    Tendsto (fun m => rayleigh A (x m) -
      (rayleigh A (x m) - resid A (x m) ^ 2 / (b - rayleigh A (x m)))) atTop (𝓝 0) := by sorry
