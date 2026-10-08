-- Generated from ChapterA4f.lean — solution of BookProof.ChapterA4f.no_tachyon
import Mathlib
import Definitions.Def_ChapterA4f
import Theorems.Thm_BookProof_ChapterA5_energySymbolR_sq
open BookProof.ChapterA4f



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin 3 → ℝ) (m₁ m₂ : ℝ) :
    energySymbolR p m₁ m₂ * energySymbolR p m₁ m₂
      = ((p 0) ^ 2 + (p 1) ^ 2 + (p 2) ^ 2 - (m₁ ^ 2 + m₂ ^ 2)) •
          (1 : Matrix (Fin 4) (Fin 4) ℝ) := by

            convert BookProof.ChapterA5.energySymbolR_sq p m₁ m₂ using 1 ; ring
