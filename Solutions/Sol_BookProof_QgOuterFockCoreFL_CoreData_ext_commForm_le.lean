-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.ext_commForm_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_commForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_quadForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_mem
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_gcSeq
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_coreN_gcSeq
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_commForm_tendsto
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_quadForm_tendsto
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
theorem solution {c : ℝ}
    (hcomm : ∀ p : d.C₀, |commForm d.H₀ d.coreN p| ≤ c * quadForm d.coreN p)
    (x : d.C.dom) : |commForm d.ext d.C.op x| ≤ c * quadForm d.C.op x := by

  have hstep : ∀ k, |commForm d.ext d.C.op (d.gcSeq x k)|
      ≤ c * quadForm d.C.op (d.gcSeq x k) := by
    intro k
    have h := hcomm ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩
    have hc1 : commForm d.ext d.C.op (d.gcSeq x k)
        = commForm d.H₀ d.coreN ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩ :=
      commForm_congr _ _ _ _ _ _ (d.ext_gcSeq x k) (d.coreN_gcSeq x k).symm
    have hc2 : quadForm d.C.op (d.gcSeq x k)
        = quadForm d.coreN ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩ :=
      quadForm_congr _ _ _ _ rfl (d.coreN_gcSeq x k).symm
    rw [hc1, hc2]
    exact h
  exact le_of_tendsto_of_tendsto ((d.ext_commForm_tendsto x).abs)
    ((d.quadForm_tendsto x).const_mul c) (Eventually.of_forall hstep)
