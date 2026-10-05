-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.single_eq_otimes
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_otimes_single
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (a : α) (b : β) (c : ℂ) :
    (Finsupp.single (a, b) c : (α × β) →₀ ℂ)
      = otimes (Finsupp.single a c) (Finsupp.single b 1) := by

  rw [otimes_single, mul_one]
