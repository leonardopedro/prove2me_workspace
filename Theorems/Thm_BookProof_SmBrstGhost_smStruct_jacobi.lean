-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.smStruct_jacobi
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.smStruct_jacobi {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) (a b c h : Fin 12) :
    ∑ e, (smStruct f3 a b e * smStruct f3 e c h + smStruct f3 b c e * smStruct f3 e a h
      + smStruct f3 c a e * smStruct f3 e b h) = 0 := by sorry
