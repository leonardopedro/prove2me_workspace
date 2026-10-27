-- Generated from ChapterEnergyBoundedEvolution.lean — solution of BookProof.ChapterEnergyBoundedEvolution.eLpNorm_difference_quotient_le
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
import Theorems.Thm_BookProof_ChapterEnergyBoundedEvolution_norm_evol_sub_evol_le_ae
open BookProof.ChapterEnergyBoundedEvolution




open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {Emax : ℝ} (h : EnergyLimited E μ Emax f) {t : ℝ}
    (ht : t ≠ 0) :
    eLpNorm (fun x => (evol E t f x - f x) / t) 2 μ ≤ ENNReal.ofReal Emax * eLpNorm f 2 μ := by

  have hae : ∀ᵐ x ∂μ, ‖(evol E t f x - f x) / t‖ ≤ Emax * ‖f x‖ := by
    filter_upwards [norm_evol_sub_evol_le_ae h 0 t] with x hx
    have htpos : (0 : ℝ) < ‖(t : ℂ)‖ := by
      simpa [Complex.norm_real, Real.norm_eq_abs, abs_pos] using ht
    rw [norm_div, div_le_iff₀ htpos]
    calc ‖evol E t f x - f x‖
        = ‖evol E t f x - evol E 0 f x‖ := by rw [evol_zero]
      _ ≤ (|t - 0| * Emax) * ‖f x‖ := hx
      _ = Emax * ‖f x‖ * ‖(t : ℂ)‖ := by
          simp [Complex.norm_real, Real.norm_eq_abs]
          ring
  exact eLpNorm_le_mul_eLpNorm_of_ae_le_mul hae 2
