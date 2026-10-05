-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.coreGraph_le_clGraph
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) : coreGraph A ≤ clGraph A := inf_le_left
