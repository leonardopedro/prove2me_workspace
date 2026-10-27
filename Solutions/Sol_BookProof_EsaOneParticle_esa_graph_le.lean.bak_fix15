-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.esa_graph_le
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_deficiencyTrivialAt_of_graph_le
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D₁ D₂ : Submodule ℂ F} {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h : ∀ v : D₁, ∃ u : D₂, (u : F) = (v : F) ∧ T₂ u = T₁ v)
    (h₁ : EssentiallySelfAdjointOn D₁ T₁) : EssentiallySelfAdjointOn D₂ T₂ := ⟨deficiencyTrivialAt_of_graph_le h h₁.1, deficiencyTrivialAt_of_graph_le h h₁.2⟩
