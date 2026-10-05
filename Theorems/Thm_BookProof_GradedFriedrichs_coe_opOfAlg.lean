-- Generated from ChapterGradedFriedrichs.lean — theorem BookProof.GradedFriedrichs.coe_opOfAlg
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.GradedFriedrichs

variable {γ : Type*}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

theorem BookProof.GradedFriedrichs.coe_opOfAlg (T : Module.End ℂ (γ →₀ ℂ)) (x : lpFiniteModes γ) :
    opOfAlg T x = toL2 (T (algEquivL2.symm x)) := by sorry
