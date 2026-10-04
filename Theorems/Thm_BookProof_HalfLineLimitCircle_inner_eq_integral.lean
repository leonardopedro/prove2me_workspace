-- Generated from ChapterHalfLineLimitCircle.lean — theorem BookProof.HalfLineLimitCircle.inner_eq_integral
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Definitions.Def_ChapterA4
open BookProof.HalfLineLimitCircle



open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

theorem BookProof.HalfLineLimitCircle.inner_eq_integral {u v : HL} {a b : ℝ → ℂ}
    (hu : (u : ℝ → ℂ) =ᵐ[hlMeasure] a) (hv : (v : ℝ → ℂ) =ᵐ[hlMeasure] b) :
    (inner ℂ u v : ℂ) = ∫ x in Ioi (0:ℝ), (starRingEnd ℂ) (a x) * b x := by sorry
