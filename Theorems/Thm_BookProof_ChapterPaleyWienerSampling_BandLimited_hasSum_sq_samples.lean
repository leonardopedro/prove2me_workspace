-- Generated from ChapterPaleyWienerSampling.lean — theorem BookProof.ChapterPaleyWienerSampling.BandLimited.hasSum_sq_samples
import Mathlib
import Definitions.Def_ChapterPaleyWienerSampling
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling
open BookProof.ChapterPaleyWienerSampling
open BookProof.ChapterPaleyWienerSampling

variable {T : ℝ} {f g : ℝ → ℂ}
variable {T : ℝ} [hT : Fact (0 < T)] {f g : ℝ → ℂ}



open MeasureTheory Complex AddCircle Set
open scoped Real FourierTransform
open BookProof.ChapterShannonSampling (sinc bandSignal exists_rep half_add_period)

theorem BookProof.ChapterPaleyWienerSampling.BandLimited.hasSum_sq_samples (hf : BandLimited T f) :
    HasSum (fun n : ℤ => ‖f ((n : ℝ) / T)‖ ^ 2) (T * ∫ ξ : ℝ, ‖𝓕 f ξ‖ ^ 2) := by sorry
