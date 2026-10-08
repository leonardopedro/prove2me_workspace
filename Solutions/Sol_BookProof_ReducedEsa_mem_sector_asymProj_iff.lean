-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.mem_sector_asymProj_iff
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
variable (U : F →ₗ[ℂ] F)
variable {U}

set_option maxHeartbeats 1000000 in
theorem solution (hU2 : ∀ x, U (U x) = x) {x : F} :
    x ∈ sector (asymProj U) ↔ U x = -x := by

  constructor
  · rintro ⟨u, rfl⟩
    simp only [asymProj_apply, map_smul, map_sub, hU2]
    rw [smul_sub, smul_sub]
    abel
  · intro hx
    exact ⟨x, by simp [asymProj, hx]; module⟩
