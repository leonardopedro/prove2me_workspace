-- Generated from ChapterUniformPrior.lean — theorem BookProof.ChapterUniformPrior.normalized_isRelabelingInvariant_eq_uniform
import Mathlib
import Definitions.Def_ChapterUniformPrior
open BookProof.ChapterUniformPrior


open scoped BigOperators


variable {Hyp Data : Type*}


theorem BookProof.ChapterUniformPrior.normalized_isRelabelingInvariant_eq_uniform [Fintype Hyp] [Nonempty Hyp]
    (p : Hyp → ℝ) (hp : IsRelabelingInvariant p) (hsum : ∑ x, p x = 1) :
    p = fun _ => (1 : ℝ) / Fintype.card Hyp := by sorry
