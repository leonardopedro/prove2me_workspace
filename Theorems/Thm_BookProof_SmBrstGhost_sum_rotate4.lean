-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.sum_rotate4
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.sum_rotate4 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, ∑ a : Fin n, F a d g h
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h := by sorry
