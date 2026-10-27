-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.inner_eq_integral
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution {u v : HL} {a b : ℝ → ℂ}
    (hu : (u : ℝ → ℂ) =ᵐ[hlMeasure] a) (hv : (v : ℝ → ℂ) =ᵐ[hlMeasure] b) :
    (inner ℂ u v : ℂ) = ∫ x in Ioi (0:ℝ), (starRingEnd ℂ) (a x) * b x := by

  rw [L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [hu, hv] with x h1 h2
  rw [h1, h2, RCLike.inner_apply']
