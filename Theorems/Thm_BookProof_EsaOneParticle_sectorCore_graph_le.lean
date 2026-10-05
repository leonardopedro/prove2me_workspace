-- Generated from ChapterEsaOneParticleDGamma.lean — theorem BookProof.EsaOneParticle.sectorCore_graph_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.DirectSumEsa
open BookProof.TensorCore
open BookProof.EsaOneParticle

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)



open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.EsaOneParticle.sectorCore_graph_le (n : ℕ) (x : sectorCore Hs D₂ D n) :
    ∃ u : sectorDom Hs D n, (u : Hs.pow n) = (x : Hs.pow n) ∧
      sectorOp Hs D A n u =
        sectorOp Hs D₂ A₂ n ⟨(x : Hs.pow n), sectorCore_le_sectorDom Hs D₂ D n x.2⟩ := by sorry
