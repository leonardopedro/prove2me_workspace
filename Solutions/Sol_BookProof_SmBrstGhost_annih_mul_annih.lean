-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.annih_mul_annih
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * annih q = -(annih q * annih p) := eq_neg_of_add_eq_zero_left (car_annih_annih p q)
