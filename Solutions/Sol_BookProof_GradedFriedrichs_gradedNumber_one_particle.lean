-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.gradedNumber_one_particle
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_dGamma_idCol_one_particle
import Theorems.Thm_BookProof_GradedFriedrichs_dGammaF_idCol_one_particle
import Theorems.Thm_BookProof_GradedFock_liftFst_otimes
import Theorems.Thm_BookProof_GradedFock_liftSnd_otimes
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.FockSecondQuantization
open BookProof.YangMillsGhost

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k l : ℕ) :
    gradedHamiltonianAlg idCol idCol
        (otimes (Finsupp.single (Finsupp.single k 1) 1) (Finsupp.single ({l} : FConf) 1))
      = (2 : ℂ) •
        otimes (Finsupp.single (Finsupp.single k 1) 1) (Finsupp.single ({l} : FConf) 1) := by

  change liftFst (dGamma idCol) (otimes _ _) + liftSnd (dGammaF idCol) (otimes _ _) = _
  rw [liftFst_otimes, liftSnd_otimes, dGamma_idCol_one_particle,
    dGammaF_idCol_one_particle, two_smul]
