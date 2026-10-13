-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.otimes_add_right
import Mathlib
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSuperBracket
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
