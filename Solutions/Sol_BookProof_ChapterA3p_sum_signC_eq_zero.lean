-- Generated from ChapterA3p.lean — solution of BookProof.ChapterA3p.sum_signC_eq_zero
import Mathlib
import Definitions.Def_ChapterA3p
open BookProof.ChapterA3p



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (hN : 2 ≤ N) :
    ∑ σ : Equiv.Perm (Fin N), signC σ = 0 := by

  have h_transposition : ∃ t : Equiv.Perm (Fin N), Equiv.Perm.sign t = -1 := by
    exact ⟨ Equiv.swap ⟨ 0, by linarith ⟩ ⟨ 1, by linarith ⟩, by simp ⟩;
  obtain ⟨ t, ht ⟩ := h_transposition;    have := Equiv.sum_comp ( Equiv.mulLeft t ) ( fun x =>
      signC x ) ; simp_all only [signC, Equiv.coe_mulLeft, Equiv.Perm.sign_mul, neg_mul, one_mul,
          Units.val_neg, Int.cast_neg, Finset.sum_neg_distrib] ;
  linear_combination' -this / 2
