-- Generated from ChapterUniformPrior.lean — solution of BookProof.ChapterUniformPrior.eq_of_isRelabelingInvariant
import Mathlib
import Definitions.Def_ChapterUniformPrior
open BookProof.ChapterUniformPrior



open scoped BigOperators


variable {Hyp Data : Type*}

variable {Hyp Data : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (p : Hyp → ℝ)
    (hp : IsRelabelingInvariant p) (a b : Hyp) : p a = p b := by

  classical
  have h := congr_fun (hp (Equiv.swap a b)) b
  simpa [Function.comp_apply] using h
