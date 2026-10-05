-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.translation_invariant_l2_eq_zero
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.translation_invariant_l2_eq_zero {G : Type*} [Group G] [Infinite G]
    (Ψ : lp (fun _ : G => ℂ) 2) (hΨ : ∀ g x : G, Ψ (g * x) = Ψ x) : Ψ = 0 := by sorry
