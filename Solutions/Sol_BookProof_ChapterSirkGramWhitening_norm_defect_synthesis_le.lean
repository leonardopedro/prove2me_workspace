-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.norm_defect_synthesis_le
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_sum_norm_coord_le
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m d : ℕ} (w : Fin m → E)
    (V : EuclideanSpace ℂ (Fin d) →L[ℂ] E) {delta : ℝ}
    (hdelta : ∀ i, ‖w i - V (ContinuousLinearMap.adjoint V (w i))‖ ≤ delta)
    (c : EuclideanSpace ℂ (Fin m)) :
    ‖synthesis w c - V (ContinuousLinearMap.adjoint V (synthesis w c))‖
      ≤ delta * (Real.sqrt m * ‖c‖) := by

  rcases Nat.eq_zero_or_pos m with hm | hm
  · subst hm
    simp
  have hd0 : 0 ≤ delta := le_trans (norm_nonneg _) (hdelta ⟨0, hm⟩)
  have hsplit : synthesis w c - V (ContinuousLinearMap.adjoint V (synthesis w c))
      = ∑ i, c i • (w i - V (ContinuousLinearMap.adjoint V (w i))) := by
    simp only [synthesis_apply, smul_sub, Finset.sum_sub_distrib, map_sum, map_smul]
  rw [hsplit]
  refine le_trans (norm_sum_le _ _) ?_
  have hterm : ∀ i : Fin m, ‖c i • (w i - V (ContinuousLinearMap.adjoint V (w i)))‖
      ≤ ‖c i‖ * delta := by
    intro i
    rw [norm_smul]
    exact mul_le_mul_of_nonneg_left (hdelta i) (norm_nonneg _)
  calc ∑ i, ‖c i • (w i - V (ContinuousLinearMap.adjoint V (w i)))‖
      ≤ ∑ i, ‖c i‖ * delta := Finset.sum_le_sum fun i _ => hterm i
    _ = delta * ∑ i, ‖c i‖ := by rw [← Finset.sum_mul]; ring
    _ ≤ delta * (Real.sqrt m * ‖c‖) :=
        mul_le_mul_of_nonneg_left (sum_norm_coord_le c) hd0
