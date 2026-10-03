-- Generated from ChapterPaleyWienerSampling.lean — theorem BookProof.ChapterPaleyWienerSampling.BandLimited.integrable_fourier
import Definitions.Def_ChapterShannonSampling
import Mathlib
import Definitions.Def_ChapterPaleyWienerSampling
import Definitions.Def_ChapterA4

variable {T : ℝ} {f g : ℝ → ℂ}



open MeasureTheory Complex AddCircle Set
open scoped Real FourierTransform
open BookProof.ChapterShannonSampling (sinc bandSignal exists_rep half_add_period)

theorem BookProof.ChapterPaleyWienerSampling.BandLimited.integrable_fourier (hf : BandLimited T f) : Integrable (𝓕 f) := by sorry
