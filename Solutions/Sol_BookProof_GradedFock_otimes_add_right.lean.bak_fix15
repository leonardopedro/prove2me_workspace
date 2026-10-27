-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.otimes_add_right
import Mathlib
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (v : α →₀ ℂ) (w w' : β →₀ ℂ) :
    otimes v (w + w') = otimes v w + otimes v w' := by

  ext p; simp [mul_add]
