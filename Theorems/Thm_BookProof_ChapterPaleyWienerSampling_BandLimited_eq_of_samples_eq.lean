-- Generated from ChapterPaleyWienerSampling.lean — theorem BookProof.ChapterPaleyWienerSampling.BandLimited.eq_of_samples_eq
import Mathlib
import Definitions.Def_ChapterPaleyWienerSampling
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling
open BookProof.ChapterPaleyWienerSampling
open BookProof.ChapterPaleyWienerSampling



open MeasureTheory Complex AddCircle Set
open scoped Real FourierTransform
open BookProof.ChapterShannonSampling (sinc bandSignal exists_rep half_add_period)

variable {T : ℝ} {f g : ℝ → ℂ}
variable {T : ℝ} [hT : Fact (0 < T)] {f g : ℝ → ℂ}

theorem BookProof.ChapterPaleyWienerSampling.BandLimited.eq_of_samples_eq (hf : BandLimited T f) (hg : BandLimited T g)
    (h : ∀ n : ℤ, f ((n : ℝ) / T) = g ((n : ℝ) / T)) : f = g := by sorry
