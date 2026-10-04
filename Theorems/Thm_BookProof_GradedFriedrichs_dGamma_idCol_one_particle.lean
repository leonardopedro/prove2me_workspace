-- Generated from ChapterGradedFriedrichs.lean — theorem BookProof.GradedFriedrichs.dGamma_idCol_one_particle
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterA4
open BookProof.FockSecondQuantization
open BookProof.GradedFriedrichs

variable {γ : Type*}
variable {α β : Type*}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

theorem BookProof.GradedFriedrichs.dGamma_idCol_one_particle (k : ℕ) :
    dGamma idCol (Finsupp.single (Finsupp.single k 1) 1)
      = Finsupp.single (Finsupp.single k 1) (1 : ℂ) := by sorry
