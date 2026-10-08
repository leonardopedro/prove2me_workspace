-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.bornNumerC_ofReal
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
import Theorems.Thm_BookProof_ChapterCoherentOverlapComplex_coherentOverlapC_ofReal
import Theorems.Thm_BookProof_ChapterCoherentOverlap_coherentOverlap_pos
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    bornNumerC (ofRealVec q) (ofRealVec k)
      = BookProof.ChapterSoftmaxBorn.bornNumer q k := by

  rw [bornNumerC, coherentOverlapC_ofReal, BookProof.ChapterSoftmaxBorn.bornNumer,
    Complex.norm_real, Real.norm_eq_abs,
    abs_of_pos (BookProof.ChapterCoherentOverlap.coherentOverlap_pos q k)]
