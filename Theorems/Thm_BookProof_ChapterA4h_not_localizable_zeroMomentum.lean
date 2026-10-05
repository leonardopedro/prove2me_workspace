-- Generated from ChapterA4h.lean — theorem BookProof.ChapterA4h.not_localizable_zeroMomentum
import Definitions.Def_ChapterA4e
import Definitions.Def_ChapterA4f
import Definitions.Def_ChapterA5
import Mathlib
import Definitions.Def_ChapterA4h
open BookProof.ChapterA4h


open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

theorem BookProof.ChapterA4h.not_localizable_zeroMomentum (m₁ m₂ : ℝ) (h : m₁ ^ 2 + m₂ ^ 2 ≠ 0) :
    ¬ Localizable (fun _ => 0) m₁ m₂ := by sorry
