-- Generated from ChapterA4h.lean — solution of BookProof.ChapterA4h.not_localizable_zeroMomentum
import Mathlib
import Definitions.Def_ChapterA4h
import Theorems.Thm_BookProof_ChapterA4h_localizable_iff_massShell
open BookProof.ChapterA4h



open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (m₁ m₂ : ℝ) (h : m₁ ^ 2 + m₂ ^ 2 ≠ 0) :
    ¬ Localizable (fun _ => 0) m₁ m₂ := by

  rw [localizable_iff_massShell]
  intro heq
  apply h
  norm_num at heq
  linarith [heq]
