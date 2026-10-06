-- Generated from ChapterShannonSampling.lean — solution of BookProof.ChapterShannonSampling.bandSignal_eq_inner
import Mathlib
import Definitions.Def_ChapterShannonSampling
import Theorems.Thm_BookProof_ChapterShannonSampling_bandSignal_eq_circle_integral
import Theorems.Thm_BookProof_ChapterShannonSampling_integral_haar_eq
import Theorems.Thm_BookProof_ChapterShannonSampling_inner_kernLp_apply
open BookProof.ChapterShannonSampling




open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

set_option maxHeartbeats 1000000 in
theorem solution (F : Lp ℂ 2 (haarAddCircle (T := T))) (x : ℝ) :
    bandSignal (T := T) (F : AddCircle T → ℂ) x
      = (T : ℂ) * inner ℂ (kernLp (T := T) x) F := by

  rw [inner_kernLp_apply, integral_haar_eq, bandSignal_eq_circle_integral,
    ← AddCircle.intervalIntegral_preimage T (-(T / 2))]
