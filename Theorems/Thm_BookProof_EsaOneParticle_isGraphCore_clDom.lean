-- Generated from ChapterEsaOneParticleDGamma.lean — theorem BookProof.EsaOneParticle.isGraphCore_clDom
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
open BookProof.EsaClosure
open BookProof.GraphCore
open BookProof.TensorCore
open BookProof.EsaOneParticle

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)
variable {Hs : IPSpace} {D : Submodule ℂ Hs.carrier}



open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.EsaOneParticle.isGraphCore_clDom (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier))
    (hsym : SymmetricOn D A) : IsGraphCore D (clExt A hdense hsym) := by sorry
