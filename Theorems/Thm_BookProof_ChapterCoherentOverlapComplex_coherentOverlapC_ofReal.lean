-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_ofReal
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_ofReal (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlapC (ofRealVec q) (ofRealVec k)
      = ((BookProof.ChapterCoherentOverlap.coherentOverlap q k : ℝ) : ℂ) := by sorry
