-- Generated from ChapterObservableOperator.lean — theorem BookProof.ChapterObservableOperator.bornProb_sum_one
import Mathlib
import Definitions.Def_ChapterObservableOperator
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit
open BookProof.ChapterObservableOperator


open scoped BigOperators

noncomputable section


variable {n m : ℕ}


theorem BookProof.ChapterObservableOperator.bornProb_sum_one (b : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin n)))
    (q : EuclideanSpace ℂ (Fin n)) (hq : ‖q‖ = 1) :
    ∑ j, bornProb (fun j => b j) q j = 1 := by sorry
