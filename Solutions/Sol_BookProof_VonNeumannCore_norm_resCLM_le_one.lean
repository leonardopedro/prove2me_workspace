-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.norm_resCLM_le_one
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterStoneResolvent
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) : ‖resCLM A‖ ≤ 1 := LinearMap.mkContinuous_norm_le _ zero_le_one _
