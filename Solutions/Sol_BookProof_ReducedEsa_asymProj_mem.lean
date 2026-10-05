-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.asymProj_mem
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
open BookProof.ReducedEsa




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
variable {U}

set_option maxHeartbeats 1000000 in
theorem solution (hUD : ∀ x ∈ D, U x ∈ D) : ∀ x ∈ D, asymProj U x ∈ D := by

  intro x hx
  exact Submodule.smul_mem _ _ (Submodule.sub_mem _ hx (hUD x hx))
