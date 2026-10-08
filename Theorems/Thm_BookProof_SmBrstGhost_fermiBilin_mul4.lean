-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.fermiBilin_mul4
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

theorem BookProof.SmBrstGhost.fermiBilin_mul4 (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N)) * fermiBilin P
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
          (M i j * P k l) • ((creat i * annih j) * (creat k * annih l)) := by sorry
