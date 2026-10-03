-- Generated from ChapterPaleyWienerSampling.lean — theorem BookProof.ChapterPaleyWienerSampling.bandSignal_bandSpectrumLp
import Mathlib
import Definitions.Def_ChapterPaleyWienerSampling
import Definitions.Def_ChapterShannonSampling
import Definitions.Def_ChapterA4
open BookProof.ChapterShannonSampling

variable {T : ℝ} {f g : ℝ → ℂ}
variable {T : ℝ} [hT : Fact (0 < T)] {f g : ℝ → ℂ}



open MeasureTheory Complex AddCircle Set
open scoped Real FourierTransform
open BookProof.ChapterShannonSampling (sinc bandSignal exists_rep half_add_period)

theorem BookProof.ChapterPaleyWienerSampling.bandSignal_bandSpectrumLp (hf : BandLimited T f) (x : ℝ) :
    bandSignal (T := T) ((bandSpectrumLp hf : Lp ℂ 2 (haarAddCircle (T := T))) :
        AddCircle T → ℂ) x
      = bandSignal (T := T) (bandSpectrum T f) x := by sorry
