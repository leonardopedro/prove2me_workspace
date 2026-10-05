-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.isGraphCore_clDom
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaClosure_clExt_apply
import Theorems.Thm_BookProof_EsaClosure_clExt_extends
import Theorems.Thm_BookProof_EsaClosure_coe_mem_clDom
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)
variable {Hs : IPSpace} {D : Submodule ℂ Hs.carrier}

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier))
    (hsym : SymmetricOn D A) : IsGraphCore D (clExt A hdense hsym) := by

  intro x ε hε
  have hmem : ((x : Hs.carrier), clFun A x) ∈ closure ((opGraph A : Submodule ℂ _) :
      Set (Hs.carrier × Hs.carrier)) := clFun_spec A x
  obtain ⟨p, hp, hdist⟩ := Metric.mem_closure_iff.mp hmem ε hε
  obtain ⟨v, rfl⟩ : ∃ v : D, ((v : Hs.carrier), A v) = p := by
    obtain ⟨v, hv⟩ := hp
    exact ⟨v, hv⟩
  refine ⟨⟨(v : Hs.carrier), coe_mem_clDom A v⟩, v.2, ?_, ?_⟩
  · have := (max_lt_iff.mp (by simpa [Prod.dist_eq, dist_eq_norm] using hdist)).1
    simpa using this
  · have := (max_lt_iff.mp (by simpa [Prod.dist_eq, dist_eq_norm] using hdist)).2
    have hval : clExt A hdense hsym ⟨(v : Hs.carrier), coe_mem_clDom A v⟩ = A v :=
      clExt_extends A hdense hsym v
    rw [clExt_apply, hval]
    simpa using this
