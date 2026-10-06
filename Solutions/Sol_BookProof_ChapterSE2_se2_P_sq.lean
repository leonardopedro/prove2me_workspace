-- Generated from ChapterSE2.lean — solution of BookProof.ChapterSE2.se2_P_sq
import Mathlib
import Definitions.Def_ChapterSE2
open BookProof.ChapterSE2



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : (mgammaZ 0 + mgammaZ 3) * (mgammaZ 0 + mgammaZ 3) = 0 := by
 decide
