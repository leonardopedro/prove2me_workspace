-- Generated from ChapterA3.lean — solution of BookProof.ChapterA3.mgamma5Z_anticomm
import Mathlib
import Definitions.Def_ChapterA3
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    mgamma5Z * mgammaZ μ + mgammaZ μ * mgamma5Z = 0 := by
 revert μ; decide
