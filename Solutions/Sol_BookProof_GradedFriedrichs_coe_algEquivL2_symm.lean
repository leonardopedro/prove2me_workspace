-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.coe_algEquivL2_symm
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes γ) :
    ((x : lpFiniteModes γ) : L2I γ) = toL2 (algEquivL2.symm x) := by

  rw [← coe_algEquivL2, LinearEquiv.apply_symm_apply]
