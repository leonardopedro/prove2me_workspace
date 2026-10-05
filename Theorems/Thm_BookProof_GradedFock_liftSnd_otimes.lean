-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.liftSnd_otimes
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

theorem BookProof.GradedFock.liftSnd_otimes (S : (β →₀ ℂ) →ₗ[ℂ] (β →₀ ℂ)) (v : α →₀ ℂ) (w : β →₀ ℂ) :
    liftSnd S (otimes v w) = otimes v (S w) := by sorry
