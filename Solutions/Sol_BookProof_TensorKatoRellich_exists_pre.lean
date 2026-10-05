-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.exists_pre
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (x : cpairDom Hs Ks DA DB) :
    ∃ x₀ : DA ⊗[ℂ] DB, (x : ctensor Hs Ks) = pairEmb Hs Ks (inclPair Hs Ks DA DB x₀) := by

  obtain ⟨z, hz, hze⟩ := x.2
  obtain ⟨x₀, rfl⟩ := hz
  exact ⟨x₀, hze.symm⟩
