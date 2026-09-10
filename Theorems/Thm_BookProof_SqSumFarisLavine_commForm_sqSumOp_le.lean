-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.commForm_sqSumOp_le
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.SqSumFarisLavine












open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

theorem BookProof.SqSumFarisLavine.commForm_sqSumOp_le {kappa : Fin D → ℝ} {v : R → Fin D → ℝ} {km M : ℝ}
    (hkm : 0 ≤ km) (hk : ∀ j, |kappa j| ≤ km) (hM0 : 0 ≤ M)
    (hM : ∀ x : Vd D, ∑ k : Fin D, (gradFun v k x) ^ 2 ≤ M ^ 2 * ‖x‖ ^ 2)
    (u : polyGaussCore (d := D)) :
    |commForm (sqSumOp kappa v) harmCore u| ≤ (km / 2 + 2 * M) * quadForm harmCore u := by sorry
