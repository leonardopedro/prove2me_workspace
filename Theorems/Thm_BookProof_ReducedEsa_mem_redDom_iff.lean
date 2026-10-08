-- Generated from ChapterReducingSubspaceEsa.lean — theorem BookProof.ReducedEsa.mem_redDom_iff
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
open BookProof.ReducedEsa



open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {P : F →ₗ[ℂ] F}
variable {D : Submodule ℂ F}

theorem BookProof.ReducedEsa.mem_redDom_iff {x : sector P} : x ∈ redDom P D ↔ (x : F) ∈ D := by sorry
