-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.epsZ_antisymm
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : ∀ a b c : Fin 3, epsZ a b c = -epsZ b a c := by
 decide
