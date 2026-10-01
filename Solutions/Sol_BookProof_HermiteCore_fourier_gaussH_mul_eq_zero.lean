-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.fourier_gaussH_mul_eq_zero
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_gaussH_pos
import Theorems.Thm_BookProof_HermiteCore_continuous_gaussH
import Theorems.Thm_BookProof_HermiteCore_memLp_poly_mul_gaussH
import Theorems.Thm_BookProof_HermiteCore_memLp_two_exp_abs_mul_gaussH
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
w : ∫ x : ℝ, g x • v x = ∫ x : ℝ, v x * (psi : ℝ → ℂ) x := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp [hpsi, Complex.real_smul]
    exact mul_comm _ _
  rw [hrw, ← hkey]

theorem solution (z : ℂ) :
    HasSum (fun k : ℕ => z ^ k / (k.factorial : ℂ)) (Complex.exp z) := by
  sim :=
  pa [Complex.exp_eq_exp_ℂ] using NormedSpace.expSeries_div_hasSum_exp (𝔸 := ℂ) z
  
  /-- If `u ∈ L²` is orthogonal to every `xᵏ e^{-x²/4}`, then the Fourier transform
  of the `L¹` function `e^{-x²/4} u` vanishes identically. -/
  theorem fourier_gaussH_mul_eq_zero {u : ℝ → ℂ} (hu : MemLp u 2 (volume : Measure ℝ))
      (hmom : ∀ k : ℕ, ∫ x : ℝ, ((x ^ k * gaussH x : ℝ) : ℂ) * u x = 0) (w : ℝ) :
      𝓕 (fun x : ℝ => ((gaussH x : ℝ) : ℂ) * u x) w = 0 := by
    set a : ℝ := -2 * Real.pi * w with ha
    have hmono : ∀ k : ℕ,
        MemLp (fun x : ℝ => ((x ^ k * gaussH x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by
      intro k
      simpa using memLp_poly_mul_gaussH ((X : Polynomial ℝ) ^ k)
    have hterm : ∀ k : ℕ, Integrable (fun x : ℝ => ((x ^ k * gaussH x : ℝ) : ℂ) * u x) :=
      fun k => integrable_mul_of_memLp_two (hmono k) hu
    set F : ℕ → ℝ → ℂ := fun N x =>
      (∑ k ∈ Finset.range N, (Complex.I * (a : ℂ) * (x : ℂ)) ^ k / (k.factorial : ℂ))
        * (((gaussH x : ℝ) : ℂ) * u x) with hF
    have hFint : ∀ N, ∫ x : ℝ, F N x = 0 := by
      intro N
      have hpt : ∀ x : ℝ, F N x = ∑ k ∈ Finset.range N,
          ((Complex.I * (a : ℂ)) ^ k / (k.factorial : ℂ))
            * (((x ^ k * gaussH x : ℝ) : ℂ) * u x) := by
        intro x
        simp only [hF, Finset.sum_mul]
        refine Finset.sum_congr rfl fun k _ => ?_
        push_cast
        ring
      simp_rw [hpt]
      rw [integral_finsetSum _ (fun k _ => (hterm k).const_mul _)]
      have hmom' : ∀ k : ℕ, ∫ x : ℝ, (x : ℂ) ^ k * ((gaussH x : ℝ) : ℂ) * u x = 0 := by
        intro k
        have h := hmom k
        push_cast at h
        simpa [mul_assoc] using h
      simp [integral_const_mul, hmom']
    have hbdd : Integrable (fun x : ℝ => ((Real.exp (|a| * |x|) * gaussH x : ℝ) : ℂ) * u x) :=
      integrable_mul_of_memLp_two (memLp_two_exp_abs_mul_gaussH |a|) hu
    have hmeas : ∀ N, AEStronglyMeasurable (F N) (volume : Measure ℝ) := by
      intro N
      refine AEStronglyMeasurable.mul (Continuous.aestronglyMeasurable (by fun_prop)) ?_
      exact ((Complex.continuous_ofReal.comp continuous_gaussH).aestronglyMeasurable).mul hu.1
    have hdom : ∀ N, ∀ᵐ x : ℝ, ‖F N x‖
        ≤ ‖((Real.exp (|a| * |x|) * gaussH x : ℝ) : ℂ) * u x‖ := by
      intro N
      filter_upwards with x
      have hsum : ‖∑ k ∈ Finset.range N, (Complex.I * (a : ℂ) * (x : ℂ)) ^ k / (k.factorial : ℂ)‖
          ≤ Real.exp (|a| * |x|) := by
        calc ‖∑ k ∈ Finset.range N, (Complex.I * (a : ℂ) * (x : ℂ)) ^ k / (k.factorial : ℂ)‖
            ≤ ∑ k ∈ Finset.range N, ‖(Complex.I * (a : ℂ) * (x : ℂ)) ^ k / (k.factorial : ℂ)‖ :=
              norm_sum_le _ _
          _ = ∑ k ∈ Finset.range N, (|a| * |x|) ^ k / (k.factorial : ℝ) := by
              refine Finset.sum_congr rfl fun k _ => ?_
              rw [norm_div, norm_pow]
              simp
          _ ≤ Real.exp (|a| * |x|) := Real.sum_le_exp_of_nonneg (by positivity) N
      simp only [hF, norm_mul]
      have h1 : ‖((Real.exp (|a| * |x|) * gaussH x : ℝ) : ℂ)‖
          = Real.exp (|a| * |x|) * gaussH x := by
        rw [Complex.norm_real, Real.norm_eq_abs,
          abs_of_nonneg (mul_pos (Real.exp_pos _) (gaussH_pos x)).le]
      have h2 : ‖((gaussH x : ℝ) : ℂ)‖ = gaussH x := by
        rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos (gaussH_pos x)]
      rw [h1, h2]
      have hg : (0 : ℝ) ≤ gaussH x * ‖u x‖ := mul_nonneg (gaussH_pos x).le (norm_nonneg _)
      calc ‖∑ k ∈ Finset.range N, (Complex.I * (a : ℂ) * (x : ℂ)) ^ k / (k.factorial : ℂ)‖
            * (gaussH x * ‖u x‖)
          ≤ Real.exp (|a| * |x|) * (gaussH x * ‖u x‖) := mul_le_mul_of_nonneg_right hsum hg
        _ = Real.exp (|a| * |x|) * gaussH x * ‖u x‖ := by ring
    have hlim : ∀ᵐ x : ℝ, Filter.Tendsto (fun N => F N x) Filter.atTop
        (nhds (Complex.exp (Complex.I * (a : ℂ) * (x : ℂ)) * (((gaussH x : ℝ) : ℂ) * u x))) := by
      filter_upwards with x
      exact ((complex_exp_hasSum (Complex.I * (a : ℂ) * (x : ℂ))).tendsto_sum_nat).mul_const _
    have hconv := MeasureTheory.tendsto_integral_of_dominated_convergence
      (fun x : ℝ => ‖((Real.exp (|a| * |x|) * gaussH x : ℝ) : ℂ) * u x‖)
      hmeas hbdd.norm hdom hlim
    have hval : ∫ x : ℝ, Complex.exp (Complex.I * (a : ℂ) * (x : ℂ)) * (((gaussH x : ℝ) : ℂ) * u x)
