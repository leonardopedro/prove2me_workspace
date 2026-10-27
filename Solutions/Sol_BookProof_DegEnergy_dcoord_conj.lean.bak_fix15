-- Generated from ChapterDegEnergyEstimate.lean — solution of BookProof.DegEnergy.dcoord_conj
import Mathlib
import Definitions.Def_ChapterDegEnergyEstimate
open BookProof.DegEnergy




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {v : Vd d → ℂ} (hv : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) v) (j : Fin d)
    (x : Vd d) :
    dcoord j (fun y => (starRingEnd ℂ) (v y)) x = (starRingEnd ℂ) (dcoord j v x) := by

  have hd : HasFDerivAt v (fderiv ℝ v x) x :=
    (hv.differentiable (by simp)).differentiableAt.hasFDerivAt
  have hc : HasFDerivAt (fun y => (starRingEnd ℂ) (v y))
      ((Complex.conjLIE.toLinearIsometry.toContinuousLinearMap).comp (fderiv ℝ v x)) x :=
    (Complex.conjLIE.toLinearIsometry.toContinuousLinearMap.hasFDerivAt).comp x hd
  simp only [dcoord]
  rw [hc.fderiv]
  rfl
