-- Generated from ChapterObservableOperator.lean — solution of BookProof.ChapterObservableOperator.bornProb_sum_one
import Mathlib
import Definitions.Def_ChapterObservableOperator
open BookProof.ChapterObservableOperator



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin n)))
    (q : EuclideanSpace ℂ (Fin n)) (hq : ‖q‖ = 1) :
    ∑ j, bornProb (fun j => b j) q j = 1 := by

  simpa [bornProb, hq] using b.sum_sq_norm_inner_right q
