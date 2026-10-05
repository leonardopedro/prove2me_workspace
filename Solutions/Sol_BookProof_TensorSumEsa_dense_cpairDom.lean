-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.dense_cpairDom
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_dense_pairDom
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hA : Dense (DA : Set Hs.carrier)) (hB : Dense (DB : Set Ks.carrier)) :
    Dense ((cpairDom Hs Ks DA DB : Submodule ℂ (ctensor Hs Ks)) : Set (ctensor Hs Ks)) := by

  have hcont : Continuous (pairEmb Hs Ks) := (pairEmb Hs Ks).continuous
  have himg : (pairEmb Hs Ks) '' ((pairDom Hs Ks DA DB : Submodule ℂ _) : Set _)
      = ((cpairDom Hs Ks DA DB : Submodule ℂ (ctensor Hs Ks)) : Set (ctensor Hs Ks)) := by
    ext z
    constructor
    · rintro ⟨w, hw, rfl⟩; exact ⟨w, hw, rfl⟩
    · rintro ⟨w, hw, rfl⟩; exact ⟨w, hw, rfl⟩
  rw [← himg]
  have hsub : Set.range (pairEmb Hs Ks)
      ⊆ closure ((pairEmb Hs Ks) '' ((pairDom Hs Ks DA DB : Submodule ℂ _) : Set _)) := by
    rintro _ ⟨w, rfl⟩
    have hw : w ∈ closure ((pairDom Hs Ks DA DB : Submodule ℂ _) : Set _) := by
      rw [(dense_pairDom Hs Ks DA DB hA hB).closure_eq]; trivial
    exact (image_closure_subset_closure_image hcont) ⟨w, hw, rfl⟩
  have hdr : DenseRange (pairEmb Hs Ks) := by
    have : DenseRange ((↑) : (Hs.carrier ⊗[ℂ] Ks.carrier) → ctensor Hs Ks) :=
      UniformSpace.Completion.denseRange_coe
    exact this
  rw [dense_iff_closure_eq]
  apply Set.eq_univ_of_forall
  intro z
  have h1 : closure (Set.range (pairEmb Hs Ks))
      ⊆ closure (closure ((pairEmb Hs Ks) '' ((pairDom Hs Ks DA DB : Submodule ℂ _) : Set _))) :=
    closure_mono hsub
  have h2 := h1 (hdr.closure_eq ▸ Set.mem_univ z)
  rwa [closure_closure] at h2
