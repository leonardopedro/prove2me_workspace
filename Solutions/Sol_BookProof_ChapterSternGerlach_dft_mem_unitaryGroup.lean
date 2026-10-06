-- Generated from ChapterSternGerlach.lean — solution of BookProof.ChapterSternGerlach.dft_mem_unitaryGroup
import Mathlib
import Definitions.Def_ChapterSternGerlach
import Theorems.Thm_BookProof_ChapterSternGerlach_dft_unitary
open BookProof.ChapterSternGerlach




open Complex Matrix Finset

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (hn : 0 < n) :
    dftMatrix n ∈ Matrix.unitaryGroup (Fin n) ℂ := by

  rw [Matrix.mem_unitaryGroup_iff]
  exact dft_unitary n hn
