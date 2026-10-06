-- Generated from ChapterA4e.lean — solution of BookProof.ChapterA4e.energy_sign_not_conserved
import Mathlib
import Definitions.Def_ChapterA4e
import Theorems.Thm_BookProof_ChapterA4e_projPos_spatialOp_commutator
open BookProof.ChapterA4e



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ j : Fin 3, projPos * spatialOp j ≠ spatialOp j * projPos := by

  refine ⟨0, fun h => ?_⟩
  have hcomm : Complex.I • (spatialOp 0 * enSign) = 0 := by
    rw [← projPos_spatialOp_commutator 0, h, sub_self]
  have hM : spatialOp 0 * enSign = 0 :=
    (smul_eq_zero.mp hcomm).resolve_left Complex.I_ne_zero
  have hentry : (spatialOp 0 * enSign) 0 0 = 0 := by rw [hM]; rfl
  rw [spatialOp, enSign, ← map_mul, RingHom.mapMatrix_apply, Matrix.map_apply,
    eq_intCast, Int.cast_eq_zero] at hentry
  revert hentry
  decide
