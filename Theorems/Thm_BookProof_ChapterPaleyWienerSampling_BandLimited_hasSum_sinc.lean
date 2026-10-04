-- Generated from ChapterPaleyWienerSampling.lean — theorem BookProof.ChapterPaleyWienerSampling.BandLimited.hasSum_sinc
import Mathlib
import Definitions.Def_ChapterPaleyWienerSampling
import Definitions.Def_ChapterShannonSampling
import Definitions.Def_ChapterA4
open BookProof.ChapterShannonSampling
open BookProof.ChapterPaleyWienerSampling

variable {T : ℝ} {f g : ℝ → ℂ}
variable {T : ℝ} [hT : Fact (0 < T)] {f g : ℝ → ℂ}



open MeasureTheory Complex AddCircle Set
open scoped Real FourierTransform
open BookProof.ChapterShannonSampling (sinc bandSignal exists_rep half_add_period)

theorem BookProof.ChapterPaleyWienerSampling.BandLimited.hasSum_sinc (hf : BandLimited T f) (x : ℝ) :
    HasSum (fun n : ℤ => f ((n : ℝ) / T) * (sinc (T * x - n) : ℝ)) (f x) := by sorry
