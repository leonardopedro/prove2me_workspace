-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.norm_lt_of_mol_ne_zero
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
open BookProof.DegKatoEsa




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {y : Vd d} (hy : mol d n y ≠ 0) :
    ‖y‖ < 1 / ((n : ℝ) + 1) := by

  have h : y ∈ Function.support (mol d n) := hy
  rw [mol, (molBump d n).support_normed_eq] at h
  simp only [Metric.mem_ball, dist_zero_right] at h
  exact h
