-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.fermiBilin_eq4
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N))
      = ∑ i : Fin N, ∑ j : Fin N, M i j • (creat i * annih j) := rfl
