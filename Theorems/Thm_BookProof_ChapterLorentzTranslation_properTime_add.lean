-- Generated from ChapterLorentzTranslation.lean — theorem BookProof.ChapterLorentzTranslation.properTime_add
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
open BookProof.ChapterLorentzTranslation



open scoped BigOperators

theorem BookProof.ChapterLorentzTranslation.properTime_add (w : Fin 3 → ℝ) (x0 y0 : ℝ) (xs ys : Fin 3 → ℝ) :
    properTime w (x0 + y0) (xs + ys) = properTime w x0 xs + properTime w y0 ys := by sorry
