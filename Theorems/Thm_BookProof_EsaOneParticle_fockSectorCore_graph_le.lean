-- Generated from ChapterEsaOneParticleDGamma.lean — theorem BookProof.EsaOneParticle.fockSectorCore_graph_le
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.DirectSumEsa
open BookProof.GraphCore
open BookProof.TensorCore
open BookProof.EsaOneParticle

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)



open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.EsaOneParticle.fockSectorCore_graph_le (n : ℕ) (x : fockSectorCore Hs D₂ D n) :
    ∃ u : fockSectorDom Hs D n, (u : fockSector Hs n) = (x : fockSector Hs n) ∧
      fockSectorOp Hs D A n u =
        restrictOp (fockSectorOp Hs D₂ A₂ n) (fockSectorCore_le_fockSectorDom Hs D₂ D n) x := by sorry
