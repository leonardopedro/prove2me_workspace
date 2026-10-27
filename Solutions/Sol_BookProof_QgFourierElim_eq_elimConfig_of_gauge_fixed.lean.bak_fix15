-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.eq_elimConfig_of_gauge_fixed
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
open BookProof.QgFourierElim




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.QgVielbeinScalaronGaugeFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (w : Comp → ℂ)
    (h : ∀ mu nu i, formValue k (dGaugeF mu nu i) w = 0) :
    w = elimConfig k (fun p => w (eIdx p.1 p.2)) := by

  funext c
  match c with
  | Sum.inl (nu, i) => rfl
  | Sum.inr (mu, nu, i) =>
      have h1 := h mu nu i
      rw [formValue_dGauge] at h1
      change w (dIdx mu nu i) = Complex.I * ((k mu : ℤ) : ℂ) * w (eIdx nu i)
      linear_combination h1
