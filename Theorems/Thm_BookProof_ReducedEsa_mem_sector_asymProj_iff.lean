-- Generated from ChapterReducingSubspaceEsa.lean — theorem BookProof.ReducedEsa.mem_sector_asymProj_iff
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
variable (T : D →ₗ[ℂ] F)
variable {T}
variable (U : F →ₗ[ℂ] F)
variable {U}

theorem BookProof.ReducedEsa.mem_sector_asymProj_iff (hU2 : ∀ x, U (U x) = x) {x : F} :
    x ∈ sector (asymProj U) ↔ U x = -x := by sorry
