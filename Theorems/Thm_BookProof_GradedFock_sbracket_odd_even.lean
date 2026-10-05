-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.sbracket_odd_even
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Mathlib
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterSuperBracket
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterSuperBracket
open BookProof.YangMillsGhost
open BookProof.GradedFock

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

theorem BookProof.GradedFock.sbracket_odd_even (a b : Module.End ℂ GradedAlg) :
    sbracket true false a b = a * b - b * a := by sorry
