-- Generated from ChapterObservableOperator.lean — theorem BookProof.ChapterObservableOperator.observableOp_expectation_mem_convexHull
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



theorem BookProof.ChapterObservableOperator.observableOp_expectation_mem_convexHull
    (b : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin n))) (v : Fin m → ℝ)
    (q : EuclideanSpace ℂ (Fin n)) (hq : ‖q‖ = 1) :
    BookProof.ChapterObservableExpectation.observableExpectation
        (bornProb (fun j => b j) q) v ∈ convexHull ℝ (Set.range v) := by sorry
