-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.epsZ_jacobi
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.epsZ_jacobi : ∀ a b c h : Fin 3,
    ∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h + epsZ c a e * epsZ e b h) = 0 := by sorry
