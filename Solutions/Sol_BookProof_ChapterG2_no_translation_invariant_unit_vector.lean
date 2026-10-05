-- Generated from ChapterG2.lean — solution of BookProof.ChapterG2.no_translation_invariant_unit_vector
import Mathlib
import Definitions.Def_ChapterG2
import Theorems.Thm_BookProof_ChapterG2_translation_invariant_l2_eq_zero
open BookProof.ChapterG2



open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution {G : Type*} [Group G] [Infinite G] :
    ¬ ∃ Ψ : lp (fun _ : G => ℂ) 2, ‖Ψ‖ = 1 ∧ ∀ g x : G, Ψ (g * x) = Ψ x := by

  rintro ⟨ Ψ, hnorm, hinv ⟩;
  have := translation_invariant_l2_eq_zero Ψ hinv; aesop;
