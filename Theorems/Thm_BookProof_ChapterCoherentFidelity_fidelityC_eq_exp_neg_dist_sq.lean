-- Generated from ChapterCoherentFidelity.lean — theorem BookProof.ChapterCoherentFidelity.fidelityC_eq_exp_neg_dist_sq
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentFidelity


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}


theorem BookProof.ChapterCoherentFidelity.fidelityC_eq_exp_neg_dist_sq (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k = Real.exp (-‖q - k‖ ^ 2) := by sorry
