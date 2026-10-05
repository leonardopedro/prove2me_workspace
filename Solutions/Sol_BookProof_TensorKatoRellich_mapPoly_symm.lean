-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.mapPoly_symm
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (V : DA →ₗ[ℂ] Hs.carrier) (Y : DB →ₗ[ℂ] Ks.carrier)
    (hV : SymmetricOn DA V) (hY : SymmetricOn DB Y) :
    ∀ x y : DA ⊗[ℂ] DB,
      (inner ℂ (TensorProduct.map V Y x) (inclPair Hs Ks DA DB y) : ℂ)
        = inner ℂ (inclPair Hs Ks DA DB x) (TensorProduct.map V Y y) := by

  have hI : ∀ z : DA ⊗[ℂ] DB, inclPair Hs Ks DA DB z = (inclPair Hs Ks DA DB).toLinearMap z :=
    fun z => rfl
  have hpure : ∀ (a : DA) (b : DB) (y : DA ⊗[ℂ] DB),
      (inner ℂ (TensorProduct.map V Y (a ⊗ₜ[ℂ] b)) (inclPair Hs Ks DA DB y) : ℂ)
        = inner ℂ (inclPair Hs Ks DA DB (a ⊗ₜ[ℂ] b)) (TensorProduct.map V Y y) := by
    intro a b y
    induction y using TensorProduct.induction_on with
    | zero => rw [hI 0, map_zero, map_zero, inner_zero_right, inner_zero_right]
    | tmul c d =>
        simp only [TensorProduct.map_tmul, inclPair_tmul, TensorProduct.inner_tmul, hV a c,
          hY b d]
    | add s t hs ht => rw [hI (s + t), map_add, map_add, inner_add_right, inner_add_right,
        ← hI s, ← hI t, hs, ht]
  intro x y
  induction x using TensorProduct.induction_on with
  | zero => rw [hI 0, map_zero, map_zero, inner_zero_left, inner_zero_left]
  | tmul a b => exact hpure a b y
  | add s t hs ht => rw [hI (s + t), map_add, map_add, inner_add_left, inner_add_left,
      ← hI s, ← hI t, hs, ht]
