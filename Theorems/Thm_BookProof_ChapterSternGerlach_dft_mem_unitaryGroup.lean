-- Generated from ChapterSternGerlach.lean — theorem BookProof.ChapterSternGerlach.dft_mem_unitaryGroup
import Mathlib
import Definitions.Def_ChapterSternGerlach
open BookProof.ChapterSternGerlach



open Complex Matrix Finset

theorem BookProof.ChapterSternGerlach.dft_mem_unitaryGroup (n : ℕ) (hn : 0 < n) :
    dftMatrix n ∈ Matrix.unitaryGroup (Fin n) ℂ := by sorry
