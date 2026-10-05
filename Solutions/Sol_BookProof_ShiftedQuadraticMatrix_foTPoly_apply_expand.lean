-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.foTPoly_apply_expand
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
open BookProof.ShiftedQuadraticMatrix




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a k : Vd d) (b b' : Fin d → ℝ) (f : MvPolynomial (Fin d) ℂ) :
    foTPoly a k b b' f
      = ∑ i, ((b i : ℝ) : ℂ) • (X i * f) + ∑ i, ((b' i : ℝ) : ℂ) • momPoly i f
        + ((∑ i, (b i * a i + b' i * k i) : ℝ) : ℂ) • f := by

  have hterm : ∀ i : Fin d,
      ((b i : ℝ) : ℂ) • mulXTPoly a i f + ((b' i : ℝ) : ℂ) • momTPoly k i f
        = ((b i : ℝ) : ℂ) • (X i * f) + ((b' i : ℝ) : ℂ) • momPoly i f
          + ((b i * a i + b' i * k i : ℝ) : ℂ) • f := by
    intro i
    simp only [mulXTPoly_apply, momTPoly_apply, smul_add, smul_smul]
    push_cast
    module
  rw [foTPoly]
  simp only [LinearMap.sum_apply, LinearMap.add_apply, LinearMap.smul_apply]
  rw [Finset.sum_congr rfl fun i _ => hterm i, Finset.sum_add_distrib, Finset.sum_add_distrib,
    ← Finset.sum_smul]
  push_cast
  ring
