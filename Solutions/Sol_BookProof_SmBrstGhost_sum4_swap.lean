-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.sum4_swap
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (F : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N)) :
    ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by

  calc ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ q : Fin N × Fin N, ∑ p : Fin N × Fin N, F p.1 p.2 q.1 q.2 := by
        simp [Fintype.sum_prod_type]
    _ = ∑ p : Fin N × Fin N, ∑ q : Fin N × Fin N, F p.1 p.2 q.1 q.2 := Finset.sum_comm
    _ = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by
        simp [Fintype.sum_prod_type]
