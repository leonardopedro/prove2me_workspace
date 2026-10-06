-- Generated from ChapterGravityMetric.lean — theorem BookProof.ChapterGravityMetric.reverse_cauchy_schwarz
import Mathlib
import Definitions.Def_ChapterGravityMetric
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityMetric.reverse_cauchy_schwarz (v x : Fin 4 → ℝ) (hv : minkSq v = -1) :
    0 ≤ (∑ a, x a * lower v a) ^ 2 + minkSq x := by sorry
