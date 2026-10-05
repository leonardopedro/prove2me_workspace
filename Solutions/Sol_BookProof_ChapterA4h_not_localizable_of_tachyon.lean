-- Generated from ChapterA4h.lean — solution of BookProof.ChapterA4h.not_localizable_of_tachyon
import Mathlib
import Definitions.Def_ChapterA4h
import Theorems.Thm_BookProof_ChapterA4h_localizable_iff_massShell
open BookProof.ChapterA4h



open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin 3 → ℝ) (m₁ m₂ : ℝ)
    (h : p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 < m₁ ^ 2 + m₂ ^ 2) :
    ¬ Localizable p m₁ m₂ := by

  rw [localizable_iff_massShell]
  intro heq
  linarith [heq]
