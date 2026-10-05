-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.super_canonical_cre
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFermionFock
import Mathlib
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterSuperBracket
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.FockSecondQuantization
open BookProof.ChapterSuperBracket
open BookProof.YangMillsGhost
open BookProof.GradedFock

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

theorem BookProof.GradedFock.super_canonical_cre (p q : Bool) (j k : ℕ) :
    sbracket p q (gCre p j) (gCre q k) = 0 := by sorry
