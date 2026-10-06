-- Generated from ChapterGravityMetric.lean — solution of BookProof.ChapterGravityMetric.spatialMetric_mulVec_self
import Mathlib
import Definitions.Def_ChapterGravityMetric
open BookProof.ChapterGravityMetric




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialMetric v).mulVec v = 0 := by

      unfold spatialMetric minkSq at *;
      unfold lower metric at *;
      ext i; simp_all [ Matrix.mulVec, dotProduct, Fin.sum_univ_four ] ;
      grind
