-- Generated from ChapterE.lean — theorem BookProof.ChapterE.stochastic_uniform_to_vertex_singular
import Mathlib
import Definitions.Def_ChapterE
open BookProof.ChapterE


open scoped Matrix BigOperators
open Filter
open scoped Topology

theorem BookProof.ChapterE.stochastic_uniform_to_vertex_singular
    (M : Matrix (Fin 2) (Fin 2) ℝ)
    (hnonneg : ∀ i j, 0 ≤ M i j)
    (hcol : ∀ j, ∑ i, M i j = 1)
    (huniform : M *ᵥ ![1 / 2, 1 / 2] = ![1, 0]) :
    M.det = 0 := by sorry
