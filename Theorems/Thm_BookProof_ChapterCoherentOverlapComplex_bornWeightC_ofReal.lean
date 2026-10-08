-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.bornWeightC_ofReal
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterCoherentOverlapComplex


open scoped BigOperators

noncomputable section


variable {n m : ℕ}


theorem BookProof.ChapterCoherentOverlapComplex.bornWeightC_ofReal (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    bornWeightC (ofRealVec q) (fun l => ofRealVec (k l)) j
      = BookProof.ChapterSoftmaxBorn.bornWeight q k j := by sorry
