-- Generated from ChapterCoherentOverlap.lean — theorem BookProof.ChapterCoherentOverlap.coherentOverlap_eq
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.ChapterCoherentOverlap

variable {n : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlap.coherentOverlap_eq (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k =
      Real.exp (-(∑ i, q i * q i) / 2 - (∑ i, k i * k i) / 2 + ∑ i, q i * k i) := by sorry
