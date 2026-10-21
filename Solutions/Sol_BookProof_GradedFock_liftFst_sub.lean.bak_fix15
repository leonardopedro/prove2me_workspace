-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.liftFst_sub
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_liftFst_add
import Theorems.Thm_BookProof_GradedFock_liftFst_neg
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution : liftFst (β := by

  rw [sub_eq_add_neg, liftFst_add, liftFst_neg, sub_eq_add_neg]
