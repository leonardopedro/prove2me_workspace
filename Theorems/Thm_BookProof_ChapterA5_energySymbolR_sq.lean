-- Generated from ChapterA5.lean — theorem BookProof.ChapterA5.energySymbolR_sq
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA5
open BookProof.ChapterA5


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterA5.energySymbolR_sq (p : Fin 3 → ℝ) (m₁ m₂ : ℝ) :
    energySymbolR p m₁ m₂ * energySymbolR p m₁ m₂
      = ((p 0) ^ 2 + (p 1) ^ 2 + (p 2) ^ 2 - m₁ ^ 2 - m₂ ^ 2) •
          (1 : Matrix (Fin 4) (Fin 4) ℝ) := by sorry
