-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimCoord_sIdx
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
theorem solution (l : Fin 3 → ℝ) (i : Fin 3) :
    lagElimCoord l (sIdx i)
      = -C (((∑ j : Fin 3, (l j) ^ 2 : ℝ)) : ℂ) * X (vIdx12 i) := by

  have hv : (sIdx i).val = 27 + i.val := rfl
  have h1 : ¬ (sIdx i).val < 3 := by rw [hv]; omega
  have h2 : ¬ (sIdx i).val < 6 := by rw [hv]; omega
  have h3 : ¬ (sIdx i).val < 9 := by rw [hv]; omega
  have h4 : ¬ (sIdx i).val < 18 := by rw [hv]; omega
  have h5 : ¬ (sIdx i).val < 27 := by rw [hv]; omega
  have h6 : (sIdx i).val < 30 := by rw [hv]; omega
  have hlt3 : (sIdx i).val - 27 < 3 := by omega
  rw [lagElimCoord, dif_neg h1, dif_neg h2, dif_neg h3, dif_neg h4, dif_neg h5, dif_pos h6]
  have hx : (⟨(sIdx i).val - 27, hlt3⟩ : Fin 3) = i := by
    apply Fin.ext
    change (sIdx i).val - 27 = i.val
    rw [hv]; omega
  simp only [hx]
