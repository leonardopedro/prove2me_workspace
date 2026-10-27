-- Generated from ChapterPaleyWienerSampling.lean — solution of BookProof.ChapterPaleyWienerSampling.bandSignal_bandSpectrumLp
import Mathlib
import Definitions.Def_ChapterPaleyWienerSampling
import Theorems.Thm_BookProof_ChapterPaleyWienerSampling_bandSignal_congr_ae
open BookProof.ChapterPaleyWienerSampling




open MeasureTheory Complex AddCircle Set
open scoped Real FourierTransform
open BookProof.ChapterShannonSampling (sinc bandSignal exists_rep half_add_period)

variable {T : ℝ} {f g : ℝ → ℂ}
variable {T : ℝ} [hT : Fact (0 < T)] {f g : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (hf : BandLimited T f) (x : ℝ) :
    bandSignal (T := T) ((bandSpectrumLp hf : Lp ℂ 2 (haarAddCircle (T := T))) :
        AddCircle T → ℂ) x
      = bandSignal (T := T) (bandSpectrum T f) x := bandSignal_congr_ae (memLp_bandSpectrum hf).coeFn_toLp x
