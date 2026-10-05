-- Generated from ChapterPaleyWienerSampling.lean — solution of BookProof.ChapterPaleyWienerSampling.BandLimited.eq_bandSignal_lp
import Mathlib
import Definitions.Def_ChapterPaleyWienerSampling
import Theorems.Thm_BookProof_ChapterPaleyWienerSampling_bandSignal_bandSpectrumLp
import Theorems.Thm_BookProof_ChapterPaleyWienerSampling_BandLimited_eq_bandSignal
open BookProof.ChapterPaleyWienerSampling




open MeasureTheory Complex AddCircle Set
open scoped Real FourierTransform
open BookProof.ChapterShannonSampling (sinc bandSignal exists_rep half_add_period)

variable {T : ℝ} {f g : ℝ → ℂ}
variable {T : ℝ} [hT : Fact (0 < T)] {f g : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (hf : BandLimited T f) (x : ℝ) :
    f x = bandSignal (T := T) ((bandSpectrumLp hf : Lp ℂ 2 (haarAddCircle (T := T))) :
      AddCircle T → ℂ) x := by

  rw [bandSignal_bandSpectrumLp hf x, hf.eq_bandSignal x]
