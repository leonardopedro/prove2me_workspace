-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.rotVec_transpose
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
open BookProof.QuadraticRotationPerturbed




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.SignFlip
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.KatoRellich
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (b : Fin d → ℝ) :
    rotVec O (rotVec Oᵀ b) = b := by

  have hOO : O * Oᵀ = 1 := mul_eq_one_comm.mp hO
  funext k
  simp only [rotVec, Matrix.transpose_apply]
  have : ∀ i : Fin d, O k i * ∑ j, O j i * b j = ∑ j, (O k i * O j i) * b j := by
    intro i
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun j _ => by ring
  rw [Finset.sum_congr rfl fun i _ => this i, Finset.sum_comm]
  have hj : ∀ j : Fin d, ∑ i, (O k i * O j i) * b j = (if k = j then (1 : ℝ) else 0) * b j := by
    intro j
    rw [← Finset.sum_mul]
    congr 1
    have h1 := congrFun (congrFun hOO k) j
    simpa [Matrix.mul_apply, Matrix.one_apply, Matrix.transpose_apply] using h1
  rw [Finset.sum_congr rfl fun j _ => hj j]
  simp
