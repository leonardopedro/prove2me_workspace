-- Generated from ChapterHalfLineLimitCircle.lean — theorem BookProof.HalfLineLimitCircle.integral_deriv2_mul
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Definitions.Def_ChapterA4



open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

theorem BookProof.HalfLineLimitCircle.integral_deriv2_mul (f : ℝ → ℂ) (hf : f ∈ testSpace) (w : ℝ → ℂ)
    (hw : ContDiff ℝ smoothTop w) :
    ∫ x in Ioi (0 : ℝ), (starRingEnd ℂ) (deriv (deriv f) x) * w x
      = ∫ x in Ioi (0 : ℝ), (starRingEnd ℂ) (f x) * deriv (deriv w) x := by sorry
