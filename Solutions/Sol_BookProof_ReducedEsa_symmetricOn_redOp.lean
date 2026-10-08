-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.symmetricOn_redOp
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
open BookProof.ReducedEsa




open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {P : F →ₗ[ℂ] F}
variable {D : Submodule ℂ F}
variable (T : D →ₗ[ℂ] F)
variable {T}
variable (T) in

set_option maxHeartbeats 1000000 in
theorem solution (hP : IsReducingProjection P) {hPD : ∀ x ∈ D, P x ∈ D}
    (hC : Commutes T hPD) (hT : SymmetricOn D T) :
    SymmetricOn (redDom P D) (redOp T hP hC) := by

  intro x y
  have hx := hT (redIncl P D x) (redIncl P D y)
  simpa [Submodule.coe_inner] using hx
