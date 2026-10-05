-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.sumPoly_symm
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
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
    ∀ x y : DA ⊗[ℂ] DB,
      (inner ℂ (sumPoly Hs Ks DA DB A B x) (inclPair Hs Ks DA DB y) : ℂ)
        = inner ℂ (inclPair Hs Ks DA DB x) (sumPoly Hs Ks DA DB A B y) := by

  have hspan : ∀ z : DA ⊗[ℂ] DB,
      z ∈ Submodule.span ℂ {t : DA ⊗[ℂ] DB | ∃ (p : DA) (q : DB), p ⊗ₜ[ℂ] q = t} := by
    intro z
    rw [TensorProduct.span_tmul_eq_top]
    trivial
  have hpure : ∀ (a : DA) (b : DB) (y : DA ⊗[ℂ] DB),
      (inner ℂ (sumPoly Hs Ks DA DB A B (a ⊗ₜ[ℂ] b)) (inclPair Hs Ks DA DB y) : ℂ)
        = inner ℂ (inclPair Hs Ks DA DB (a ⊗ₜ[ℂ] b)) (sumPoly Hs Ks DA DB A B y) := by
    intro a b y
    induction (hspan y) using Submodule.span_induction with
    | mem t ht =>
        obtain ⟨c, d, rfl⟩ := ht
        simp only [sumPoly_tmul, inclPair_tmul, inner_add_left, inner_add_right,
          TensorProduct.inner_tmul, hA a c, hB b d]
    | zero => simp
    | add s t _ _ hs ht => simp only [map_add, inner_add_right, hs, ht]
    | smul r s _ hs => simp only [map_smul, inner_smul_right, hs]
  intro x y
  induction (hspan x) using Submodule.span_induction with
  | mem t ht =>
      obtain ⟨a, b, rfl⟩ := ht
      exact hpure a b y
  | zero => simp
  | add s t _ _ hs ht => simp only [map_add, inner_add_left, hs, ht]
  | smul r s _ hs => simp only [map_smul, inner_smul_left, hs]
