-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.otimes_smul_right
import Mathlib
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (v : α →₀ ℂ) (w : β →₀ ℂ) :
    otimes v (c • w) = c • otimes v w := by

  ext p; simp only [otimes_apply, Finsupp.smul_apply, smul_eq_mul]; ring
