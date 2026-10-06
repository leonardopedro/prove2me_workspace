-- Generated from ChapterA3.lean — solution of BookProof.ChapterA3.mgammaZ_transpose_mul
import Mathlib
import Definitions.Def_ChapterA3
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) : (mgammaZ μ)ᵀ * mgammaZ μ = 1 := by

  revert μ; decide
