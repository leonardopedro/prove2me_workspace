-- Generated from ChapterGradedFriedrichs.lean — theorem BookProof.GradedFriedrichs.opOfAlg_quadForm_nonneg
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterA4
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.GradedFriedrichs

variable {γ : Type*}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

theorem BookProof.GradedFriedrichs.opOfAlg_quadForm_nonneg {T : Module.End ℂ (γ →₀ ℂ)} (hT : IsPosAlg T)
    (x : lpFiniteModes γ) : 0 ≤ quadForm (opOfAlg T) x := by sorry
