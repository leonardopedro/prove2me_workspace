-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.gcSeq_tendsto
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_norm_lt
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_tendsto_inv_succ
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
theorem solution (x : d.C.dom) :
    Tendsto (fun k => ((d.gcSeq x k : d.C.dom) : F)) atTop (𝓝 (x : F)) := by

  rw [tendsto_iff_norm_sub_tendsto_zero]
  refine squeeze_zero (fun k => norm_nonneg _) (fun k => (d.gcSeq_norm_lt x k).le)
    tendsto_inv_succ
