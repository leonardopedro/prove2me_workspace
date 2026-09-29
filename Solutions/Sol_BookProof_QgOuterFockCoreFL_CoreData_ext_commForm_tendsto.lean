-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.ext_commForm_tendsto
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_op_tendsto
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_ext_tendsto
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
    Tendsto (fun k => commForm d.ext d.C.op (d.gcSeq x k)) atTop
      (𝓝 (commForm d.ext d.C.op x)) := by

  have h1 : Tendsto (fun k => (inner ℂ (d.ext (d.gcSeq x k)) (d.C.op (d.gcSeq x k)) : ℂ))
      atTop (𝓝 (inner ℂ (d.ext x) (d.C.op x))) :=
    (d.gcSeq_ext_tendsto x).inner (d.gcSeq_op_tendsto x)
  have h2 : Tendsto (fun k => (inner ℂ (d.C.op (d.gcSeq x k)) (d.ext (d.gcSeq x k)) : ℂ))
      atTop (𝓝 (inner ℂ (d.C.op x) (d.ext x))) :=
    (d.gcSeq_op_tendsto x).inner (d.gcSeq_ext_tendsto x)
  simpa only [commForm] using (Complex.reCLM.continuous.tendsto _).comp
    (((h1.sub h2).const_mul Complex.I))
