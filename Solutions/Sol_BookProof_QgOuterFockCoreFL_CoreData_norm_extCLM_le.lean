-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.norm_extCLM_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_coreRange_denseRange
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_norm_resolvedCLM_le
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData




open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.QgOuterFockFL
open BookProof.YangMillsFriedrichs
open BookProof.EsaClosure
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore
open Filter Topology

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : ‖d.extCLM‖ ≤ d.K := by

  have h : ‖d.extCLM‖ ≤ ((1 : NNReal) : ℝ) * ‖d.resolvedCLM‖ :=
    ContinuousLinearMap.opNorm_extend_le (N := 1) _ d.coreRange_denseRange (fun x => by simp)
  simp only [NNReal.coe_one, one_mul] at h
  exact h.trans d.norm_resolvedCLM_le
