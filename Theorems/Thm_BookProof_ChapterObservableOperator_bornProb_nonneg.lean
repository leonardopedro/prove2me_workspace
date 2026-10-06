-- Generated from ChapterObservableOperator.lean — theorem BookProof.ChapterObservableOperator.bornProb_nonneg
import Mathlib
import Definitions.Def_ChapterObservableOperator
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit
open BookProof.ChapterObservableOperator

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterObservableOperator.bornProb_nonneg (k : Fin m → EuclideanSpace ℂ (Fin n))
    (q : EuclideanSpace ℂ (Fin n)) (j : Fin m) : 0 ≤ bornProb k q j := by sorry
