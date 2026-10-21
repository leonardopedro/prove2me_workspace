-- Generated from ChapterConvolutionCalc.lean — solution of BookProof.ConvolutionCalc.hasCompactSupport_dcoord
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
open BookProof.ConvolutionCalc




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {ρ : Vd d → ℂ}
    (hc : HasCompactSupport ρ) (j : Fin d) : HasCompactSupport (dcoord j ρ) := by

  refine (hc.fderiv ℝ).mono ?_
  intro x hx
  simp only [Function.mem_support, dcoord] at hx ⊢
  intro h
  exact hx (by rw [h]; simp)
