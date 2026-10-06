-- Generated from ChapterParity.lean — solution of BookProof.ChapterParity.higgsParity_pow_four
import Mathlib
import Definitions.Def_ChapterParity
import Theorems.Thm_BookProof_ChapterParity_higgsParity_sq
open BookProof.ChapterParity



open Matrix
open scoped ComplexConjugate

variable {n : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    higgsParity * higgsParity * (higgsParity * higgsParity) = 1 := by

  rw [higgsParity_sq]; simp
