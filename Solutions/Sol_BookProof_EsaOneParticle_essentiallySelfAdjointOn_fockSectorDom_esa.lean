-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.essentiallySelfAdjointOn_fockSectorDom_esa
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_esa_graph_le
import Theorems.Thm_BookProof_EsaOneParticle_fockSectorCore_graph_le
import Theorems.Thm_BookProof_EsaOneParticle_le_clDom
import Theorems.Thm_BookProof_EsaOneParticle_isGraphCore_clDom
import Theorems.Thm_BookProof_EsaClosure_clExt_extends
import Theorems.Thm_BookProof_SecondQuantizationCore_essentiallySelfAdjointOn_fockSectorCore
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)
variable {Hs : IPSpace} {D : Submodule ℂ Hs.carrier}
variable [CompleteSpace Hs.carrier]
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    EssentiallySelfAdjointOn (fockSectorDom Hs D n) (fockSectorOp Hs D A n) := by

  have hcore : IsGraphCore D (clExt A hdense hsym) := isGraphCore_clDom A hdense hsym
  have hsectorClosure : EssentiallySelfAdjointOn (fockSectorDom Hs (clDom A) n)
      (fockSectorOp Hs (clDom A) (clExt A hdense hsym) n) :=
    essentiallySelfAdjointOn_fockSectorDom_selfAdjoint (closureSelfAdjoint A hdense hsym hesa) n
  have hsource : EssentiallySelfAdjointOn (fockSectorCore Hs (clDom A) D n)
      (restrictOp (fockSectorOp Hs (clDom A) (clExt A hdense hsym) n)
        (fockSectorCore_le_fockSectorDom Hs (clDom A) D n)) :=
    essentiallySelfAdjointOn_fockSectorCore Hs (clDom A) (clExt A hdense hsym) D hcore n
      hsectorClosure
  refine esa_graph_le ?_ hsource
  exact fockSectorCore_graph_le Hs (clDom A) (clExt A hdense hsym) D A (le_clDom A)
    (fun v => clExt_extends A hdense hsym v) n
