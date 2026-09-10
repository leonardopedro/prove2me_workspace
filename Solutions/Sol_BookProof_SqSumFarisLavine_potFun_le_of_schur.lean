-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.potFun_le_of_schur
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Theorems.Thm_BookProof_SqSumFarisLavine_schur_bound
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution {v : R → Fin D → ℝ} {a b : ℝ} (ha0 : 0 ≤ a)
    (ha : ∀ r, ∑ i : Fin D, |v r i| ≤ a) (hb : ∀ i, ∑ r : R, |v r i| ≤ b) (x : Vd D) :
    potFun v x ≤ (a * b / 2) * ‖x‖ ^ 2 := by

  have hs := schur_bound v ha0 ha hb (fun i => x i)
  rw [← norm_sq_eq_sum x] at hs
  rw [potFun]
  have hlin : ∀ r : R, linFun (v r) x = ∑ i : Fin D, v r i * x i := fun r => rfl
  simp only [hlin]
  linarith
