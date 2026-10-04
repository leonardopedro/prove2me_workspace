-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.single_eq_otimes
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

theorem BookProof.GradedFock.single_eq_otimes (a : α) (b : β) (c : ℂ) :
    (Finsupp.single (a, b) c : (α × β) →₀ ℂ)
      = otimes (Finsupp.single a c) (Finsupp.single b 1) := by sorry
