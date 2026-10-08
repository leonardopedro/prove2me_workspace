-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.smGhostCharge_nilpotent
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

theorem BookProof.SmBrstGhost.smGhostCharge_nilpotent (m : ℕ) {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3anti : ∀ a b c, f3 a b c = -f3 b a c)
    (h3jac : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) :
    smGhostCharge m f3 * smGhostCharge m f3 = 0 := by sorry
