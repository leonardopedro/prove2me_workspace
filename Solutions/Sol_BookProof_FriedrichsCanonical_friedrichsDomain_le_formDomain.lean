-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.friedrichsDomain_le_formDomain
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) :
    friedrichsDomain P ≤ formDomain P := by

  rintro _ ⟨u, rfl⟩
  exact ⟨formRiesz P u, rfl⟩
