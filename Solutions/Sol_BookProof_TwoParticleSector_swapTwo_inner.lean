-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.swapTwo_inner
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TwoParticleSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}

set_option maxHeartbeats 1000000 in
theorem solution (t s : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) :
    (inner ℂ (swapTwo X t) (swapTwo X s) : ℂ) = inner ℂ t s := by
  -- The direct route `(swapTwo X).inner_map_map t s` no longer elaborates here: the
  -- `LinearIsometryEquiv` carries `TensorProduct.instModule` while `inner_map_map` expects the
  -- module instance derived from `TensorProduct.instInnerProductSpace`, and unifying the two
  -- instance chains diverges.  We instead induct on the algebraic tensor product, pinning the
  -- inner-product-space instance explicitly in every helper so that its `inner` is the one the
  -- goal uses.
  have h0 : (swapTwo X) (0 : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) = 0 :=
    LinearIsometryEquiv.map_zero (swapTwo X)
  have hz : ∀ c : X ⊗[ℂ] (X ⊗[ℂ] ℂ), (inner ℂ (0 : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) c : ℂ) = 0 := fun c =>
    @inner_zero_left ℂ (X ⊗[ℂ] (X ⊗[ℂ] ℂ)) _ _
      (TensorProduct.instInnerProductSpace : InnerProductSpace ℂ (X ⊗[ℂ] (X ⊗[ℂ] ℂ))) c
  have hzr : ∀ c : X ⊗[ℂ] (X ⊗[ℂ] ℂ), (inner ℂ c (0 : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) : ℂ) = 0 := fun c =>
    @inner_zero_right ℂ (X ⊗[ℂ] (X ⊗[ℂ] ℂ)) _ _
      (TensorProduct.instInnerProductSpace : InnerProductSpace ℂ (X ⊗[ℂ] (X ⊗[ℂ] ℂ))) c
  have haddL : ∀ a b c : X ⊗[ℂ] (X ⊗[ℂ] ℂ),
      (inner ℂ (a + b) c : ℂ) = inner ℂ a c + inner ℂ b c := fun a b c =>
    @inner_add_left ℂ (X ⊗[ℂ] (X ⊗[ℂ] ℂ)) _ _
      (TensorProduct.instInnerProductSpace : InnerProductSpace ℂ (X ⊗[ℂ] (X ⊗[ℂ] ℂ))) a b c
  have haddR : ∀ a b c : X ⊗[ℂ] (X ⊗[ℂ] ℂ),
      (inner ℂ c (a + b) : ℂ) = inner ℂ c a + inner ℂ c b := fun a b c =>
    @inner_add_right ℂ (X ⊗[ℂ] (X ⊗[ℂ] ℂ)) _ _
      (TensorProduct.instInnerProductSpace : InnerProductSpace ℂ (X ⊗[ℂ] (X ⊗[ℂ] ℂ))) c a b
  have key : ∀ a b : X ⊗[ℂ] (X ⊗[ℂ] ℂ),
      (inner ℂ (swapTwo X a) (swapTwo X b) : ℂ) = inner ℂ a b := by
    intro t' s'
    induction t' using TensorProduct.induction_on with
    | zero => rw [h0, hz (swapTwo X s'), hz s']
    | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero =>
        simp only [TensorProduct.tmul_zero]
        rw [h0, hz (swapTwo X s'), hz s']
      | tmul y c =>
        induction s' using TensorProduct.induction_on with
        | zero =>
          rw [h0, hzr (swapTwo X (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c))), hzr (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c))]
        | tmul x' b' =>
          induction b' using TensorProduct.induction_on with
          | zero =>
            simp only [TensorProduct.tmul_zero]
            rw [h0, hzr (swapTwo X (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c))), hzr (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c))]
          | tmul y' c' =>
            simp only [swapTwo_tmul, TensorProduct.inner_tmul, mul_left_comm]
          | add u v hu hv =>
            simp only [TensorProduct.tmul_add, map_add]
            rw [haddR, haddR, hu, hv]
        | add u v hu hv =>
          simp only [map_add]
          rw [haddR, haddR, hu, hv]
      | add u v hu hv =>
        simp only [TensorProduct.tmul_add, map_add]
        rw [haddL, haddL, hu, hv]
    | add u v hu hv =>
      simp only [map_add]
      rw [haddL, haddL, hu, hv]
  exact key t s
