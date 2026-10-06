-- Generated from ChapterSternGerlach.lean — theorem BookProof.ChapterSternGerlach.dft_unitary
import Mathlib
import Definitions.Def_ChapterSternGerlach
open BookProof.ChapterSternGerlach



open Complex Matrix Finset

theorem BookProof.ChapterSternGerlach.dft_unitary (n : ℕ) (hn : 0 < n) :
    dftMatrix n * star (dftMatrix n) = 1 := by sorry
