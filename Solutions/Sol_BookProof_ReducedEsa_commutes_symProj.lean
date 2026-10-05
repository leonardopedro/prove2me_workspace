-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.commutes_symProj
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
import Theorems.Thm_BookProof_ReducedEsa_symProj_mem
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
theorem solution {hUD : ∀ x ∈ D, U x ∈ D}
    (hTU : ∀ x : D, T ⟨U (x : F), hUD _ x.2⟩ = U (T x)) :
    Commutes T (symProj_mem (D := D) hUD) where
  comm x :=
  where
    comm x := by
      have hsplit : (⟨symProj U (x : F), symProj_mem (D := D) hUD _ x.2⟩ : D)
          = (2⁻¹ : ℂ) • ((x : D) + ⟨U (x : F), hUD _ x.2⟩) := by
        apply Subtype.ext
        simp [symProj]
      rw [hsplit, map_smul, map_add, hTU x]
      simp [symProj]
