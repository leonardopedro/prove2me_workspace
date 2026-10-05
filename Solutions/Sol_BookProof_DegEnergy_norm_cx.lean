-- Generated from ChapterDegEnergyEstimate.lean — solution of BookProof.DegEnergy.norm_cx
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
theorem solution (χ : Vd d → ℝ) (x : Vd d) : ‖cx χ x‖ = |χ x| := by
  simp [cx]

/-- The partial Laplacian of a real-valued function is real. -/
theorem lapCS_cx_conj {χ : Vd d → ℝ} (hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ)
    (S : Finset (Fin d)) (y : Vd d) :
    (starRingEnd ℂ) (lapCS S (cx χ) y) = lapCS S (cx χ) y := by

  simp [cx]
