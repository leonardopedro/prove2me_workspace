-- Generated from ChapterGravitySplit.lean — solution of BookProof.ChapterGravitySplit.spatialPart_orthogonal
import Mathlib
import Definitions.Def_ChapterGravitySplit
open BookProof.ChapterGravitySplit




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (v x : Fin 4 → ℝ) (hv : minkSq v = -1) :
    minkForm (spatialPart v x) v = 0 := by

  unfold minkForm;
  unfold spatialPart; simp only [mulVec, dotProduct] ; ring;
  unfold spatialProj; simp [ * ] ; ring;
  unfold minkSq at hv; simp_all [ Fin.sum_univ_four, lower ] ; ring;
  grobner
