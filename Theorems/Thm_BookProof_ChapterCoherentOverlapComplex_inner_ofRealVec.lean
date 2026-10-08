-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.inner_ofRealVec
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex


open scoped BigOperators

noncomputable section


variable {n m : ℕ}


theorem BookProof.ChapterCoherentOverlapComplex.inner_ofRealVec (q k : EuclideanSpace ℝ (Fin n)) :
    inner ℂ (ofRealVec q) (ofRealVec k) = ((inner ℝ q k : ℝ) : ℂ) := by sorry
