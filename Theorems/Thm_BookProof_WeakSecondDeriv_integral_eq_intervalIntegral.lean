-- Generated from ChapterWeakSecondDerivative.lean — theorem BookProof.WeakSecondDeriv.integral_eq_intervalIntegral
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv



open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

theorem BookProof.WeakSecondDeriv.integral_eq_intervalIntegral {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F]
    {f : ℝ → F} {R a b : ℝ} (hR : 0 ≤ R)
    (hf : ∀ x, x ∉ Icc (-R) R → f x = 0) (ha : a < -R) (hb : R < b) :
    ∫ x, f x = ∫ x in a..b, f x := by sorry
