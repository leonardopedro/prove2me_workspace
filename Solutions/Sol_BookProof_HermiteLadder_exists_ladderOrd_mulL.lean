-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.exists_ladderOrd_mulL
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_mono
import Theorems.Thm_BookProof_HermiteLadder_ladderOrd_id
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_add
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_smul
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_comp
import Theorems.Thm_BookProof_HermiteLadder_ladderOrd_mulL_X
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : MvPolynomial (Fin d) ℂ) : ∃ n, LadderOrd (mulL q) n := by

  induction q using MvPolynomial.induction_on with
  | C a =>
      refine ⟨0, ?_⟩
      have h : mulL (C a : MvPolynomial (Fin d) ℂ) = a • LinearMap.id := by
        refine LinearMap.ext fun p => ?_
        simp [smul_eq_C_mul]
      rw [h]
      exact ladderOrd_id.smul a
  | add p q hp hq =>
      obtain ⟨n₁, h₁⟩ := hp
      obtain ⟨n₂, h₂⟩ := hq
      refine ⟨max n₁ n₂, ?_⟩
      have h : mulL (p + q) = mulL p + mulL q := by
        refine LinearMap.ext fun r => ?_
        simp [add_mul]
      rw [h]
      exact (h₁.mono (le_max_left _ _)).add (h₂.mono (le_max_right _ _))
  | mul_X p i hp =>
      obtain ⟨n, h⟩ := hp
      refine ⟨n + 1, ?_⟩
      have h' : mulL (p * X i) = mulL p ∘ₗ mulL (X i) := by
        refine LinearMap.ext fun r => ?_
        simp [mul_assoc]
      rw [h']
      exact h.comp (ladderOrd_mulL_X i)
