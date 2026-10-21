-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.symmetricOn_pairOp
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_pairOp_apply
import Theorems.Thm_BookProof_TensorSumEsa_sumPoly_symm
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hA : SymmetricOn DA A) (hB : SymmetricOn DB B) :
    SymmetricOn (pairDom Hs Ks DA DB) (pairOp Hs Ks DA DB A B) := by

  intro x y
  obtain ⟨x₀, hx₀⟩ := x.2
  obtain ⟨y₀, hy₀⟩ := y.2
  have hx : (x : Hs.carrier ⊗[ℂ] Ks.carrier) = inclPair Hs Ks DA DB x₀ := hx₀.symm
  have hy : (y : Hs.carrier ⊗[ℂ] Ks.carrier) = inclPair Hs Ks DA DB y₀ := hy₀.symm
  rw [pairOp_apply Hs Ks DA DB A B x x₀ hx, pairOp_apply Hs Ks DA DB A B y y₀ hy, hx, hy]
  exact sumPoly_symm Hs Ks DA DB A B hA hB x₀ y₀
