-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.annih_mul_creat
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmCar_car_annih_creat_of_ne
import Theorems.Thm_BookProof_SmCar_car_annih_creat_self
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * creat q
      = (if p = q then 1 else 0) - creat q * annih p := by

  by_cases h : p = q
  · subst h
    rw [if_pos rfl]
    exact eq_sub_of_add_eq (car_annih_creat_self p)
  · rw [if_neg h]
    exact eq_sub_of_add_eq (car_annih_creat_of_ne h)
