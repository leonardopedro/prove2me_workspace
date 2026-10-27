-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.su2Struct_jacobi
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmBrstGhost_epsZ_jacobi
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (a b c h : Fin 3) :
    ∑ e, (su2Struct a b e * su2Struct e c h + su2Struct b c e * su2Struct e a h
      + su2Struct c a e * su2Struct e b h) = 0 := by

  have hz := epsZ_jacobi a b c h
  have : ((∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h
      + epsZ c a e * epsZ e b h) : ℤ) : ℝ) = 0 := by rw [hz]; norm_num
  rw [← this]
  push_cast [su2Struct]
  ring
