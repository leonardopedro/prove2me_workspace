-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.gradeOp_bcre
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSuperBracket
import Mathlib
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.FockSecondQuantization
open BookProof.YangMillsGhost
open BookProof.GradedFock

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

theorem BookProof.GradedFock.gradeOp_bcre (j : ℕ) : gradeOp * bcre j = bcre j * gradeOp := by sorry
