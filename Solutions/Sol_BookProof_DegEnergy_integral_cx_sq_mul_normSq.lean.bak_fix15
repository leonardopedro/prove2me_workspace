-- Generated from ChapterDegEnergyEstimate.lean — solution of BookProof.DegEnergy.integral_cx_sq_mul_normSq
import Mathlib
import Definitions.Def_ChapterDegEnergyEstimate
open BookProof.DegEnergy




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (S : Finset (Fin d))

set_option maxHeartbeats 1000000 in
theorem solution {χ : Vd d → ℝ} (v : Vd d → ℂ) :
    ∀ x : Vd d, cx χ x ^ 2 * (starRingEnd ℂ) (v x) * v x
      = (((χ x) ^ 2 * ‖v x‖ ^ 2 : ℝ) : ℂ) := by

  intro x
  have h : (starRingEnd ℂ) (v x) * v x = ((‖v x‖ ^ 2 : ℝ) : ℂ) := by
    rw [Complex.conj_mul']
    norm_cast
  rw [mul_assoc, h]
  simp [cx]
