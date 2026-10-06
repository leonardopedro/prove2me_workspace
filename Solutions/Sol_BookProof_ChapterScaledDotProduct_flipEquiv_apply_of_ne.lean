-- Generated from ChapterScaledDotProduct.lean — solution of BookProof.ChapterScaledDotProduct.flipEquiv_apply_of_ne
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {i j : Fin d} (h : j ≠ i) (x : Fin d → Bool) :
    (flipEquiv i x) j = x j := by

  simp [flipEquiv, flipAt, Function.update_of_ne h]
