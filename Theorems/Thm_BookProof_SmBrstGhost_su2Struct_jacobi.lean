-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.su2Struct_jacobi
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.su2Struct_jacobi (a b c h : Fin 3) :
    ∑ e, (su2Struct a b e * su2Struct e c h + su2Struct b c e * su2Struct e a h
      + su2Struct c a e * su2Struct e b h) = 0 := by sorry
