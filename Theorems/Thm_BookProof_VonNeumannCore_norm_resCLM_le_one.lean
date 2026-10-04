-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.norm_resCLM_le_one
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4
open BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare


theorem BookProof.VonNeumannCore.norm_resCLM_le_one (A : D →ₗ[ℂ] F) : ‖resCLM A‖ ≤ 1 := by sorry
