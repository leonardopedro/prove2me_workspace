-- Generated from ChapterWeylSL2Unipotent.lean — solution of BookProof.ChapterWeylSL2Unipotent.expSum_pow_eq_zero
import Mathlib
import Definitions.Def_ChapterWeylSL2Unipotent
open BookProof.ChapterWeylSL2Unipotent




open BookProof.ChapterWeylSl2 BookProof.ChapterWeylSL2Group
open Polynomial

universe u

variable {M : Type*} [AddCommGroup M] [Module ℂ M]
variable {V : Type u} [AddCommGroup V] [Module ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution {A : Module.End ℂ V} {N m : ℕ} (hnil : A ^ N = 0) (hNm : N ≤ m) :
    A ^ m = 0 := by

  rw [show m = N + (m - N) by omega, pow_add, hnil, zero_mul]
