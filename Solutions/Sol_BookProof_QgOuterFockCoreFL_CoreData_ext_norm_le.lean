-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.ext_norm_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_norm_extCLM_le
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_apply
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
theorem solution (x : d.C.dom) : ‖d.ext x‖ ≤ d.K * ‖d.C.op x + (x : F)‖ := by

  rw [ext_apply]
  calc ‖d.extCLM (d.C.op x + (x : F))‖ ≤ ‖d.extCLM‖ * ‖d.C.op x + (x : F)‖ :=
        d.extCLM.le_opNorm _
    _ ≤ d.K * ‖d.C.op x + (x : F)‖ :=
        mul_le_mul_of_nonneg_right d.norm_extCLM_le (norm_nonneg _)
