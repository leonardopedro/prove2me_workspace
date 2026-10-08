-- Generated from ChapterObservableOperator.lean — theorem BookProof.ChapterObservableOperator.observableOp_isHermitian
import Mathlib
import Definitions.Def_ChapterObservableOperator
open BookProof.ChapterObservableOperator


open scoped BigOperators

noncomputable section


variable {n m : ℕ}


theorem BookProof.ChapterObservableOperator.observableOp_isHermitian (k : Fin m → EuclideanSpace ℂ (Fin n)) (v : Fin m → ℝ) :
    (observableOp k v).IsHermitian := by sorry
