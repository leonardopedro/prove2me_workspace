-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.coherentBornC_cancel_q
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.coherentBornC_cancel_q (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC q k j =
      Real.exp (-‖k j‖ ^ 2) * Real.exp (2 * (inner ℂ q (k j) : ℂ).re) /
        ∑ l, Real.exp (-‖k l‖ ^ 2) * Real.exp (2 * (inner ℂ q (k l) : ℂ).re) := by sorry
