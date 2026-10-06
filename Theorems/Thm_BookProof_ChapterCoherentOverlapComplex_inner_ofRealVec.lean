-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.inner_ofRealVec
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.inner_ofRealVec (q k : EuclideanSpace ℝ (Fin n)) :
    inner ℂ (ofRealVec q) (ofRealVec k) = ((inner ℝ q k : ℝ) : ℂ) := by sorry
