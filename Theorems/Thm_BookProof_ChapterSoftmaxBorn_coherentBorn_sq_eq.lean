-- Generated from ChapterSoftmaxBorn.lean — theorem BookProof.ChapterSoftmaxBorn.coherentBorn_sq_eq
import Mathlib
import Definitions.Def_ChapterSoftmaxBorn
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap
open BookProof.ChapterSoftmaxBorn


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap

variable {n m : ℕ}


theorem BookProof.ChapterSoftmaxBorn.coherentBorn_sq_eq (q k : EuclideanSpace ℝ (Fin n)) :
    bornNumer q k =
      Real.exp (-‖q‖ ^ 2) * Real.exp (-‖k‖ ^ 2) * Real.exp (2 * inner ℝ q k) := by sorry
