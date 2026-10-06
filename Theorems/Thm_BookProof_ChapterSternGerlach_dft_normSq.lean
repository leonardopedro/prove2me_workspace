-- Generated from ChapterSternGerlach.lean — theorem BookProof.ChapterSternGerlach.dft_normSq
import Mathlib
import Definitions.Def_ChapterSternGerlach
open BookProof.ChapterSternGerlach



open Complex Matrix Finset

theorem BookProof.ChapterSternGerlach.dft_normSq (n : ℕ) (hn : 0 < n) (i j : Fin n) :
    Complex.normSq (dftMatrix n i j) = 1 / n := by sorry
