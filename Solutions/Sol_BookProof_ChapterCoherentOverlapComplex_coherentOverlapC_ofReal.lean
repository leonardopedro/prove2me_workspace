-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_ofReal
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
import Theorems.Thm_BookProof_ChapterCoherentOverlapComplex_norm_ofRealVec
import Theorems.Thm_BookProof_ChapterCoherentOverlapComplex_inner_ofRealVec
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlapC (ofRealVec q) (ofRealVec k)
      = ((BookProof.ChapterCoherentOverlap.coherentOverlap q k : ℝ) : ℂ) := by

  rw [coherentOverlapC, inner_ofRealVec, norm_ofRealVec, norm_ofRealVec,
    BookProof.ChapterCoherentOverlap.coherentOverlap, Complex.ofReal_exp]
  congr 1
  push_cast
  ring
