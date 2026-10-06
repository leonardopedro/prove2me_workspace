-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.nested_certificate_of_bands
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



theorem BookProof.RitzCertificate.nested_certificate_of_bands {lo hi : ℕ → ℝ} {lam : ℝ}
    (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    NestedBands (runLo lo) (runHi hi) ∧ (∀ m, lam ∈ Set.Icc (runLo lo m) (runHi hi m)) ∧
      Tendsto (fun m => runHi hi m - runLo lo m) atTop (𝓝 0) := by sorry
