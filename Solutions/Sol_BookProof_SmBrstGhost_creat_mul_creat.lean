-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.creat_mul_creat
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (p q : Fin N) :
    (creat p : Module.End ℂ (FermiFock N)) * creat q = -(creat q * creat p) := eq_neg_of_add_eq_zero_left (car_creat_creat p q)
