-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.smGhostCAR
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmBrstGhost_ghostMode_injective
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) : GhostCAR (ghostCre m) (ghostAnn m) := by

  refine ⟨fun a b => ?_, fun a b => ?_, fun a b => ?_⟩
  · exact car_creat_creat (ghostMode m a) (ghostMode m b)
  · exact car_annih_annih (ghostMode m a) (ghostMode m b)
  · by_cases h : a = b
    · subst h
      rw [if_pos rfl]
      exact car_annih_creat_self (ghostMode m a)
    · rw [if_neg h]
      exact car_annih_creat_of_ne (fun hh => h (ghostMode_injective m hh))
