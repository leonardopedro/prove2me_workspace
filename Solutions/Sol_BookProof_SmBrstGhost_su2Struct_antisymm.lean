-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.su2Struct_antisymm
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmBrstGhost_epsZ_antisymm
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (a b c : Fin 3) : su2Struct a b c = -su2Struct b a c := by

  rw [su2Struct, su2Struct, epsZ_antisymm a b c]
  push_cast
  ring
