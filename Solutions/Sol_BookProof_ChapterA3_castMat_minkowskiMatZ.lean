-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.castMat_minkowskiMatZ
import Mathlib
import Definitions.Def_ChapterA3e
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    (Int.castRingHom ℝ).mapMatrix minkowskiMatZ = minkowskiMat := by

  ext i j
  simp [RingHom.mapMatrix_apply, Matrix.map_apply, minkowskiMatZ, minkowskiMat,
    minkowskiR]
