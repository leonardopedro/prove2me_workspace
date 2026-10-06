-- Generated from ChapterA1.lean — solution of BookProof.ChapterA.AntiUnitary.inner_map_map
import Mathlib
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary V) (x y : V) :
    inner ℂ (θ x) (θ y) = conj (inner ℂ x y) := by

  rw [inner_eq_sum_norm_sq_div_four (𝕜 := ℂ), inner_eq_sum_norm_sq_div_four (𝕜 := ℂ)]
  have hn : ∀ z : V, ‖θ z‖ = ‖z‖ := fun z => θ.norm_map z
  have hI : (RCLike.I : ℂ) • θ y = θ (-(RCLike.I : ℂ) • y) := by
    rw [θ.map_smulₛₗ]; simp
  have e1 : ‖θ x + θ y‖ = ‖x + y‖ := by rw [← map_add, hn]
  have e2 : ‖θ x - θ y‖ = ‖x - y‖ := by rw [← map_sub, hn]
  have e3 : ‖θ x + (RCLike.I : ℂ) • θ y‖ = ‖x - (RCLike.I : ℂ) • y‖ := by
    rw [hI, ← map_add, hn, neg_smul, ← sub_eq_add_neg]
  have e4 : ‖θ x - (RCLike.I : ℂ) • θ y‖ = ‖x + (RCLike.I : ℂ) • y‖ := by
    rw [hI, ← map_sub, hn, neg_smul, sub_neg_eq_add]
  rw [e1, e2, e3, e4, map_div₀]
  apply Complex.ext <;>
    simp [Complex.div_re, Complex.div_im, Complex.add_im, Complex.add_re, Complex.mul_re,
      Complex.mul_im] <;> ring
