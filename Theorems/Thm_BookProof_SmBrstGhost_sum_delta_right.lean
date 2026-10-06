-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.sum_delta_right
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar
open BookProof.SmBrstGhost

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.sum_delta_right (M P : Matrix (Fin N) (Fin N) ℂ) :
    ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
      = fermiBilin (P * M) := by sorry
