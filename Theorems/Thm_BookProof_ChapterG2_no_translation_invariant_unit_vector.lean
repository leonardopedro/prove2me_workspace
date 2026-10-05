-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.no_translation_invariant_unit_vector
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.no_translation_invariant_unit_vector {G : Type*} [Group G] [Infinite G] :
    ¬ ∃ Ψ : lp (fun _ : G => ℂ) 2, ‖Ψ‖ = 1 ∧ ∀ g x : G, Ψ (g * x) = Ψ x := by sorry
