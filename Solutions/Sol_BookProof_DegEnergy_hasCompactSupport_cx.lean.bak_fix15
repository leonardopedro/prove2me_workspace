-- Generated from ChapterDegEnergyEstimate.lean — solution of BookProof.DegEnergy.hasCompactSupport_cx
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
theorem solution {χ : Vd d → ℝ} (hχc : HasCompactSupport χ) :
    HasCompactSupport (cx χ) := by

  refine hχc.mono ?_
  intro x hx
  simp only [Function.mem_support, cx, ne_eq, Complex.ofReal_eq_zero] at hx ⊢
  exact hx
