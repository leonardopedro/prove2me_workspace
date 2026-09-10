-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.cpoly_linForm
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
theorem solution (v : Fin D → ℝ) : cpoly (linForm v) = linForm v := by

  rw [linForm, cpoly_sum]
  exact Finset.sum_congr rfl fun i _ => by rw [cpoly_real_smul, cpoly_X]
