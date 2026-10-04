-- Generated from ChapterA4h.lean — theorem BookProof.ChapterA4h.not_localizable_of_tachyon
import Definitions.Def_ChapterA4e
import Definitions.Def_ChapterA4f
import Definitions.Def_ChapterA5
import Mathlib
import Definitions.Def_ChapterA4h
import Definitions.Def_ChapterA4
open BookProof.ChapterA4h


open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

theorem BookProof.ChapterA4h.not_localizable_of_tachyon (p : Fin 3 → ℝ) (m₁ m₂ : ℝ)
    (h : p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 < m₁ ^ 2 + m₂ ^ 2) :
    ¬ Localizable p m₁ m₂ := by sorry
