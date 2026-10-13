-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isSymAlg_gradedHamiltonianAlg
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_isSymAlg_add
import Theorems.Thm_BookProof_GradedFriedrichs_isSymAlg_liftFst
import Theorems.Thm_BookProof_GradedFriedrichs_isSymAlg_liftSnd
import Theorems.Thm_BookProof_GradedFriedrichs_isSymAlg_dGamma
import Theorems.Thm_BookProof_GradedFriedrichs_isSymAlg_dGammaF
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
theorem solution {colB colF : ℕ → (ℕ →₀ ℂ)}
    (hb : IsHermCol colB) (hf : IsHermCol colF) :
    IsSymAlg (gradedHamiltonianAlg colB colF) := isSymAlg_add (isSymAlg_liftFst (isSymAlg_dGamma hb)) (isSymAlg_liftSnd (isSymAlg_dGammaF hf))
