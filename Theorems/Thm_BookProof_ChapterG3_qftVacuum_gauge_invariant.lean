-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.qftVacuum_gauge_invariant
import Mathlib
import Definitions.Def_ChapterG3
import Definitions.Def_ChapterA4
open BookProof.ChapterG3

variable {X : Type*}


open MeasureTheory
open scoped ENNReal




theorem BookProof.ChapterG3.qftVacuum_gauge_invariant (k : ℕ)
    (L : EuclideanSpace ℝ (Fin k) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin k)) :
    (qftVacuum k).map L = qftVacuum k := by sorry
