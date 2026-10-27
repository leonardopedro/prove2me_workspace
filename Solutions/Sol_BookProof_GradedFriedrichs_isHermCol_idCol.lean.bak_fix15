-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isHermCol_idCol
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : IsHermCol idCol := by

  intro j k
  by_cases h : j = k
  · subst h; simp [idCol]
  · simp [idCol, h, Ne.symm h]
