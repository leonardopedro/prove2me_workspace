-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.schur_test
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {L : Finset ℕ} {m : ℕ → ℕ → ℝ} {x y : ℕ → ℝ} {K : ℝ}
    (hm : ∀ k j, 0 ≤ m k j) (hx : ∀ k, 0 ≤ x k) (hy : ∀ j, 0 ≤ y j) (hK0 : 0 ≤ K)
    (hrow : ∀ k, ∑ j ∈ L, m k j ≤ K) (hcol : ∀ j, ∑ k ∈ L, m k j ≤ K) :
    ∑ k ∈ L, ∑ j ∈ L, m k j * (x k * y j)
      ≤ K * (Real.sqrt (∑ k ∈ L, x k ^ 2) * Real.sqrt (∑ j ∈ L, y j ^ 2)) := by

  classical
  set A : ℝ := ∑ k ∈ L, x k ^ 2 with hAdef
  set B : ℝ := ∑ j ∈ L, y j ^ 2 with hBdef
  have hAnn : 0 ≤ A := Finset.sum_nonneg fun k _ => sq_nonneg _
  have hBnn : 0 ≤ B := Finset.sum_nonneg fun j _ => sq_nonneg _
  set S : ℝ := ∑ k ∈ L, ∑ j ∈ L, m k j * (x k * y j) with hSdef
  have hSnn : 0 ≤ S :=
    Finset.sum_nonneg fun k _ => Finset.sum_nonneg fun j _ =>
      mul_nonneg (hm k j) (mul_nonneg (hx k) (hy j))
  set a : ℕ × ℕ → ℝ := fun p => Real.sqrt (m p.1 p.2) * x p.1 with hadef
  set b : ℕ × ℕ → ℝ := fun p => Real.sqrt (m p.1 p.2) * y p.2 with hbdef
  have hprod : S = ∑ p ∈ L ×ˢ L, a p * b p := by
    rw [hSdef, Finset.sum_product]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
    have hsq : Real.sqrt (m k j) * Real.sqrt (m k j) = m k j := Real.mul_self_sqrt (hm k j)
    simp only [hadef, hbdef]
    rw [show (Real.sqrt (m k j) * x k) * (Real.sqrt (m k j) * y j)
        = (Real.sqrt (m k j) * Real.sqrt (m k j)) * (x k * y j) from by ring, hsq]
  have hAsum : ∑ p ∈ L ×ˢ L, a p ^ 2 ≤ K * A := by
    have hstep : ∑ p ∈ L ×ˢ L, a p ^ 2 = ∑ k ∈ L, (x k ^ 2 * ∑ j ∈ L, m k j) := by
      rw [Finset.sum_product]
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun j _ => ?_
      have hsq : Real.sqrt (m k j) ^ 2 = m k j := Real.sq_sqrt (hm k j)
      simp only [hadef]
      rw [mul_pow, hsq]
      ring
    rw [hstep, hAdef, Finset.mul_sum]
    refine Finset.sum_le_sum fun k _ => ?_
    rw [mul_comm K (x k ^ 2)]
    exact mul_le_mul_of_nonneg_left (hrow k) (sq_nonneg _)
  have hBsum : ∑ p ∈ L ×ˢ L, b p ^ 2 ≤ K * B := by
    have hstep : ∑ p ∈ L ×ˢ L, b p ^ 2 = ∑ j ∈ L, (y j ^ 2 * ∑ k ∈ L, m k j) := by
      rw [Finset.sum_product_right]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun k _ => ?_
      have hsq : Real.sqrt (m k j) ^ 2 = m k j := Real.sq_sqrt (hm k j)
      simp only [hbdef]
      rw [mul_pow, hsq]
      ring
    rw [hstep, hBdef, Finset.mul_sum]
    refine Finset.sum_le_sum fun j _ => ?_
    rw [mul_comm K (y j ^ 2)]
    exact mul_le_mul_of_nonneg_left (hcol j) (sq_nonneg _)
  have hCS : S ^ 2 ≤ (∑ p ∈ L ×ˢ L, a p ^ 2) * (∑ p ∈ L ×ˢ L, b p ^ 2) := by
    rw [hprod]
    exact Finset.sum_mul_sq_le_sq_mul_sq _ a b
  have hAnn' : (0:ℝ) ≤ ∑ p ∈ L ×ˢ L, a p ^ 2 := Finset.sum_nonneg fun p _ => sq_nonneg _
  have hBnn' : (0:ℝ) ≤ ∑ p ∈ L ×ˢ L, b p ^ 2 := Finset.sum_nonneg fun p _ => sq_nonneg _
  have hS2 : S ^ 2 ≤ (K * A) * (K * B) := by
    refine hCS.trans ?_
    exact mul_le_mul hAsum hBsum hBnn' (le_trans hAnn' hAsum)
  have hRnn : 0 ≤ K * (Real.sqrt A * Real.sqrt B) :=
    mul_nonneg hK0 (mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _))
  have hR2 : (K * (Real.sqrt A * Real.sqrt B)) ^ 2 = (K * A) * (K * B) := by
    have h1 : Real.sqrt A ^ 2 = A := Real.sq_sqrt hAnn
    have h2 : Real.sqrt B ^ 2 = B := Real.sq_sqrt hBnn
    rw [show (K * (Real.sqrt A * Real.sqrt B)) ^ 2
        = K ^ 2 * (Real.sqrt A ^ 2 * Real.sqrt B ^ 2) from by ring, h1, h2]
    ring
  nlinarith [hS2, hR2, hSnn, hRnn]
