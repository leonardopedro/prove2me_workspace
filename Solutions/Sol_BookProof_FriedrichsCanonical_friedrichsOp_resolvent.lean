-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.friedrichsOp_resolvent
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Theorems.Thm_BookProof_FriedrichsCanonical_resolvent_mem_friedrichsDomain
import Theorems.Thm_BookProof_FriedrichsCanonical_friedrichsOp_apply
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_injective
import Theorems.Thm_BookProof_HashimotoShiftInvert_preim_eq
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) (u : F) :
    friedrichsOp P hdense ⟨friedrichsResolvent P u, resolvent_mem_friedrichsDomain P u⟩
      = u - friedrichsResolvent P u := by

  have hpre : preim (friedrichsResolvent P)
      ⟨friedrichsResolvent P u, resolvent_mem_friedrichsDomain P u⟩ = u :=
    preim_eq _ (friedrichsResolvent_injective P hdense) _ rfl
  rw [friedrichsOp_apply]
  erw [hpre]
  push_cast
  module
