-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.asymProj_apply
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa




open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {P : F →ₗ[ℂ] F}
variable (P) in
variable (P) (D : Submodule ℂ F) in
variable {D : Submodule ℂ F}
variable (P D) in
variable (T : D →ₗ[ℂ] F)
variable {T}
variable (T) in
variable (U : F →ₗ[ℂ] F)

set_option maxHeartbeats 1000000 in
theorem solution (x : F) : asymProj U x = (2⁻¹ : ℂ) • (x - U x) := rfl
