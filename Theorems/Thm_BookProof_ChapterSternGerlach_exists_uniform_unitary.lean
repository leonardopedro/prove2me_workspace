-- Generated from ChapterSternGerlach.lean — theorem BookProof.ChapterSternGerlach.exists_uniform_unitary
import Mathlib
import Definitions.Def_ChapterSternGerlach
open BookProof.ChapterSternGerlach



open Complex Matrix Finset

theorem BookProof.ChapterSternGerlach.exists_uniform_unitary (n : ℕ) (hn : 0 < n) :
    ∃ U ∈ Matrix.unitaryGroup (Fin n) ℂ,
      ∀ i j : Fin n, Complex.normSq (U i j) = 1 / n := by sorry
