-- Generated from ChapterHalfLineLimitCircle.lean — theorem BookProof.HalfLineLimitCircle.setIntegral_eq_integral_of_testSpace
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
open BookProof.HalfLineLimitCircle



open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

theorem BookProof.HalfLineLimitCircle.setIntegral_eq_integral_of_testSpace {f : ℝ → ℂ} (hf : f ∈ testSpace) (w : ℝ → ℂ) :
    ∫ x in Ioi (0 : ℝ), (starRingEnd ℂ) (f x) * w x = ∫ x, (starRingEnd ℂ) (f x) * w x := by sorry
