-- Generated from ChapterPaleyWienerSampling.lean — theorem BookProof.ChapterPaleyWienerSampling.BandLimited.eq_bandSignal
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

theorem BookProof.ChapterPaleyWienerSampling.BandLimited.eq_bandSignal (hf : BandLimited T f) (x : ℝ) :
    f x = bandSignal (T := T) (bandSpectrum T f) x := by sorry
