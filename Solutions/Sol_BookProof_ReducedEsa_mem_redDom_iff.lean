-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.mem_redDom_iff
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

set_option maxHeartbeats 1000000 in
theorem solution {x : sector P} : x ∈ redDom P D ↔ (x : F) ∈ D := Iff.rfl
