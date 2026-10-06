-- Generated from ChapterSternGerlach.lean — solution of BookProof.ChapterSternGerlach.dft_column_sum
import Mathlib
import Definitions.Def_ChapterSternGerlach
import Theorems.Thm_BookProof_ChapterSternGerlach_dft_normSq
open BookProof.ChapterSternGerlach




open Complex Matrix Finset

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (hn : 0 < n) (j : Fin n) :
    ∑ i, Complex.normSq (dftMatrix n i j) = 1 := by

  rw [Finset.sum_congr rfl (fun i _ => dft_normSq n hn i j)]
  rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  field_simp
