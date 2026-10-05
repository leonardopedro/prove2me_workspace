-- Generated from ChapterPaleyWienerSampling.lean — theorem BookProof.ChapterPaleyWienerSampling.bandSignal_congr_ae
import Mathlib
import Definitions.Def_ChapterPaleyWienerSampling
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling
open BookProof.ChapterPaleyWienerSampling

variable {T : ℝ} {f g : ℝ → ℂ}
variable {T : ℝ} [hT : Fact (0 < T)] {f g : ℝ → ℂ}



open MeasureTheory Complex AddCircle Set
open scoped Real FourierTransform
open BookProof.ChapterShannonSampling (sinc bandSignal exists_rep half_add_period)

theorem BookProof.ChapterPaleyWienerSampling.bandSignal_congr_ae {F G : AddCircle T → ℂ} (h : F =ᵐ[haarAddCircle (T := T)] G)
    (x : ℝ) : bandSignal (T := T) F x = bandSignal (T := T) G x := by sorry
