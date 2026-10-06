-- Generated from ChapterA4e.lean — solution of BookProof.ChapterA4e.projPos_spatialOp_commutator
import Mathlib
import Definitions.Def_ChapterA4e
import Theorems.Thm_BookProof_ChapterA4e_spatialOp_swaps_pos
open BookProof.ChapterA4e



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) :
    projPos * spatialOp j - spatialOp j * projPos
      = Complex.I • (spatialOp j * enSign) := by

  convert congr_arg ( fun x => x - spatialOp j * projPos ) ( spatialOp_swaps_pos j ) using 1;
  unfold projPos projNeg;
  norm_num [ mul_add, mul_sub, ← smul_assoc ];
  ext i j ; norm_num ; ring
