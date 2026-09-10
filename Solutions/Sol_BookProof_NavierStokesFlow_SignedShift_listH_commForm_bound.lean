-- Generated from ChapterNavierStokesSignedShift.lean — solution of BookProof.NavierStokesFlow.SignedShift.listH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_hopH_commForm_bound
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift










open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.AffineFiber

variable {ι : Type*}



variable {sym : ι → ℝ} (S : SignedHop ι sym)


































variable {sym : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (L : List (SignedHop ι sym)) (hsym : ∀ β, 1 ≤ sym β) :
    ∃ cst : ℝ, 0 ≤ cst ∧ ∀ x : maxDom sym,
      |commForm (listH L) (diagMax sym) x| ≤ cst * quadForm (diagMax sym) x := by

  induction L with
  | nil =>
      refine ⟨0, le_rfl, fun x => ?_⟩
      have : commForm (listH ([] : List (SignedHop ι sym))) (diagMax sym) x = 0 := by
        simp [commForm, listH]
      rw [this]
      simp
  | cons S L ih =>
      obtain ⟨cst, hcst, hbound⟩ := ih
      refine ⟨2 * S.step * (1 / 4 + S.K) + cst, by nlinarith [S.step_nonneg, S.K_nonneg],
        fun x => ?_⟩
      have h₁ := SignedHop.hopH_commForm_bound S x
      have h₂ := hbound x
      have hadd : commForm (listH (S :: L)) (diagMax sym) x
          = commForm (SignedHop.hopH S) (diagMax sym) x + commForm (listH L) (diagMax sym) x := by
        simpa only [listH_cons] using commForm_add (SignedHop.hopH S) (listH L) (diagMax sym) x
      have hqf : 0 ≤ quadForm (diagMax sym) x :=
        diagMax_quadForm_nonneg _ (fun β => le_trans zero_le_one (hsym β)) x
      rw [hadd]
      refine le_trans (abs_add_le _ _) ?_
      nlinarith [h₁, h₂]
