-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.redIncl_coe
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa




open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {P : F →ₗ[ℂ] F}
variable {D : Submodule ℂ F}
variable (P D) in

set_option maxHeartbeats 1000000 in
theorem solution (x : redDom P D) : ((redIncl P D x : D) : F) = (x : F) := rfl
