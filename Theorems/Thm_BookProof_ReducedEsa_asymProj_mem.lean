-- Generated from ChapterReducingSubspaceEsa.lean — theorem BookProof.ReducedEsa.asymProj_mem
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
open BookProof.ReducedEsa

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



open BookProof.FarisLavine BookProof.GraphCore

noncomputable section


theorem BookProof.ReducedEsa.asymProj_mem (hUD : ∀ x ∈ D, U x ∈ D) : ∀ x ∈ D, asymProj U x ∈ D := by sorry
