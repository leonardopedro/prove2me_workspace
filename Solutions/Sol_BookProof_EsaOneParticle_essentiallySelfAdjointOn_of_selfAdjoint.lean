-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.essentiallySelfAdjointOn_of_selfAdjoint
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_deficiencyTrivialAt_of_selfAdjoint
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
variable {Hs : IPSpace}

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint Hs.carrier) :
    EssentiallySelfAdjointOn T.domain T.op :=
  ⟨deficiencyTrivialAt_of_selfAdjoint T (by simp [Complex.ext_iff]; norm_num),
      deficiencyTrivialAt_of_selfAdjoint T (by simp [Complex.ext_iff]; norm_num)⟩
