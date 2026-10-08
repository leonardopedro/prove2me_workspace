-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.sum_rotate3
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}

theorem BookProof.SmBrstGhost.sum_rotate3 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := by sorry
