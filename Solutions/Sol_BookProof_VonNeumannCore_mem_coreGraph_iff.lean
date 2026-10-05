-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.mem_coreGraph_iff
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
theorem solution {A : D →ₗ[ℂ] F} {p : F × F} :
    p ∈ coreGraph A ↔ p ∈ clGraph A ∧ p.1 ∈ frDom A := Iff.rfl
