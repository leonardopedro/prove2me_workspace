-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.deficiencyTrivialAt_of_graph_le
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D₁ D₂ : Submodule ℂ F} {T₁ : D₁ →ₗ[ℂ] F}
    {T₂ : D₂ →ₗ[ℂ] F} (h : ∀ v : D₁, ∃ u : D₂, (u : F) = (v : F) ∧ T₂ u = T₁ v) {z : ℂ}
    (h₁ : DeficiencyTrivialAt D₁ T₁ z) : DeficiencyTrivialAt D₂ T₂ z := by

  intro w hw
  refine h₁ w fun v => ?_
  obtain ⟨u, hu, hTu⟩ := h v
  have hwu := hw u
  rw [hTu, hu] at hwu
  exact hwu
