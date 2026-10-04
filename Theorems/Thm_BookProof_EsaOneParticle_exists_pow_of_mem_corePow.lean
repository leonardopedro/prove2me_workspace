-- Generated from ChapterEsaOneParticleDGamma.lean — theorem BookProof.EsaOneParticle.exists_pow_of_mem_corePow
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore
open BookProof.EsaOneParticle

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)



open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.EsaOneParticle.exists_pow_of_mem_corePow :
    ∀ (n : ℕ) (y : ((domSpace Hs D₂).pow n)), y ∈ corePow Hs D₂ D n →
      ∃ y' : ((domSpace Hs D).pow n),
        inclPow Hs D n y' = inclPow Hs D₂ n y ∧
          derPow Hs D A n y' = derPow Hs D₂ A₂ n y := by sorry
