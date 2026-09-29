-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.coreN_gcSeq
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_coreN_apply
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_mem
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
theorem solution (x : d.C.dom) (k : ℕ) :
    d.coreN ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩ = d.C.op (d.gcSeq x k) := by

  rw [coreN_apply]
