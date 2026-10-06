-- Generated from ChapterLorentzTranslation.lean — theorem BookProof.ChapterLorentzTranslation.transPhase_rest
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
open BookProof.ChapterLorentzTranslation



open scoped BigOperators

theorem BookProof.ChapterLorentzTranslation.transPhase_rest (M : ℝ) (x0 : ℝ) (xs : Fin 3 → ℝ) :
    transPhase M (fun _ => 0) x0 xs = Complex.exp (Complex.I * (M : ℂ) * (x0 : ℂ)) := by sorry
