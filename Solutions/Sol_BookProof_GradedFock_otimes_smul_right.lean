-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.otimes_smul_right
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
theorem solution (c : ℂ) (v : α →₀ ℂ) (w : β →₀ ℂ) :
    otimes v (c • w) = c • otimes v w := by

  ext p; simp only [otimes_apply, Finsupp.smul_apply, smul_eq_mul]; ring
