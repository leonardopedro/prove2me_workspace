-- Generated from ChapterSchrodingerCutoffEsa.lean — theorem BookProof.SchrodingerCutoff.eq_zero_of_setIntegral_Icc_eq_zero
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
open BookProof.SchrodingerCutoff



open MeasureTheory Filter Complex

theorem BookProof.SchrodingerCutoff.eq_zero_of_setIntegral_Icc_eq_zero {f : ℝ → ℝ} (hf : Continuous f)
    (h0 : ∀ x, 0 ≤ f x)
    (h : ∀ n : ℕ, ∫ x in Set.Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1), f x = 0) :
    f = 0 := by sorry
