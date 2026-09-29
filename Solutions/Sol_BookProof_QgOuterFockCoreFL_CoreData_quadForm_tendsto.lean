-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.quadForm_tendsto
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
    Tendsto (fun k => quadForm d.C.op (d.gcSeq x k)) atTop (𝓝 (quadForm d.C.op x)) := by

  have h1 : Tendsto (fun k => (inner ℂ ((d.gcSeq x k : d.C.dom) : F)
      (d.C.op (d.gcSeq x k)) : ℂ)) atTop (𝓝 (inner ℂ (x : F) (d.C.op x))) :=
    (d.gcSeq_tendsto x).inner (d.gcSeq_op_tendsto x)
  simpa only [quadForm] using (Complex.reCLM.continuous.tendsto _).comp h1
