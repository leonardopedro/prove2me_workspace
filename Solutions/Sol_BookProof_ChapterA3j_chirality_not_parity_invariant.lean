-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.chirality_not_parity_invariant
import Mathlib
import Definitions.Def_ChapterA3j
import Theorems.Thm_BookProof_ChapterA3j_projChirL_parity_commutator
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    projChirL * mgamma 0 ≠ mgamma 0 * projChirL := by

  intro h
  have hcomm : Complex.I • (mgamma 0 * chir) = 0 := by
    rw [← projChirL_parity_commutator, h, sub_self]
  have hM : mgamma 0 * chir = 0 :=
    (smul_eq_zero.mp hcomm).resolve_left Complex.I_ne_zero
  have hentry : (mgamma 0 * chir) 0 3 = 0 := by rw [hM]; rfl
  rw [chir, mgamma, mgamma5, ← map_mul, RingHom.mapMatrix_apply, Matrix.map_apply,
    eq_intCast, Int.cast_eq_zero] at hentry
  revert hentry
  decide
