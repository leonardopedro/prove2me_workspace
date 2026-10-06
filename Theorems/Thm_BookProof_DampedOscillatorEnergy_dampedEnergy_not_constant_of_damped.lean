-- Generated from ChapterDampedOscillatorEnergy.lean — theorem BookProof.DampedOscillatorEnergy.dampedEnergy_not_constant_of_damped
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy



open MeasureTheory

theorem BookProof.DampedOscillatorEnergy.dampedEnergy_not_constant_of_damped {lam omega : ℝ} {x v a : ℝ → ℝ}
    (hlam : 0 < lam) (hx : ∀ t, HasDerivAt x (v t) t) (hv : ∀ t, HasDerivAt v (a t) t)
    (heq : ∀ t, a t + lam * v t + omega ^ 2 * x t = 0) {t₀ : ℝ} (hmove : v t₀ ≠ 0) :
    ¬ ∃ E : ℝ, ∀ t, dampedEnergy omega x v t = E := by sorry
