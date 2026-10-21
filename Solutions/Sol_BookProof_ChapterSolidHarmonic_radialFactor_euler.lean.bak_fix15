-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.radialFactor_euler
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Theorems.Thm_BookProof_ChapterSolidHarmonic_hasFDerivAt_radialFactor
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (e : E) (l μ : ℕ) (x : E) :
    fderiv ℝ (radialFactor e l μ) x x = ((l - μ : ℕ) : ℝ) * radialFactor e l μ x := by

  rw [(hasFDerivAt_radialFactor e l μ x).fderiv]
  simp only [ContinuousLinearMap.coe_sum', Finset.sum_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_smul', Pi.smul_apply, smul_eq_mul, innerCLM_apply]
  rw [radialFactor, Finset.mul_sum]
  refine Finset.sum_congr rfl fun m hm => ?_
  have hm2 : 2 * m ≤ l - μ := by
    have := Finset.mem_range.mp hm
    omega
  have hxx : ⟪x, x⟫_ℝ = ‖x‖ ^ 2 := real_inner_self_eq_norm_sq x
  have t1 : ((l - μ - 2 * m : ℕ) : ℝ) * (⟪e, x⟫_ℝ) ^ (l - μ - 2 * m - 1) * ⟪e, x⟫_ℝ
      = ((l - μ - 2 * m : ℕ) : ℝ) * (⟪e, x⟫_ℝ) ^ (l - μ - 2 * m) := by
    rcases Nat.eq_zero_or_pos (l - μ - 2 * m) with h | h
    · simp [h]
    · obtain ⟨k, hk⟩ : ∃ k, l - μ - 2 * m = k + 1 := ⟨l - μ - 2 * m - 1, by omega⟩
      rw [hk]
      simp only [Nat.add_sub_cancel, pow_succ]
      ring
  have t2 : 2 * (m : ℝ) * ((‖x‖ ^ 2) ^ (m - 1) * ⟪x, x⟫_ℝ) = 2 * (m : ℝ) * (‖x‖ ^ 2) ^ m := by
    rw [hxx]
    rcases Nat.eq_zero_or_pos m with h | h
    · simp [h]
    · obtain ⟨k, hk⟩ : ∃ k, m = k + 1 := ⟨m - 1, by omega⟩
      rw [hk]
      simp only [Nat.add_sub_cancel, pow_succ]
  have hnat : ((l - μ : ℕ) : ℝ) = ((l - μ - 2 * m : ℕ) : ℝ) + 2 * m := by
    have h : (l - μ - 2 * m) + 2 * m = l - μ := by omega
    calc ((l - μ : ℕ) : ℝ) = (((l - μ - 2 * m) + 2 * m : ℕ) : ℝ) := by rw [h]
      _ = ((l - μ - 2 * m : ℕ) : ℝ) + 2 * m := by push_cast; ring
  rw [hnat]
  linear_combination
    (((derivative^[μ] (legendre l)).coeff (l - μ - 2 * m)) * (‖x‖ ^ 2) ^ m) * t1
      + (((derivative^[μ] (legendre l)).coeff (l - μ - 2 * m))
          * (⟪e, x⟫_ℝ) ^ (l - μ - 2 * m)) * t2
