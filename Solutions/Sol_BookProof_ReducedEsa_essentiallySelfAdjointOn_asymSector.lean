-- Generated from ChapterReducingSubspaceEsa.lean — solution of BookProof.ReducedEsa.essentiallySelfAdjointOn_asymSector
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
import Theorems.Thm_BookProof_ReducedEsa_essentiallySelfAdjointOn_red
import Theorems.Thm_BookProof_ReducedEsa_isReducingProjection_asymProj
import Theorems.Thm_BookProof_ReducedEsa_asymProj_mem
import Theorems.Thm_BookProof_ReducedEsa_commutes_asymProj
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
    (hUi : ∀ x y : F, (inner ℂ (U x) (U y) : ℂ) = inner ℂ x y)
    {hUD : ∀ x ∈ D, U x ∈ D} (hTU : ∀ x : D, T ⟨U (x : F), hUD _ x.2⟩ = U (T x))
    (hesa : EssentiallySelfAdjointOn D T) :
    EssentiallySelfAdjointOn (redDom (asymProj U) D)
      (redOp T (isReducingProjection_asymProj hU2 hUi) (commutes_asymProj hTU)) := essentiallySelfAdjointOn_red _ _ hesa
