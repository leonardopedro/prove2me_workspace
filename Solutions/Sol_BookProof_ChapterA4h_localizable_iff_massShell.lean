-- Generated from ChapterA4h.lean — solution of BookProof.ChapterA4h.localizable_iff_massShell
import Mathlib
import Definitions.Def_ChapterA4h
import Theorems.Thm_BookProof_ChapterA5_energySymbolR_sq
open BookProof.ChapterA4h



open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin 3 → ℝ) (m₁ m₂ : ℝ) :
    Localizable p m₁ m₂ ↔ p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 = m₁ ^ 2 + m₂ ^ 2 := by

  unfold Localizable;
  rw [ isUnit_iff_ne_zero ];
  have := congr_arg Matrix.det ( energySymbolR_sq p m₁ m₂ ) ; norm_num at this;
  grind
