-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.essentiallySelfAdjointOn_red
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
import Theorems.Thm_BookProof_ReducedEsa_deficiencyTrivialAt_red
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
    (hC : Commutes T hPD) (hesa : EssentiallySelfAdjointOn D T) :
    EssentiallySelfAdjointOn (redDom P D) (redOp T hP hC) := ⟨deficiencyTrivialAt_red hP hC hesa.1, deficiencyTrivialAt_red hP hC hesa.2⟩
