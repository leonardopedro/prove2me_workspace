-- Generated from ChapterA3m.lean — solution of BookProof.ChapterA3m.swap13_kronecker
import Mathlib
import Definitions.Def_ChapterA3m
open BookProof.ChapterA3m



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

set_option maxHeartbeats 1000000 in
theorem solution (A B C : Matrix (Fin 4) (Fin 4) ℂ) :
    swap13 * ((A ⊗ₖ B) ⊗ₖ C) = ((C ⊗ₖ B) ⊗ₖ A) * swap13 := by

  unfold swap13;
  ext ⟨ ⟨ i, j ⟩, k ⟩ ⟨ ⟨ l, m ⟩, n ⟩ ; simp only [mul_apply, of_apply, kroneckerMap_apply, ite_mul,
      one_mul, zero_mul, Finset.sum_ite, not_and, Finset.sum_const_zero, add_zero, mul_ite, mul_one,
          mul_zero] ; ring;
  refine Finset.sum_bij ( fun x hx => ( ⟨ n, m ⟩, l ) ) ?_ ?_ ?_ ?_ <;> simp;
  · aesop;
  · grind
