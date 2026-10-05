-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairDom_esa
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_cpairOp_apply
import Theorems.Thm_BookProof_TensorSumEsa_essentiallySelfAdjointOn_cpairDom_selfAdjoint
import Theorems.Thm_BookProof_TensorSumEsa_cpairCore_le_cpairDom
import Theorems.Thm_BookProof_TensorSumEsa_essentiallySelfAdjointOn_cpairCore
import Theorems.Thm_BookProof_TensorSumEsa_exists_pair_of_mem_pairCorePoly
import Theorems.Thm_BookProof_EsaClosure_clExt_extends
import Theorems.Thm_BookProof_EsaOneParticle_esa_graph_le
import Theorems.Thm_BookProof_EsaOneParticle_isGraphCore_clDom
import Theorems.Thm_BookProof_EsaOneParticle_le_clDom
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
variable [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]

set_option maxHeartbeats 1000000 in
theorem solution {DA : Submodule ℂ Hs.carrier}
    {DB : Submodule ℂ Ks.carrier} (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
    (hdenseA : Dense (DA : Set Hs.carrier)) (hdenseB : Dense (DB : Set Ks.carrier))
    (hsymA : SymmetricOn DA A) (hsymB : SymmetricOn DB B)
    (hesaA : EssentiallySelfAdjointOn DA A) (hesaB : EssentiallySelfAdjointOn DB B) :
    EssentiallySelfAdjointOn (cpairDom Hs Ks DA DB) (cpairOp Hs Ks DA DB A B) := by

  set A' := clExt A hdenseA hsymA with hA'
  set B' := clExt B hdenseB hsymB with hB'
  have hcoreA : IsGraphCore DA A' := isGraphCore_clDom A hdenseA hsymA
  have hcoreB : IsGraphCore DB B' := isGraphCore_clDom B hdenseB hsymB
  have hbig : EssentiallySelfAdjointOn (cpairDom Hs Ks (clDom A) (clDom B))
      (cpairOp Hs Ks (clDom A) (clDom B) A' B') :=
    essentiallySelfAdjointOn_cpairDom_selfAdjoint
      (closureSelfAdjoint A hdenseA hsymA hesaA) (closureSelfAdjoint B hdenseB hsymB hesaB)
  have hsource : EssentiallySelfAdjointOn (cpairCore Hs Ks (clDom A) (clDom B) DA DB)
      (restrictOp (cpairOp Hs Ks (clDom A) (clDom B) A' B')
        (cpairCore_le_cpairDom Hs Ks (clDom A) (clDom B) DA DB)) :=
    essentiallySelfAdjointOn_cpairCore Hs Ks (clDom A) (clDom B) A' B' DA DB hcoreA hcoreB hbig
  refine esa_graph_le ?_ hsource
  rintro ⟨v, hv⟩
  obtain ⟨w, hwmem, hwv⟩ := hv
  obtain ⟨y, hy, hyw⟩ := hwmem
  obtain ⟨y', hy₁, hy₂⟩ := exists_pair_of_mem_pairCorePoly A' B' A B (le_clDom A) (le_clDom B)
    (fun v => clExt_extends A hdenseA hsymA v) (fun v => clExt_extends B hdenseB hsymB v) y hy
  have hvy : v = pairEmb Hs Ks (inclPair Hs Ks (clDom A) (clDom B) y) := by
    have hy'' : pairEmb Hs Ks (inclPair Hs Ks (clDom A) (clDom B) y) = v := by
      rw [show inclPair Hs Ks (clDom A) (clDom B) y = w from hyw]
      exact hwv
    exact hy''.symm
  have hvval : v = pairEmb Hs Ks (inclPair Hs Ks DA DB y') := by
    rw [hy₁]
    exact hvy
  refine ⟨⟨pairEmb Hs Ks (inclPair Hs Ks DA DB y'),
    mem_pushDom (pairEmb Hs Ks)
      (⟨inclPair Hs Ks DA DB y', ⟨y', rfl⟩⟩ : pairDom Hs Ks DA DB)⟩, hvval.symm, ?_⟩
  rw [cpairOp_apply Hs Ks DA DB A B _ y' rfl, hy₂]
  exact (cpairOp_apply Hs Ks (clDom A) (clDom B) A' B' _ y hvy).symm
