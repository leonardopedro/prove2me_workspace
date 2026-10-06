-- Generated from ChapterObservableOperator.lean — theorem BookProof.ChapterObservableOperator.observable_expectation_born
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



theorem BookProof.ChapterObservableOperator.observable_expectation_born (b : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin n)))
    (v : Fin m → ℝ) (q : EuclideanSpace ℂ (Fin n)) (hq : ‖q‖ = 1) :
    (∀ j, 0 ≤ bornProb (fun j => b j) q j) ∧
      (∑ j, bornProb (fun j => b j) q j = 1) ∧
      expectation (observableOp (fun j => b j) v) q
        = ((∑ j, bornProb (fun j => b j) q j * v j : ℝ) : ℂ) := by sorry
