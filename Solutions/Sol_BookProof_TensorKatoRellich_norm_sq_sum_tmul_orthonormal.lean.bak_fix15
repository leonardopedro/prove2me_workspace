-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.norm_sq_sum_tmul_orthonormal
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {E F : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] [NormedAddCommGroup F] [InnerProductSpace ℂ F] {ι : Type*}
    [Fintype ι] {b : ι → F} (hb : Orthonormal ℂ b) (v : ι → E) :
    ‖∑ i, v i ⊗ₜ[ℂ] b i‖ ^ 2 = ∑ i, ‖v i‖ ^ 2 := by

  classical
  rw [orthonormal_iff_ite] at hb
  have h : (inner ℂ (∑ i, v i ⊗ₜ[ℂ] b i) (∑ i, v i ⊗ₜ[ℂ] b i) : ℂ)
      = ∑ i, (inner ℂ (v i) (v i) : ℂ) := by
    rw [sum_inner]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [inner_sum, Finset.sum_eq_single i]
    · rw [TensorProduct.inner_tmul, hb, if_pos rfl, mul_one]
    · intro j _ hj
      rw [TensorProduct.inner_tmul, hb, if_neg (Ne.symm hj), mul_zero]
    · intro h; exact absurd (Finset.mem_univ i) h
  rw [@norm_sq_eq_re_inner ℂ, h, map_sum]
  exact Finset.sum_congr rfl fun i _ => (@norm_sq_eq_re_inner ℂ _ _ _ _ (v i)).symm
