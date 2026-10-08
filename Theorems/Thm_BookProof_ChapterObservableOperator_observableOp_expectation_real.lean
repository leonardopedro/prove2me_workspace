-- Generated from ChapterObservableOperator.lean — theorem BookProof.ChapterObservableOperator.observableOp_expectation_real
import Mathlib
import Definitions.Def_ChapterObservableOperator
import Definitions.Def_ChapterDoubleSlit
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterDoubleSlit
open BookProof.ChapterObservableExpectation
open BookProof.ChapterObservableOperator


open scoped BigOperators

noncomputable section


variable {n m : ℕ}


theorem BookProof.ChapterObservableOperator.observableOp_expectation_real (k : Fin m → EuclideanSpace ℂ (Fin n))
    (v : Fin m → ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    (expectation (observableOp k v) q).im = 0 := by sorry
