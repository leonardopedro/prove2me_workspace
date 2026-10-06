-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.sum_normSq_le
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_wron_eq_sum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution (c w : ℕ → ℂ) (hrec : ∀ n, tridiagFun c w n = Complex.I * w n) (N : ℕ) :
    ∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2 ≤ ‖c N‖ * (‖w (N + 1)‖ * ‖w N‖) := by

  have hw := wron_eq_sum c w Complex.I hrec N
  have hz : Complex.I - starRingEnd ℂ Complex.I = 2 * Complex.I := by
    simp [Complex.conj_I]
    ring
  have hsum : (∑ n ∈ Finset.range (N + 1), starRingEnd ℂ (w n) * w n)
      = ((∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2 : ℝ) : ℂ) := by
    rw [Complex.ofReal_sum]
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [← Complex.normSq_eq_conj_mul_self]
    norm_cast
    exact Complex.normSq_eq_norm_sq (w n)
  rw [hz, hsum] at hw
  have hnorm : ‖wron c w N‖ = 2 * ∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2 := by
    have hpos : (0 : ℝ) ≤ ∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2 :=
      Finset.sum_nonneg fun n _ => sq_nonneg _
    generalize (∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2) = S at hw hpos ⊢
    rw [hw]
    simp [abs_of_nonneg hpos]
  have hle : ‖wron c w N‖ ≤ 2 * (‖c N‖ * (‖w (N + 1)‖ * ‖w N‖)) := by
    have h1 : ‖c N * (w (N + 1) * starRingEnd ℂ (w N))‖ = ‖c N‖ * (‖w (N + 1)‖ * ‖w N‖) := by
      simp
    have h2 : ‖starRingEnd ℂ (c N) * (starRingEnd ℂ (w (N + 1)) * w N)‖
        = ‖c N‖ * (‖w (N + 1)‖ * ‖w N‖) := by
      simp
    calc ‖wron c w N‖ ≤ ‖c N * (w (N + 1) * starRingEnd ℂ (w N))‖
          + ‖starRingEnd ℂ (c N) * (starRingEnd ℂ (w (N + 1)) * w N)‖ := norm_sub_le _ _
      _ = 2 * (‖c N‖ * (‖w (N + 1)‖ * ‖w N‖)) := by rw [h1, h2]; ring
  rw [hnorm] at hle
  linarith
