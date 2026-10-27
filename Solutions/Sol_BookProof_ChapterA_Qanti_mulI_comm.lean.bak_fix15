-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.Qanti_mulI_comm
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (S : V →L[ℝ] V) : mulI * Qanti S = -(Qanti S * mulI) := by

  have h : (mulI : V →L[ℝ] V) * mulI = -1 := mulI_mul_mulI
  have e1 : (mulI : V →L[ℝ] V) * (mulI * S * mulI) = -(S * mulI) := by
    rw [← mul_assoc, ← mul_assoc, h, neg_one_mul, neg_mul]
  have e2 : (mulI * S * mulI) * (mulI : V →L[ℝ] V) = -(mulI * S) := by
    rw [mul_assoc, h, mul_neg_one]
  simp only [Qanti, mul_smul_comm, smul_mul_assoc, mul_add, add_mul, e1, e2]
  simp only [smul_add, smul_neg]; abel
