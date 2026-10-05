-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.dense_Dfin
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
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
theorem solution : Dense ((Dfin : Submodule ℂ L2Z) : Set L2Z) := by

  intro psi
  refine mem_closure_of_tendsto (lp.hasSum_single (by norm_num) psi) ?_
  filter_upwards with s
  refine Submodule.sum_mem _ fun i _ => ?_
  rw [lp_single_eq_smul]
  exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨i, rfl⟩)
