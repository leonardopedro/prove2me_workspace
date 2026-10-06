-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.smStruct_antisymm
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.smStruct_antisymm {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c, f3 a b c = -f3 b a c) (a b c : Fin 12) :
    smStruct f3 a b c = -smStruct f3 b a c := by sorry
