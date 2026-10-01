-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.double_sum_amgm
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : Finset ι) (w : ι → ι → ℝ) (f g r : ι → ℝ)
    (hw : ∀ a b, 0 ≤ w a b)
    (hrow : ∀ a, ∑ b ∈ P, w a b ≤ r a) (hcol : ∀ b, ∑ a ∈ P, w a b ≤ r b) :
    ∑ a ∈ P, ∑ b ∈ P, w a b * (f a * g b)
      ≤ (1 / 2) * ((∑ a ∈ P, r a * f a ^ 2) + ∑ b ∈ P, r b * g b ^ 2) := by

  have step1 : ∑ a ∈ P, ∑ b ∈ P, w a b * (f a * g b)
      ≤ ∑ a ∈ P, ∑ b ∈ P, ((w a b * f a ^ 2) / 2 + (w a b * g b ^ 2) / 2) := by
    refine Finset.sum_le_sum fun a _ => Finset.sum_le_sum fun b _ => ?_
    nlinarith [sq_nonneg (f a - g b), hw a b]
  have step2 : ∀ a, ∑ b ∈ P, ((w a b * f a ^ 2) / 2 + (w a b * g b ^ 2) / 2)
      = ((∑ b ∈ P, w a b) * f a ^ 2) / 2 + (∑ b ∈ P, w a b * g b ^ 2) / 2 := by
    intro a
    rw [Finset.sum_add_distrib, ← Finset.sum_div, ← Finset.sum_div, ← Finset.sum_mul]
  have step3 : ∑ a ∈ P, ∑ b ∈ P, ((w a b * f a ^ 2) / 2 + (w a b * g b ^ 2) / 2)
      = (∑ a ∈ P, (∑ b ∈ P, w a b) * f a ^ 2) / 2
        + (∑ b ∈ P, (∑ a ∈ P, w a b) * g b ^ 2) / 2 := by
    rw [Finset.sum_congr rfl fun a _ => step2 a, Finset.sum_add_distrib, ← Finset.sum_div,
      ← Finset.sum_div]
    congr 2
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun b _ => by rw [Finset.sum_mul]
  have step4 : (∑ a ∈ P, (∑ b ∈ P, w a b) * f a ^ 2) ≤ ∑ a ∈ P, r a * f a ^ 2 :=
    Finset.sum_le_sum fun a _ => mul_le_mul_of_nonneg_right (hrow a) (sq_nonneg _)
  have step5 : (∑ b ∈ P, (∑ a ∈ P, w a b) * g b ^ 2) ≤ ∑ b ∈ P, r b * g b ^ 2 :=
    Finset.sum_le_sum fun b _ => mul_le_mul_of_nonneg_right (hcol b) (sq_nonneg _)
  rw [step3] at step1
  linarith
