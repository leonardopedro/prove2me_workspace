-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.toL2_add
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (u v : γ →₀ ℂ) : toL2 (u + v) = toL2 u + toL2 v := toL2L.map_add u v
