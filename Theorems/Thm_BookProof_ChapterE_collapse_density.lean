-- Generated from ChapterE.lean — theorem BookProof.ChapterE.collapse_density
import Mathlib
import Definitions.Def_ChapterE
open BookProof.ChapterE


open scoped Matrix BigOperators
open Filter
open scoped Topology

theorem BookProof.ChapterE.collapse_density (t : ℝ) :
    (!![Real.cos t ^ 2, 0; 0, Real.sin t ^ 2] : Matrix (Fin 2) (Fin 2) ℝ)
      = (1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
        + (1 / 2 * Real.cos (2 * t)) • !![1, 0; 0, -1] := by sorry
