-- Generated from ChapterEnergyBoundedEvolution.lean — solution of BookProof.ChapterEnergyBoundedEvolution.norm_evol_apply
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution




open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (f : X → ℂ) (x : X) : ‖evol E t f x‖ = ‖f x‖ := by

  have h : Complex.exp (-(Complex.I * (t * E x)))
      = Complex.exp (Complex.I * ((-(t * E x) : ℝ) : ℂ)) := by
    congr 1
    push_cast
    ring
  rw [evol, h, norm_mul, Complex.norm_exp_I_mul_ofReal, one_mul]
