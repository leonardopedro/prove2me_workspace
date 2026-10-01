-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.exists_band₂
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution₂ (x y : secCore (ι := ι)) :
    ∃ P : Finset ι, (∀ a, a ∉ P → (x : Sec ι) a = 0) ∧
      (∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0) ∧
      (∀ a, a ∉ P → (y : Sec ι) a = 0) ∧
      (∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (y : Sec ι) b = 0) := by

  classical
  obtain ⟨Px, hx1, hx2⟩ := exists_band Q x
  obtain ⟨Py, hy1, hy2⟩ := exists_band Q y
  refine ⟨Px ∪ Py, ?_, ?_, ?_, ?_⟩ <;> intro a ha
  · exact hx1 a fun h => ha (Finset.mem_union_left _ h)
  · exact hx2 a fun h => ha (Finset.mem_union_left _ h)
  · exact hy1 a fun h => ha (Finset.mem_union_right _ h)
  · exact hy2 a fun h => ha (Finset.mem_union_right _ h)
