-- Generated from ChapterGradedFriedrichs.lean — theorem BookProof.GradedFriedrichs.gradedNumber_one_particle
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.FockSecondQuantization
open BookProof.YangMillsGhost
open BookProof.GradedFriedrichs



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

theorem BookProof.GradedFriedrichs.gradedNumber_one_particle (k l : ℕ) :
    gradedHamiltonianAlg idCol idCol
        (otimes (Finsupp.single (Finsupp.single k 1) 1) (Finsupp.single ({l} : FConf) 1))
      = (2 : ℂ) •
        otimes (Finsupp.single (Finsupp.single k 1) 1) (Finsupp.single ({l} : FConf) 1) := by sorry
