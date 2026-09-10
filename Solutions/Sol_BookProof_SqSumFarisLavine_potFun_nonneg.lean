-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.potFun_nonneg
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution (v : R → Fin D → ℝ) (x : Vd D) : 0 ≤ potFun v x := by

  rw [potFun]
  have : (0 : ℝ) ≤ ∑ r : R, (linFun (v r) x) ^ 2 :=
    Finset.sum_nonneg fun r _ => sq_nonneg _
  linarith
