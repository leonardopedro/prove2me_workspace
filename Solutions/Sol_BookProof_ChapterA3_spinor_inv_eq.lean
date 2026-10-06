-- Generated from ChapterA3i.lean — solution of BookProof.ChapterA3.spinor_inv_eq
import Mathlib
import Definitions.Def_ChapterA3i
import Theorems.Thm_BookProof_ChapterA3_spinor_mul_spinorInv
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ)
    (hdet : T 0 0 * T 1 1 - T 0 1 * T 1 0 = 1) :
    (Spinor T)⁻¹ = SpinorInv T := Matrix.inv_eq_right_inv (spinor_mul_spinorInv T hdet)
