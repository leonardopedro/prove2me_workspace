-- Generated from ChapterComplexShiftCore.lean — solution of BookProof.HashimotoShiftInvert.cshiftMap_surjective
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
import Theorems.Thm_BookProof_HashimotoShiftInvert_cshiftRange_isClosed
import Theorems.Thm_BookProof_HashimotoShiftInvert_cshiftRange_orthogonal_eq_bot
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {γ : ℂ} (hγ : γ.im ≠ 0) : Function.Surjective (cshiftMap A γ) := by

  have hclosed : IsClosed ((cshiftRange A γ : Submodule ℂ F) : Set F) :=
    cshiftRange_isClosed hsym hsa hγ
  haveI : CompleteSpace (cshiftRange A γ) := hclosed.completeSpace_coe
  have htop : cshiftRange A γ = ⊤ := by
    have h1 := Submodule.orthogonal_orthogonal (cshiftRange A γ)
    rw [cshiftRange_orthogonal_eq_bot hsym hsa hγ, Submodule.bot_orthogonal_eq_top] at h1
    exact h1.symm
  intro u
  have hmem : u ∈ cshiftRange A γ := by rw [htop]; trivial
  exact hmem
