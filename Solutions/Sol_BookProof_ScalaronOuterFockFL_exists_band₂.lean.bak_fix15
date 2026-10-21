-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.exists_band2
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)
variable {ι : Type*}
variable (Q : QgModeData ι)
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (x y : secCore (ι := by

  classical
  obtain ⟨Px, hx1, hx2⟩ := exists_band Q x
  obtain ⟨Py, hy1, hy2⟩ := exists_band Q y
  refine ⟨Px ∪ Py, ?_, ?_, ?_, ?_⟩ <;> intro a ha
  · exact hx1 a fun h => ha (Finset.mem_union_left _ h)
  · exact hx2 a fun h => ha (Finset.mem_union_left _ h)
  · exact hy1 a fun h => ha (Finset.mem_union_right _ h)
  · exact hy2 a fun h => ha (Finset.mem_union_right _ h)
