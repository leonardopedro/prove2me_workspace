-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.smStruct_antisymm
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmBrstGhost_sumStruct_antisymm
import Theorems.Thm_BookProof_SmBrstGhost_su2Struct_antisymm
import Theorems.Thm_BookProof_SmBrstGhost_u1Struct_antisymm
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c, f3 a b c = -f3 b a c) (a b c : Fin 12) :
    smStruct f3 a b c = -smStruct f3 b a c := by

  exact sumStruct_antisymm h3
    (sumStruct_antisymm su2Struct_antisymm u1Struct_antisymm) _ _ _
