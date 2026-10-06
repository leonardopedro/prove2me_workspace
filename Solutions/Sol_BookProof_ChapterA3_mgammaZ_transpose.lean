-- Generated from ChapterPauliCommutant.lean — solution of BookProof.ChapterA3.mgammaZ_transpose
import Mathlib
import Definitions.Def_ChapterPauliCommutant
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    (mgammaZ μ)ᵀ = (if μ = 0 then (-1 : ℤ) else 1) • mgammaZ μ := by
 revert μ; decide
