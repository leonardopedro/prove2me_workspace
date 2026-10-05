-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.symmetric_of_involutive_isometry
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
theorem solution (hU2 : ∀ x, U (U x) = x)
    (hUi : ∀ x y : F, (inner ℂ (U x) (U y) : ℂ) = inner ℂ x y) (x y : F) :
    (inner ℂ (U x) y : ℂ) = inner ℂ x (U y) := by

  have := hUi x (U y)
  rw [hU2 y] at this
  exact this
