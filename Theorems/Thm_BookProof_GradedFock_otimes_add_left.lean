-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.otimes_add_left
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterSuperBracket
import Mathlib
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterA4
open BookProof.GradedFock

variable {α β : Type*}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

theorem BookProof.GradedFock.otimes_add_left (v v' : α →₀ ℂ) (w : β →₀ ℂ) :
    otimes (v + v') w = otimes v w + otimes v' w := by sorry
