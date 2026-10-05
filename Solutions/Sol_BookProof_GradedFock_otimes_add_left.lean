-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.otimes_add_left
import Mathlib
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (v v' : α →₀ ℂ) (w : β →₀ ℂ) :
    otimes (v + v') w = otimes v w + otimes v' w := by

  ext p; simp [add_mul]
