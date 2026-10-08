-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.symProj_apply
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa




open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {P : F →ₗ[ℂ] F}
variable {D : Submodule ℂ F}
variable (T : D →ₗ[ℂ] F)
variable {T}
variable (U : F →ₗ[ℂ] F)

set_option maxHeartbeats 1000000 in
theorem solution (x : F) : symProj U x = (2⁻¹ : ℂ) • (x + U x) := rfl
