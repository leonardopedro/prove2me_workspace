-- Generated from ChapterA3.lean — solution of BookProof.ChapterA3.mgamma_map_conj
import Mathlib
import Definitions.Def_ChapterA3
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    (mgamma μ).map (starRingEnd ℂ) = mgamma μ := by

  ext i j
  simp [mgamma, RingHom.mapMatrix_apply, Matrix.map_apply]
