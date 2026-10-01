-- Generated from ChapterSchrodingerCutoffEsa.lean — theorem BookProof.SchrodingerCutoff.schrodingerOp_apply
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
open BookProof.SchrodingerCutoff



open MeasureTheory Filter Complex

 -deriv (deriv f) x + (V x : ℂ) * f x

theorem BookProof.SchrodingerCutoff.schrodingerOp_apply (V : ℝ → ℝ) (f f' f'' : ℝ → ℂ)
    (hf1 : ∀ x, HasDerivAt f (f' x) x) (hf2 : ∀ x, HasDerivAt f' (f'' x) x) (x : ℝ) :
    schrodin := by sorry
