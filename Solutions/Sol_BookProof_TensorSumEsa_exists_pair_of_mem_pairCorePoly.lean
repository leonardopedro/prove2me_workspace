-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.exists_pair_of_mem_pairCorePoly
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
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
variable {Hs Ks : IPSpace}

set_option maxHeartbeats 1000000 in
theorem solution {DA' : Submodule ℂ Hs.carrier}
    {DB' : Submodule ℂ Ks.carrier} (A' : DA' →ₗ[ℂ] Hs.carrier) (B' : DB' →ₗ[ℂ] Ks.carrier)
    {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier} (A : DA →ₗ[ℂ] Hs.carrier)
    (B : DB →ₗ[ℂ] Ks.carrier) (hleA : DA ≤ DA') (hleB : DB ≤ DB')
    (hextA : ∀ v : DA, A' ⟨(v : Hs.carrier), hleA v.2⟩ = A v)
    (hextB : ∀ v : DB, B' ⟨(v : Ks.carrier), hleB v.2⟩ = B v)
    (y : DA' ⊗[ℂ] DB') (hy : y ∈ pairCorePoly Hs Ks DA' DB' DA DB) :
    ∃ y' : DA ⊗[ℂ] DB,
      inclPair Hs Ks DA DB y' = inclPair Hs Ks DA' DB' y ∧
        sumPoly Hs Ks DA DB A B y' = sumPoly Hs Ks DA' DB' A' B' y := by

  induction hy using Submodule.span_induction with
  | mem t ht =>
      obtain ⟨a, haD, b, hbD, rfl⟩ := ht
      refine ⟨(⟨(a : Hs.carrier), haD⟩ : DA) ⊗ₜ[ℂ] (⟨(b : Ks.carrier), hbD⟩ : DB), rfl, ?_⟩
      have hA : A' a = A ⟨(a : Hs.carrier), haD⟩ := by
        have := hextA ⟨(a : Hs.carrier), haD⟩
        simpa using this
      have hB : B' b = B ⟨(b : Ks.carrier), hbD⟩ := by
        have := hextB ⟨(b : Ks.carrier), hbD⟩
        simpa using this
      simp [sumPoly_tmul, hA, hB]
  | zero => exact ⟨0, by simp, by simp⟩
  | add s t _ _ hs ht =>
      obtain ⟨s', hs₁, hs₂⟩ := hs
      obtain ⟨t', ht₁, ht₂⟩ := ht
      exact ⟨s' + t', by rw [map_add, map_add, hs₁, ht₁], by rw [map_add, map_add, hs₂, ht₂]⟩
  | smul c s _ hs =>
      obtain ⟨s', hs₁, hs₂⟩ := hs
      exact ⟨c • s', by rw [map_smul, map_smul, hs₁], by rw [map_smul, map_smul, hs₂]⟩
