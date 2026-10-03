-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.cpoly_linForm
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Theorems.Thm_BookProof_GaussCoreQuadBounds_cpoly_real_smul
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_X
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_sum
open BookProof.SqSumFarisLavine




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin D → ℝ) : cpoly (linForm v) = linForm v := by

  rw [linForm, cpoly_sum]
  exact Finset.sum_congr rfl fun i _ => by rw [cpoly_real_smul, cpoly_X]
