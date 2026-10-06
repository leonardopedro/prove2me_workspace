-- Generated from ChapterPaleyWienerSampling.lean — solution of BookProof.ChapterPaleyWienerSampling.BandLimited.hasSum_sinc
import Mathlib
import Definitions.Def_ChapterPaleyWienerSampling
import Theorems.Thm_BookProof_ChapterPaleyWienerSampling_BandLimited_eq_bandSignal_lp
open BookProof.ChapterPaleyWienerSampling
open BookProof.ChapterPaleyWienerSampling.BandLimited




open MeasureTheory Complex AddCircle Set
open scoped Real FourierTransform
open BookProof.ChapterShannonSampling (sinc bandSignal exists_rep half_add_period)

variable {T : ℝ} {f g : ℝ → ℂ}
variable {T : ℝ} [hT : Fact (0 < T)] {f g : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (hf : BandLimited T f) (x : ℝ) :
    HasSum (fun n : ℤ => f ((n : ℝ) / T) * (sinc (T * x - n) : ℝ)) (f x) := by

  have hbase := ChapterShannonSampling.bandSignal_hasSum_sinc (bandSpectrumLp hf) x
  rw [← hf.eq_bandSignal_lp x] at hbase
  refine hbase.congr_fun fun n => ?_
  rw [hf.eq_bandSignal_lp ((n : ℝ) / T)]
