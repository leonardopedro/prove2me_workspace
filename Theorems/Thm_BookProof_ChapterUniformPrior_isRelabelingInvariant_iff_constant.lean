-- Generated from ChapterUniformPrior.lean — theorem BookProof.ChapterUniformPrior.isRelabelingInvariant_iff_constant
import Mathlib
import Definitions.Def_ChapterUniformPrior
open BookProof.ChapterUniformPrior

variable {Hyp Data : Type*}


open scoped BigOperators



theorem BookProof.ChapterUniformPrior.isRelabelingInvariant_iff_constant (p : Hyp → ℝ) :
    IsRelabelingInvariant p ↔ ∃ c : ℝ, p = fun _ => c := by sorry
