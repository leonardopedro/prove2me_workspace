-- Generated from ChapterG2.lean — solution of BookProof.ChapterG2.gauge_fixing_section_discontinuous
import Mathlib
import Definitions.Def_ChapterG2
import Theorems.Thm_BookProof_ChapterG2_no_continuous_gauge_fixing_circle
open BookProof.ChapterG2



open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution
    (s : Circle → ℝ) (hs : ∀ z, Circle.exp (s z) = z) : ¬ Continuous s := by

  contrapose! hs with hs;
  exact not_forall.mp fun h => no_continuous_gauge_fixing_circle ⟨ s, hs, h ⟩
