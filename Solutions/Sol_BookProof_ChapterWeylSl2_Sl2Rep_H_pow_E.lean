-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.H_pow_E
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_apply_H_E
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_pow_succ_apply
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

set_option maxHeartbeats 1000000 in
theorem solution {w : V} {lam : ℂ} (h : R.H w = lam • w) (k : ℕ) :
    R.H ((R.E ^ k) w) = (lam + 2 * k) • (R.E ^ k) w := by

  induction k with
  | zero => simpa using h
  | succ k ih =>
      rw [pow_succ_apply, apply_H_E, ih, map_smul, two_nsmul]
      push_cast
      module
