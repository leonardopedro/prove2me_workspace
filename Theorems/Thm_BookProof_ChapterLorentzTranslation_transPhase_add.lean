-- Generated from ChapterLorentzTranslation.lean — theorem BookProof.ChapterLorentzTranslation.transPhase_add
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
open BookProof.ChapterLorentzTranslation



open scoped BigOperators

theorem BookProof.ChapterLorentzTranslation.transPhase_add (M : ℝ) (w : Fin 3 → ℝ) (x0 y0 : ℝ) (xs ys : Fin 3 → ℝ) :
    transPhase M w (x0 + y0) (xs + ys) = transPhase M w x0 xs * transPhase M w y0 ys := by sorry
