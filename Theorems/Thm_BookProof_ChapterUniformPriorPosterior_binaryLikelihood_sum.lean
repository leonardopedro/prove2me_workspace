-- Generated from ChapterUniformPriorPosterior.lean — theorem BookProof.ChapterUniformPriorPosterior.binaryLikelihood_sum
import Mathlib
import Definitions.Def_ChapterUniformPriorPosterior
open BookProof.ChapterUniformPriorPosterior

variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]


open scoped BigOperators



theorem BookProof.ChapterUniformPriorPosterior.binaryLikelihood_sum (q : Hyp → ℝ) (x : Hyp) :
    ∑ observed : Bool, binaryLikelihood q x observed = 1 := by sorry
