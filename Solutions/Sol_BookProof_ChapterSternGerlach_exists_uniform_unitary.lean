-- Generated from ChapterSternGerlach.lean — solution of BookProof.ChapterSternGerlach.exists_uniform_unitary
import Mathlib
import Definitions.Def_ChapterSternGerlach
import Theorems.Thm_BookProof_ChapterSternGerlach_dft_normSq
import Theorems.Thm_BookProof_ChapterSternGerlach_dft_mem_unitaryGroup
open BookProof.ChapterSternGerlach




open Complex Matrix Finset

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (hn : 0 < n) :
    ∃ U ∈ Matrix.unitaryGroup (Fin n) ℂ,
      ∀ i j : Fin n, Complex.normSq (U i j) = 1 / n := ⟨dftMatrix n, dft_mem_unitaryGroup n hn, fun i j => dft_normSq n hn i j⟩
