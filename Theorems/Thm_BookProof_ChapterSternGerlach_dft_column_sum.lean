-- Generated from ChapterSternGerlach.lean — theorem BookProof.ChapterSternGerlach.dft_column_sum
import Mathlib
import Definitions.Def_ChapterSternGerlach
open BookProof.ChapterSternGerlach



open Complex Matrix Finset

theorem BookProof.ChapterSternGerlach.dft_column_sum (n : ℕ) (hn : 0 < n) (j : Fin n) :
    ∑ i, Complex.normSq (dftMatrix n i j) = 1 := by sorry
