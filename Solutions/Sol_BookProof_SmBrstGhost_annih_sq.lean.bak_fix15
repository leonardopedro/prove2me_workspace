-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.annih_sq
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmCar_car_annih_annih
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (i : Fin N) :
    (annih i : Module.End ℂ (FermiFock N)) * annih i = 0 := by

  have h2 : (2 : ℂ) • ((annih i : Module.End ℂ (FermiFock N)) * annih i) = 0 := by
    rw [two_smul]; exact car_annih_annih i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3
