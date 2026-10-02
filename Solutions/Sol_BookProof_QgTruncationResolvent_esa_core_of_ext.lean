-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.esa_core_of_ext
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_gcSeq
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_ext_tendsto
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_mem
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_gcSeq_tendsto




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (d : CoreData F) (hesa : EssentiallySelfAdjointOn d.C.dom d.ext) :
    EssentiallySelfAdjointOn d.C₀ d.H₀ := by

  have key : ∀ z : ℂ, DeficiencyTrivialAt d.C.dom d.ext z → DeficiencyTrivialAt d.C₀ d.H₀ z := by
    intro z hz w hw
    refine hz w fun x => ?_
    have h1 : Tendsto (fun k => (inner ℂ (d.ext (d.gcSeq x k)) w : ℂ)) atTop
        (𝓝 (inner ℂ (d.ext x) w : ℂ)) := (d.gcSeq_ext_tendsto x).inner tendsto_const_nhds
    have h2 : Tendsto (fun k => z * (inner ℂ ((d.gcSeq x k : d.C.dom) : F) w : ℂ)) atTop
        (𝓝 (z * (inner ℂ (x : F) w : ℂ))) :=
      ((d.gcSeq_tendsto x).inner tendsto_const_nhds).const_mul z
    have heq : ∀ k, (inner ℂ (d.ext (d.gcSeq x k)) w : ℂ)
        = z * (inner ℂ ((d.gcSeq x k : d.C.dom) : F) w : ℂ) := by
      intro k
      rw [d.ext_gcSeq x k]
      exact hw ⟨_, d.gcSeq_mem x k⟩
    exact tendsto_nhds_unique (by simpa only [heq] using h1) h2
  exact ⟨key _ hesa.1, key _ hesa.2⟩
