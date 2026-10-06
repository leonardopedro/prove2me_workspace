-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.integral_deriv_eq_zero_of_hasCompactSupport
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {u : ℝ → ℂ} (hu : ContDiff ℝ 1 u)
    (huc : HasCompactSupport u) : ∫ t : ℝ, deriv u t = 0 := by

  have hcd : Continuous (deriv u) := hu.continuous_deriv le_rfl
  have hint : Integrable (deriv u) :=
    hcd.integrable_of_hasCompactSupport (huc.deriv)
  have h1 : ∫ x in Iic (0 : ℝ), deriv u x = u 0 :=
    HasCompactSupport.integral_Iic_deriv_eq hu huc 0
  have h2 : ∫ x in Ioi (0 : ℝ), deriv u x = -u 0 :=
    HasCompactSupport.integral_Ioi_deriv_eq hu huc 0
  have h3 := intervalIntegral.integral_Iic_add_Ioi (μ := volume) (f := deriv u) (b := (0 : ℝ))
    hint.integrableOn hint.integrableOn
  rw [h1, h2] at h3
  simpa using h3.symm
