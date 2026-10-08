-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.otimes_add_right
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSuperBracket
import Mathlib
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFock



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}

theorem BookProof.GradedFock.otimes_add_right (v : α →₀ ℂ) (w w' : β →₀ ℂ) :
    otimes v (w + w') = otimes v w + otimes v w' := by sorry
