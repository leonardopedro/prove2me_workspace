-- Generated from ChapterShannonSampling.lean — solution of BookProof.ChapterShannonSampling.integral_haar_eq
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling




open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

set_option maxHeartbeats 1000000 in
theorem solution (g : AddCircle T → ℂ) :
    (T : ℂ) * ∫ z : AddCircle T, g z ∂haarAddCircle
      = ∫ ξ in (-(T / 2))..(-(T / 2) + T), g ξ := by

  rw [AddCircle.intervalIntegral_preimage, AddCircle.volume_eq_smul_haarAddCircle,
    MeasureTheory.integral_smul_measure, ENNReal.toReal_ofReal hT.out.le]
  simp [Complex.real_smul]
