-- Generated from ChapterScaledDotProduct.lean — solution of BookProof.ChapterScaledDotProduct.sum_sgn_eq_zero
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
import Theorems.Thm_BookProof_ChapterScaledDotProduct_sgn_not
import Theorems.Thm_BookProof_ChapterScaledDotProduct_flipEquiv_apply_self
open BookProof.ChapterScaledDotProduct



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : ∑ x : (Fin d → Bool), sgn (x i) = 0 := by

  have h : ∑ x : (Fin d → Bool), sgn ((flipEquiv i x) i)
      = ∑ x : (Fin d → Bool), sgn (x i) :=
    Equiv.sum_comp (flipEquiv i) (fun x => sgn (x i))
  have h2 : ∑ x : (Fin d → Bool), sgn ((flipEquiv i x) i)
      = -∑ x : (Fin d → Bool), sgn (x i) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun x _ => by
      rw [flipEquiv_apply_self, sgn_not]
  linarith [h.symm.trans h2]
