-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.otimes_smul_right
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSuperBracket
import Mathlib
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFock

variable {α β : Type*}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

theorem BookProof.GradedFock.otimes_smul_right (c : ℂ) (v : α →₀ ℂ) (w : β →₀ ℂ) :
    otimes v (c • w) = c • otimes v w := by sorry
