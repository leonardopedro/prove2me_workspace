-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.sectorCore_graph_le
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_exists_pow_of_mem_corePow
import Theorems.Thm_BookProof_TensorCore_sectorCore_le_sectorDom
import Theorems.Thm_BookProof_TensorCore_sectorOp_apply
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : sectorCore Hs D₂ D n) :
    ∃ u : sectorDom Hs D n, (u : Hs.pow n) = (x : Hs.pow n) ∧
      sectorOp Hs D A n u =
        sectorOp Hs D₂ A₂ n ⟨(x : Hs.pow n), sectorCore_le_sectorDom Hs D₂ D n x.2⟩ := by

  obtain ⟨y, hy, hyx⟩ := x.2
  obtain ⟨y', hy1, hy2⟩ := exists_pow_of_mem_corePow Hs D₂ A₂ D A hle hext n y hy
  refine ⟨⟨inclPow Hs D n y', ⟨y', rfl⟩⟩, ?_, ?_⟩
  · exact hy1.trans hyx
  · rw [sectorOp_apply Hs D A n ⟨inclPow Hs D n y', ⟨y', rfl⟩⟩ y' rfl,
      sectorOp_apply Hs D₂ A₂ n ⟨(x : Hs.pow n), sectorCore_le_sectorDom Hs D₂ D n x.2⟩ y
        hyx.symm]
    exact hy2
