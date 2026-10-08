-- Generated from ChapterCoherentFidelity.lean — theorem BookProof.ChapterCoherentFidelity.bornWeightC_eq_scoreSoftmax_neg_dist_sq
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterCoherentFidelity


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}


theorem BookProof.ChapterCoherentFidelity.bornWeightC_eq_scoreSoftmax_neg_dist_sq (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC q k j = scoreSoftmax 1 (fun l => -‖q - k l‖ ^ 2) j := by sorry
