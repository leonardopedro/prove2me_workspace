-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.bornNumerC_ofReal
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterCoherentOverlap
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterCoherentOverlap
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterCoherentOverlapComplex


open scoped BigOperators

noncomputable section


variable {n m : ℕ}


theorem BookProof.ChapterCoherentOverlapComplex.bornNumerC_ofReal (q k : EuclideanSpace ℝ (Fin n)) :
    bornNumerC (ofRealVec q) (ofRealVec k)
      = BookProof.ChapterSoftmaxBorn.bornNumer q k := by sorry
