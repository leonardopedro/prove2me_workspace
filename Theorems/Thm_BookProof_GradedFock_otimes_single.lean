-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.otimes_single
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

theorem BookProof.GradedFock.otimes_single (a : α) (b : β) (x y : ℂ) :
    otimes (Finsupp.single a x) (Finsupp.single b y) = Finsupp.single (a, b) (x * y) := by sorry
