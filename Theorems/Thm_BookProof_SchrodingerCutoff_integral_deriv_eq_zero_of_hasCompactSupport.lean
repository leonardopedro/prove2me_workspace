-- Generated from ChapterSchrodingerCutoffEsa.lean — theorem BookProof.SchrodingerCutoff.integral_deriv_eq_zero_of_hasCompactSupport
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
open BookProof.SchrodingerCutoff



open MeasureTheory Filter Complex

theorem BookProof.SchrodingerCutoff.integral_deriv_eq_zero_of_hasCompactSupport
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
    {g g' : ℝ → E} (h : ∀ x, HasDerivAt g (g' x) x) (hc : Continuous g')
    (hs : HasCompactSupport g) : ∫ x, g' x = 0 := by sorry
