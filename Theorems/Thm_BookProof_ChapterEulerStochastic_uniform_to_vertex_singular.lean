-- Generated from ChapterEulerStochastic.lean — theorem BookProof.ChapterEulerStochastic.uniform_to_vertex_singular
import Mathlib
import Definitions.Def_ChapterEulerStochastic
open BookProof.ChapterEulerStochastic


open scoped Matrix BigOperators

theorem BookProof.ChapterEulerStochastic.uniform_to_vertex_singular (M : Matrix (Fin 2) (Fin 2) ℝ)
    (hM : PreservesProb M) (hcollapse : M *ᵥ ![1 / 2, 1 / 2] = ![1, 0]) :
    M.det = 0 := by sorry
