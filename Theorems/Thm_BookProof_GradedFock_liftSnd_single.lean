-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.liftSnd_single
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

theorem BookProof.GradedFock.liftSnd_single (S : (β →₀ ℂ) →ₗ[ℂ] (β →₀ ℂ)) (a : α) (b : β) (c : ℂ) :
    liftSnd (α := by sorry
