-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.sum4_swap
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.SmBrstGhost

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.sum4_swap (F : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N)) :
    ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by sorry
