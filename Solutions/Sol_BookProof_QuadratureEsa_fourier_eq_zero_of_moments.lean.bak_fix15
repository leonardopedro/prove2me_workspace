-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.fourier_eq_zero_of_moments
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}
private theorem integrable_inner_pow_mul {v : Vd d → ℂ}
    (hmeas : AEStronglyMeasurable v (volume : Measure (Vd d)))
    (hexp : ∀ c : ℝ, Integrable (fun x : Vd d => Real.exp (c * ‖x‖) * ‖v x‖))
    (w : Vd d) (k : ℕ) :
    Integrable (fun x : Vd d => ((inner ℝ x w : ℝ) : ℂ) ^ k * v x) := by
  have hmeas' : AEStronglyMeasurable (fun x : Vd d => ((inner ℝ x w : ℝ) : ℂ) ^ k * v x)
      (volume : Measure (Vd d)) := by
    refine AEStronglyMeasurable.mul ?_ hmeas
    exact ((Complex.continuous_ofReal.comp (by fun_prop)).pow k).aestronglyMeasurable
  refine Integrable.mono' (((hexp ‖w‖).const_mul (k.factorial : ℝ))) hmeas' ?_
  filter_upwards with x
  have hinner : |(inner ℝ x w : ℝ)| ≤ ‖x‖ * ‖w‖ := abs_real_inner_le_norm x w
  have h1 : ‖((inner ℝ x w : ℝ) : ℂ) ^ k‖ ≤ (‖w‖ * ‖x‖) ^ k := by
    rw [norm_pow, Complex.norm_real, Real.norm_eq_abs]
    exact pow_le_pow_left₀ (abs_nonneg _) (by rw [mul_comm]; exact hinner) k
  have h2 : (‖w‖ * ‖x‖) ^ k ≤ (k.factorial : ℝ) * Real.exp (‖w‖ * ‖x‖) := by
    have hpos : (0 : ℝ) ≤ ‖w‖ * ‖x‖ := by positivity
    have hle : (‖w‖ * ‖x‖) ^ k / (k.factorial : ℝ) ≤ Real.exp (‖w‖ * ‖x‖) := by
      have := Real.sum_le_exp_of_nonneg hpos (k + 1)
      have hmem : (‖w‖ * ‖x‖) ^ k / (k.factorial : ℝ)
          ≤ ∑ j ∈ Finset.range (k + 1), (‖w‖ * ‖x‖) ^ j / (j.factorial : ℝ) := by
        refine Finset.single_le_sum (f := fun j => (‖w‖ * ‖x‖) ^ j / (j.factorial : ℝ))
          (fun j _ => by positivity) (Finset.self_mem_range_succ k)
      linarith
    have hfac : (0 : ℝ) < (k.factorial : ℝ) := by exact_mod_cast k.factorial_pos
    calc (‖w‖ * ‖x‖) ^ k = (k.factorial : ℝ) * ((‖w‖ * ‖x‖) ^ k / (k.factorial : ℝ)) := by
          field_simp
      _ ≤ (k.factorial : ℝ) * Real.exp (‖w‖ * ‖x‖) := by
          exact mul_le_mul_of_nonneg_left hle hfac.le
  calc ‖((inner ℝ x w : ℝ) : ℂ) ^ k * v x‖
      = ‖((inner ℝ x w : ℝ) : ℂ) ^ k‖ * ‖v x‖ := norm_mul _ _
    _ ≤ ((k.factorial : ℝ) * Real.exp (‖w‖ * ‖x‖)) * ‖v x‖ := by
        exact mul_le_mul_of_nonneg_right (h1.trans h2) (norm_nonneg _)
    _ = (k.factorial : ℝ) * (Real.exp (‖w‖ * ‖x‖) * ‖v x‖) := by ring

set_option maxHeartbeats 1000000 in
theorem solution {v : Vd d → ℂ}
    (hmeas : AEStronglyMeasurable v (volume : Measure (Vd d)))
    (hexp : ∀ c : ℝ, Integrable (fun x : Vd d => Real.exp (c * ‖x‖) * ‖v x‖))
    (hmom : ∀ p : MvPolynomial (Fin d) ℂ,
      ∫ x : Vd d, MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p * v x = 0)
    (w : Vd d) : 𝓕 v w = 0 := by

  set c : ℝ := 2 * Real.pi * ‖w‖ with hc
  set F : ℕ → Vd d → ℂ := fun N x =>
    (∑ k ∈ Finset.range N,
        (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ))
      * v x with hF
  have hmomk : ∀ k : ℕ, ∫ x : Vd d, ((inner ℝ x w : ℝ) : ℂ) ^ k * v x = 0 := by
    intro k
    have h := hmom ((innerPoly w) ^ k)
    rw [← h]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    change ((inner ℝ x w : ℝ) : ℂ) ^ k * v x
      = MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) ((innerPoly w) ^ k) * v x
    rw [map_pow, eval_innerPoly]
  have hFint : ∀ N, ∫ x : Vd d, F N x = 0 := by
    intro N
    have hpt : ∀ x : Vd d, F N x = ∑ k ∈ Finset.range N,
        ((Complex.I * ((-2 * Real.pi : ℝ) : ℂ)) ^ k / (k.factorial : ℂ))
          * (((inner ℝ x w : ℝ) : ℂ) ^ k * v x) := by
      intro x
      simp only [hF, Finset.sum_mul]
      refine Finset.sum_congr rfl fun k _ => ?_
      push_cast
      ring
    simp_rw [hpt]
    rw [integral_finset_sum _ (fun k _ =>
      ((integrable_inner_pow_mul hmeas hexp w k)).const_mul _)]
    simp [integral_const_mul, hmomk]
  have hmeasF : ∀ N, AEStronglyMeasurable (F N) (volume : Measure (Vd d)) := by
    intro N
    refine AEStronglyMeasurable.mul (Continuous.aestronglyMeasurable ?_) hmeas
    refine continuous_finset_sum _ fun k _ => ?_
    refine Continuous.div_const ?_ _
    exact (continuous_const.mul (Complex.continuous_ofReal.comp
      (continuous_const.mul (by fun_prop)))).pow k
  have hdom : ∀ N, ∀ᵐ x : Vd d, ‖F N x‖ ≤ Real.exp (c * ‖x‖) * ‖v x‖ := by
    intro N
    filter_upwards with x
    have hinner : |(inner ℝ x w : ℝ)| ≤ ‖x‖ * ‖w‖ := abs_real_inner_le_norm x w
    have hsum : ‖∑ k ∈ Finset.range N,
        (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ)‖
        ≤ Real.exp (c * ‖x‖) := by
      have hstep : ∀ k ∈ Finset.range N,
          ‖(Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ)‖
            ≤ (c * ‖x‖) ^ k / (k.factorial : ℝ) := by
        intro k _
        rw [norm_div, norm_pow]
        have hnum : ‖Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)‖ ≤ c * ‖x‖ := by
          rw [norm_mul, Complex.norm_I, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_mul,
            hc]
          have h2pi : |(-2 * Real.pi : ℝ)| = 2 * Real.pi := by
            rw [abs_of_nonpos (by nlinarith [Real.pi_pos] : (-2 * Real.pi : ℝ) ≤ 0)]; ring
          rw [h2pi]
          calc 2 * Real.pi * |(inner ℝ x w : ℝ)| ≤ 2 * Real.pi * (‖x‖ * ‖w‖) := by
                exact mul_le_mul_of_nonneg_left hinner (by positivity)
            _ = 2 * Real.pi * ‖w‖ * ‖x‖ := by ring
        have hden : ‖(k.factorial : ℂ)‖ = (k.factorial : ℝ) := by simp
        rw [hden]
        gcongr
      calc ‖∑ k ∈ Finset.range N,
            (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ)‖
          ≤ ∑ k ∈ Finset.range N,
              ‖(Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k
                / (k.factorial : ℂ)‖ := norm_sum_le _ _
        _ ≤ ∑ k ∈ Finset.range N, (c * ‖x‖) ^ k / (k.factorial : ℝ) :=
            Finset.sum_le_sum hstep
        _ ≤ Real.exp (c * ‖x‖) := Real.sum_le_exp_of_nonneg (by positivity) N
    simp only [hF, norm_mul]
    exact mul_le_mul_of_nonneg_right hsum (norm_nonneg _)
  have hlim : ∀ᵐ x : Vd d, Filter.Tendsto (fun N => F N x) Filter.atTop
      (nhds (Complex.exp (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) * v x)) := by
    filter_upwards with x
    have hsum := (NormedSpace.expSeries_div_hasSum_exp (𝔸 := ℂ)
      (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)))
    have hsum' : HasSum (fun k : ℕ =>
        (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ))
        (Complex.exp (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ))) := by
      simpa [Complex.exp_eq_exp_ℂ] using hsum
    exact hsum'.tendsto_sum_nat.mul_const _
  have hconv := MeasureTheory.tendsto_integral_of_dominated_convergence
    (fun x : Vd d => Real.exp (c * ‖x‖) * ‖v x‖) hmeasF (hexp c) hdom hlim
  have hval : ∫ x : Vd d, Complex.exp (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ))
      * v x = 0 := by
    have hc0 : Filter.Tendsto (fun _ : ℕ => (0 : ℂ)) Filter.atTop
        (nhds (∫ x : Vd d, Complex.exp (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ))
          * v x)) := by
      simpa [hFint] using hconv
    exact tendsto_nhds_unique hc0 tendsto_const_nhds
  rw [Real.fourier_eq', ← hval]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [smul_eq_mul]
  congr 2
  push_cast
  ring
