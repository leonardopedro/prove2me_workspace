-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.symmetricOn_pairLiftOp
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Theorems.Thm_BookProof_TensorKatoRellich_pairLiftOp_apply
import Theorems.Thm_BookProof_TensorKatoRellich_exists_pre
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (L : (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier))
    (hL : ∀ x y : DA ⊗[ℂ] DB,
      (inner ℂ (L x) (inclPair Hs Ks DA DB y) : ℂ) = inner ℂ (inclPair Hs Ks DA DB x) (L y)) :
    SymmetricOn (cpairDom Hs Ks DA DB) (pairLiftOp Hs Ks DA DB L) := by

  intro x y
  obtain ⟨x₀, hx⟩ := exists_pre Hs Ks DA DB x
  obtain ⟨y₀, hy⟩ := exists_pre Hs Ks DA DB y
  rw [pairLiftOp_apply Hs Ks DA DB L x x₀ hx, pairLiftOp_apply Hs Ks DA DB L y y₀ hy, hx, hy,
    LinearIsometry.inner_map_map, LinearIsometry.inner_map_map]
  exact hL x₀ y₀
