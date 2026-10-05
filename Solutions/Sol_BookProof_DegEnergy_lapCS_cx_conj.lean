-- Generated from ChapterDegEnergyEstimate.lean — solution of BookProof.DegEnergy.lapCS_cx_conj
import Mathlib
import Definitions.Def_ChapterDegEnergyEstimate
import Theorems.Thm_BookProof_DegEnergy_lapCS_conj
import Theorems.Thm_BookProof_DegEnergy_contDiff_cx
open BookProof.DegEnergy




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (S : Finset (Fin d))

set_option maxHeartbeats 1000000 in
theorem solution {χ : Vd d → ℝ} (hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ)
    (S : Finset (Fin d)) (y : Vd d) :
    (starRingEnd ℂ) (lapCS S (cx χ) y) = lapCS S (cx χ) y := by

  rw [lapCS_conj (contDiff_cx hχ) S y]
  congr 1
  funext t
  simp [cx]
