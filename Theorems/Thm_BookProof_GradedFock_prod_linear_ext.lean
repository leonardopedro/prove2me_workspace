-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.prod_linear_ext
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

theorem BookProof.GradedFock.prod_linear_ext {N : Type*} [AddCommGroup N] [Module ℂ N]
    {f g : ((α × β) →₀ ℂ) →ₗ[ℂ] N}
    (h : ∀ (v : α →₀ ℂ) (w : β →₀ ℂ), f (otimes v w) = g (otimes v w)) : f = g := by sorry
