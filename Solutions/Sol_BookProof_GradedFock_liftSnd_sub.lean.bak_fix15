-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.liftSnd_sub
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_liftSnd_add
import Theorems.Thm_BookProof_GradedFock_liftSnd_neg
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution : liftSnd (α := by

  rw [sub_eq_add_neg, liftSnd_add, liftSnd_neg, sub_eq_add_neg]
