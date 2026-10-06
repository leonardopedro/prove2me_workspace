-- Generated from ChapterE.lean — theorem BookProof.ChapterE.exists_uniformizer
import Mathlib
import Definitions.Def_ChapterE
open BookProof.ChapterE


open scoped Matrix BigOperators
open Filter
open scoped Topology

theorem BookProof.ChapterE.exists_uniformizer (n : ℕ) (hn : 1 ≤ n) :
    ∃ U : Matrix (Fin n) (Fin n) ℂ, Uᴴ * U = 1 ∧ ∀ i j, ‖U i j‖ ^ 2 = 1 / n := by sorry
