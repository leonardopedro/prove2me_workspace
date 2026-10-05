-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.liftFst_otimes
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

theorem BookProof.GradedFock.liftFst_otimes (T : (α →₀ ℂ) →ₗ[ℂ] (α →₀ ℂ)) (v : α →₀ ℂ) (w : β →₀ ℂ) :
    liftFst T (otimes v w) = otimes (T v) w := by sorry
