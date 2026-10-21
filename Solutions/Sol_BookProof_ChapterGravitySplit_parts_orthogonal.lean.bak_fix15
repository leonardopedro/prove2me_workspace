-- Generated from ChapterGravitySplit.lean — solution of BookProof.ChapterGravitySplit.parts_orthogonal
import Mathlib
import Definitions.Def_ChapterGravitySplit
import Theorems.Thm_BookProof_ChapterGravitySplit_timePart_eq_smul
import Theorems.Thm_BookProof_ChapterGravitySplit_spatialPart_orthogonal
open BookProof.ChapterGravitySplit




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (v x : Fin 4 → ℝ) (hv : minkSq v = -1) :
    minkForm (spatialPart v x) (timePart v x) = 0 := by

  rw [ timePart_eq_smul ];
  convert congr_arg ( fun y => ( -minkForm x v ) * y ) ( spatialPart_orthogonal v x hv ) using 1 ;
      focus (ring);
  · unfold minkForm lower; simp [ Matrix.mulVec, dotProduct, Fin.sum_univ_four ] ; ring;
  · ring
