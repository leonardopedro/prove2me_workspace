-- Generated from ChapterScaledDotProduct.lean — solution of BookProof.ChapterScaledDotProduct.sum_sgn_mul_eq_zero
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
import Theorems.Thm_BookProof_ChapterScaledDotProduct_sgn_not
import Theorems.Thm_BookProof_ChapterScaledDotProduct_flipEquiv_apply_self
import Theorems.Thm_BookProof_ChapterScaledDotProduct_flipEquiv_apply_of_ne
open BookProof.ChapterScaledDotProduct



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {i j : Fin d} (hij : i ≠ j) :
    ∑ x : (Fin d → Bool), sgn (x i) * sgn (x j) = 0 := by

  have h : ∑ x : (Fin d → Bool), sgn ((flipEquiv i x) i) * sgn ((flipEquiv i x) j)
      = ∑ x : (Fin d → Bool), sgn (x i) * sgn (x j) :=
    Equiv.sum_comp (flipEquiv i) (fun x => sgn (x i) * sgn (x j))
  have h2 : ∑ x : (Fin d → Bool), sgn ((flipEquiv i x) i) * sgn ((flipEquiv i x) j)
      = -∑ x : (Fin d → Bool), sgn (x i) * sgn (x j) := by
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [flipEquiv_apply_self, flipEquiv_apply_of_ne (Ne.symm hij), sgn_not]
    ring
  linarith [h.symm.trans h2]
