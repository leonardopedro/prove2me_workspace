-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimCoord_vgIdx
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l : Fin 3 → ℝ) (i j : Fin 3) :
    lagElimCoord l (vgIdx i j) = C (Complex.I * (((l j : ℝ)) : ℂ)) * X (vIdx12 i) := by

  have hi : i.val < 3 := i.isLt
  have hj : j.val < 3 := j.isLt
  have hv : (vgIdx i j).val = 18 + 3 * i.val + j.val := rfl
  have h1 : ¬ (vgIdx i j).val < 3 := by omega
  have h2 : ¬ (vgIdx i j).val < 6 := by omega
  have h3 : ¬ (vgIdx i j).val < 9 := by omega
  have h4 : ¬ (vgIdx i j).val < 18 := by omega
  have h5 : (vgIdx i j).val < 27 := by omega
  have hsub : ((vgIdx i j).val - 18) = 3 * i.val + j.val := by omega
  have hmod : (3 * i.val + j.val) % 3 = j.val := by
    rw [Nat.mul_add_mod, Nat.mod_eq_of_lt hj]
  have hdiv : (3 * i.val + j.val) / 3 = i.val := by
    rw [Nat.mul_add_div (by norm_num : 0 < 3), Nat.div_eq_of_lt hj, Nat.add_zero]
  rw [lagElimCoord, dif_neg h1, dif_neg h2, dif_neg h3, dif_neg h4, dif_pos h5]
  simp only [hsub, hmod, hdiv, Fin.eta]
