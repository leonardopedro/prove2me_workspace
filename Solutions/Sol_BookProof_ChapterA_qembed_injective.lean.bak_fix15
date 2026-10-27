-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.qembed_injective
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial V] (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = -x) :
    Function.Injective (qembed θ hθ) := by

  rw [injective_iff_map_eq_zero]
  intro a ha
  by_contra h
  have h1 : (qembed θ hθ) (a⁻¹ * a) = 1 := by
    rw [inv_mul_cancel₀ h]; exact map_one _
  rw [map_mul, ha, mul_zero] at h1
  exact one_ne_zero h1.symm
