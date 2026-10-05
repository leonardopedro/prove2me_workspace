-- Generated from ChapterEsaOneParticleDGamma.lean — theorem BookProof.EsaOneParticle.deficiencyTrivialAt_of_graph_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaOneParticle

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.EsaOneParticle.deficiencyTrivialAt_of_graph_le {D₁ D₂ : Submodule ℂ F} {T₁ : D₁ →ₗ[ℂ] F}
    {T₂ : D₂ →ₗ[ℂ] F} (h : ∀ v : D₁, ∃ u : D₂, (u : F) = (v : F) ∧ T₂ u = T₁ v) {z : ℂ}
    (h₁ : DeficiencyTrivialAt D₁ T₁ z) : DeficiencyTrivialAt D₂ T₂ z := by sorry
