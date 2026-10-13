-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isHermCol_idCol
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.FockSecondQuantization

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : IsHermCol idCol := by

  intro j k
  by_cases h : j = k
  · subst h; simp [idCol]
  · simp [idCol, h, Ne.symm h]
