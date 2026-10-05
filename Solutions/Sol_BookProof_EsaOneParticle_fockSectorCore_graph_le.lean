-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.fockSectorCore_graph_le
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_sectorCore_graph_le
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : fockSectorCore Hs D₂ D n) :
    ∃ u : fockSectorDom Hs D n, (u : fockSector Hs n) = (x : fockSector Hs n) ∧
      fockSectorOp Hs D A n u =
        restrictOp (fockSectorOp Hs D₂ A₂ n) (fockSectorCore_le_fockSectorDom Hs D₂ D n) x := by

  obtain ⟨s, hs, hsx⟩ := x.2
  obtain ⟨u, hu1, hu2⟩ := sectorCore_graph_le Hs D₂ A₂ D A hle hext n ⟨s, hs⟩
  refine ⟨⟨sectorEmb Hs n (u : Hs.pow n), mem_pushDom _ u⟩, ?_, ?_⟩
  · change sectorEmb Hs n (u : Hs.pow n) = (x : fockSector Hs n)
    rw [hu1]; exact hsx
  · have h1 : fockSectorOp Hs D A n ⟨sectorEmb Hs n (u : Hs.pow n), mem_pushDom _ u⟩
        = sectorEmb Hs n (sectorOp Hs D A n u) :=
      pushOp_apply (sectorEmb Hs n) (sectorOp Hs D A n) _ u rfl
    have h2 : restrictOp (fockSectorOp Hs D₂ A₂ n)
          (fockSectorCore_le_fockSectorDom Hs D₂ D n) x
        = sectorEmb Hs n
            (sectorOp Hs D₂ A₂ n ⟨s, sectorCore_le_sectorDom Hs D₂ D n hs⟩) := by
      rw [restrictOp_apply]
      exact pushOp_apply (sectorEmb Hs n) (sectorOp Hs D₂ A₂ n) _
        ⟨s, sectorCore_le_sectorDom Hs D₂ D n hs⟩ hsx.symm
    rw [h1, h2, hu2]
