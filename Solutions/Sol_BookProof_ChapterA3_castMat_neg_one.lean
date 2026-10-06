-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.castMat_neg_one
import Mathlib
import Definitions.Def_ChapterA3d
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    (Int.castRingHom ℝ).mapMatrix (-1 : Matrix (Fin 4) (Fin 4) ℤ) = -1 := by

  rw [map_neg, map_one]
