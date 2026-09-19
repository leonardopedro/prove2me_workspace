-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.ext_gcSeq
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_core
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
    d.ext (d.gcSeq x k) = d.H₀ ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩ := by

  have := d.ext_core ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩
  rw [← this]
