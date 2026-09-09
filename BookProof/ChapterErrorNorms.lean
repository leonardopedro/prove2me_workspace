import Mathlib

/-!
# Average (`L²`) versus maximal (`L^∞`) error

`book.tex` (~8405–8414) contrasts two ways of measuring the error of a
probabilistic model: the **average error**, which is the `L²` norm of the
wave-function `√ρ` attached to a probability density `ρ`, and the **maximal
error**, which is the `L^∞` (essential supremum) norm.  The book's point is that
on a probability space the average error is always dominated by the maximal
error, and that the wave function `√ρ` is automatically normalized when `ρ` is.

This module proves that measure-theoretic core:

* `wavefunction_l2_norm_sq_eq_integral` — `∫ (√ρ)² = ∫ ρ`, i.e. the squared `L²`
  norm of the wave function is the total mass of the density (`= 1` for a
  probability density);
* `wavefunction_lintegral_sq_eq_integral` — the same identity for the unsigned
  (`ℝ≥0∞`-valued) integral, valid with no integrability hypothesis;
* `wavefunction_lintegral_sq_eq_one` — consequently `‖√ρ‖₂² = 1` for a
  probability density;
* `l2_le_linfty_of_finite` — on a probability space, `‖f‖₂ ≤ ‖f‖_∞`: the average
  error never exceeds the maximal error;
* `l2_le_of_ae_bound` — the quantitative form: an almost-everywhere bound `C` on
  the pointwise error bounds the average error by `C`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory

namespace BookProof.ChapterErrorNorms

variable {α : Type*} [MeasurableSpace α]

/-- The squared `L²` norm of the wave function `√ρ` is the integral of the
density `ρ`.  For a probability density this says `‖√ρ‖₂² = 1`. -/
theorem wavefunction_l2_norm_sq_eq_integral (mu : Measure α) (rho : α → ℝ)
    (hrho : ∀ x, 0 ≤ rho x) :
    ∫ x, (Real.sqrt (rho x)) ^ 2 ∂mu = ∫ x, rho x ∂mu :=
  integral_congr_ae (Filter.Eventually.of_forall fun x => Real.sq_sqrt (hrho x))

/-- Unsigned form of `wavefunction_l2_norm_sq_eq_integral`: no integrability
hypothesis is needed for the `ℝ≥0∞`-valued integral. -/
theorem wavefunction_lintegral_sq_eq_integral (mu : Measure α) (rho : α → ℝ)
    (hrho : ∀ x, 0 ≤ rho x) :
    ∫⁻ x, (ENNReal.ofReal (Real.sqrt (rho x))) ^ 2 ∂mu
      = ∫⁻ x, ENNReal.ofReal (rho x) ∂mu := by
  refine lintegral_congr fun x => ?_
  rw [sq, ← ENNReal.ofReal_mul (Real.sqrt_nonneg _), Real.mul_self_sqrt (hrho x)]

/-- For a probability density `ρ` (nonnegative, of total mass `1`) the wave
function `√ρ` has unit `L²` norm. -/
theorem wavefunction_lintegral_sq_eq_one (mu : Measure α) (rho : α → ℝ)
    (hrho : ∀ x, 0 ≤ rho x) (hmass : ∫⁻ x, ENNReal.ofReal (rho x) ∂mu = 1) :
    ∫⁻ x, (ENNReal.ofReal (Real.sqrt (rho x))) ^ 2 ∂mu = 1 := by
  rw [wavefunction_lintegral_sq_eq_integral mu rho hrho, hmass]

/-- **Average error ≤ maximal error.**  On a probability space the `L²` norm is
dominated by the `L^∞` norm. -/
theorem l2_le_linfty_of_finite (mu : Measure α) [IsProbabilityMeasure mu]
    (f : α → ℝ) (hf : AEStronglyMeasurable f mu) :
    eLpNorm f 2 mu ≤ eLpNorm f ⊤ mu :=
  eLpNorm_le_eLpNorm_of_exponent_le le_top hf

/-- Quantitative form: an almost-everywhere bound on the pointwise error bounds
the average (`L²`) error. -/
theorem l2_le_of_ae_bound (mu : Measure α) [IsProbabilityMeasure mu]
    (f : α → ℝ) (C : ℝ) (hf : AEStronglyMeasurable f mu)
    (hC : ∀ᵐ x ∂mu, ‖f x‖ ≤ C) :
    eLpNorm f 2 mu ≤ ENNReal.ofReal C :=
  le_trans (l2_le_linfty_of_finite mu f hf) (eLpNormEssSup_le_of_ae_bound hC)

end BookProof.ChapterErrorNorms
