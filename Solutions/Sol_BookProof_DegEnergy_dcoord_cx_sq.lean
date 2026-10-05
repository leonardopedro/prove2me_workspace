-- Generated from ChapterDegEnergyEstimate.lean — solution of BookProof.DegEnergy.dcoord_cx_sq
import Mathlib
import Definitions.Def_ChapterDegEnergyEstimate
import Theorems.Thm_BookProof_DegEnergy_contDiff_cx
import Theorems.Thm_BookProof_QgOneParticleCc_dcoord_mul
open BookProof.DegEnergy




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (S : Finset (Fin d))

set_option maxHeartbeats 1000000 in
theorem solution {χ : Vd d → ℝ} (hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ) (j : Fin d)
    (x : Vd d) : dcoord j (fun y => cx χ y ^ 2) x = 2 * cx χ x * dcoord j (cx χ) x := by

  have h : (fun y => cx χ y ^ 2) = fun y => cx χ y * cx χ y := by funext y; ring
  rw [h, dcoord_mul (contDiff_cx hχ) (contDiff_cx hχ)]
  ring
