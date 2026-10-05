-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.isGraphCore_pairCore
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_pairOp_apply
import Theorems.Thm_BookProof_TensorSumEsa_exists_pair_core_approx
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}
variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)
variable {Hs Ks : IPSpace} [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
  (CA : Submodule ℂ Hs.carrier) (CB : Submodule ℂ Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hcoreA : IsGraphCore CA A) (hcoreB : IsGraphCore CB B) :
    IsGraphCore (pairCore Hs Ks DA DB CA CB) (pairOp Hs Ks DA DB A B) := by

  intro x ε hε
  obtain ⟨x₀, hx₀⟩ := x.2
  have hx : (x : Hs.carrier ⊗[ℂ] Ks.carrier) = inclPair Hs Ks DA DB x₀ := hx₀.symm
  obtain ⟨y₀, hy₀, hy₁, hy₂⟩ :=
    exists_pair_core_approx Hs Ks DA DB A B CA CB hcoreA hcoreB x₀ hε
  refine ⟨⟨inclPair Hs Ks DA DB y₀, ⟨y₀, rfl⟩⟩, ⟨y₀, hy₀, rfl⟩, ?_, ?_⟩
  · simpa [hx] using hy₁
  · rw [pairOp_apply Hs Ks DA DB A B x x₀ hx,
      pairOp_apply Hs Ks DA DB A B ⟨inclPair Hs Ks DA DB y₀, ⟨y₀, rfl⟩⟩ y₀ rfl]
    exact hy₂
