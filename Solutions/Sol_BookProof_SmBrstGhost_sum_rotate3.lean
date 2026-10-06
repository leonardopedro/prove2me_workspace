-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.sum_rotate3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := by

  calc ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ d : Fin n, ∑ a : Fin n, ∑ g : Fin n, F a d g :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := Finset.sum_comm
