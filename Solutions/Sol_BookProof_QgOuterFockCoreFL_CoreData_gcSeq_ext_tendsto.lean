-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.gcSeq_ext_tendsto
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_tendsto
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_op_tendsto
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
    Tendsto (fun k => d.ext (d.gcSeq x k)) atTop (𝓝 (d.ext x)) := by

  have hs : Tendsto (fun k => d.C.op (d.gcSeq x k) + ((d.gcSeq x k : d.C.dom) : F)) atTop
      (𝓝 (d.C.op x + (x : F))) := (d.gcSeq_op_tendsto x).add (d.gcSeq_tendsto x)
  simpa only [ext_apply] using (d.extCLM.continuous.tendsto _).comp hs
