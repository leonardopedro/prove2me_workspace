-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.u1Struct_jacobi
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.u1Struct_jacobi (a b c h : Fin 1) :
    ∑ e, (u1Struct a b e * u1Struct e c h + u1Struct b c e * u1Struct e a h
      + u1Struct c a e * u1Struct e b h) = 0 := by sorry
