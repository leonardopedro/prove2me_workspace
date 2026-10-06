-- Generated from ChapterObservableOperator.lean — theorem BookProof.ChapterObservableOperator.observableOp_expectation
import Mathlib
import Definitions.Def_ChapterObservableOperator
import Definitions.Def_ChapterDoubleSlit
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterDoubleSlit
open BookProof.ChapterObservableExpectation
open BookProof.ChapterObservableOperator

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterObservableOperator.observableOp_expectation (k : Fin m → EuclideanSpace ℂ (Fin n)) (v : Fin m → ℝ)
    (q : EuclideanSpace ℂ (Fin n)) :
    expectation (observableOp k v) q
      = ((BookProof.ChapterObservableExpectation.observableExpectation
            (bornProb k q) v : ℝ) : ℂ) := by sorry
