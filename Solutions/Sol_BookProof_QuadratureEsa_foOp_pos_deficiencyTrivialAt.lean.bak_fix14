-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.foOp_pos_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_ae_eq_zero_of_moments_prime
import Theorems.Thm_BookProof_QuadratureEsa_eval_linPoly
import Theorems.Thm_BookProof_QuadratureEsa_abs_linSymb_le
import Theorems.Thm_BookProof_QuadratureEsa_foOp_coe
import Theorems.Thm_BookProof_HermiteRelative_foOp_linear_apply_eq_mul
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreEquiv_coe
import Theorems.Thm_BookProof_YangMillsHermite_eval_starP
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

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin d → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (foOp b 0) z := by

  intro w hw
  set W : Vd d → ℂ := fun x => (w : Vd d → ℂ) x with hW
  have hWmem : MemLp W 2 (volume : Measure (Vd d)) := Lp.memLp w
  set v : Vd d → ℂ :=
    fun x => ((gaussD x : ℝ) : ℂ) * ((((linSymb b x : ℝ) : ℂ) - z) * W x) with hv
  -- measurability
  have hmeas : AEStronglyMeasurable v (volume : Measure (Vd d)) := by
    refine AEStronglyMeasurable.mul ?_ (AEStronglyMeasurable.mul ?_ hWmem.1)
    · exact (Complex.continuous_ofReal.comp continuous_gaussD).aestronglyMeasurable
    · refine AEStronglyMeasurable.sub ?_ aestronglyMeasurable_const
      refine (Complex.continuous_ofReal.comp ?_).aestronglyMeasurable
      exact continuous_finset_sum _ fun i _ => continuous_const.mul (by fun_prop)
  -- exponential integrability
  have hexp : ∀ c : ℝ, Integrable (fun x : Vd d => Real.exp (c * ‖x‖) * ‖v x‖) := by
    intro c
    set B : ℝ := (∑ i, |b i|) + ‖z‖ + 1 with hB
    have hBpos : 0 < B := by
      have : 0 ≤ ∑ i, |b i| := Finset.sum_nonneg fun i _ => abs_nonneg _
      positivity
    have hdom : Integrable
        (fun x : Vd d => B * ‖((Real.exp ((c + 1) * ‖x‖) * gaussD x : ℝ) : ℂ) * W x‖) := by
      refine Integrable.const_mul ?_ B
      exact (integrable_mul_of_memLp_two (memLp_two_exp_norm_mul_gaussD (c + 1)) hWmem).norm
    refine Integrable.mono' hdom ?_ ?_
    · exact ((Real.continuous_exp.comp
        (continuous_const.mul continuous_norm)).aestronglyMeasurable).mul hmeas.norm
    · filter_upwards with x
      have hgpos : 0 < gaussD x := gaussD_pos x
      have hnv : ‖v x‖ = gaussD x * (‖((linSymb b x : ℝ) : ℂ) - z‖ * ‖W x‖) := by
        rw [hv]
        simp only [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hgpos]
      have hlin : ‖((linSymb b x : ℝ) : ℂ) - z‖ ≤ B * Real.exp ‖x‖ := by
        have h1 : ‖((linSymb b x : ℝ) : ℂ) - z‖ ≤ |linSymb b x| + ‖z‖ := by
          refine (norm_sub_le _ _).trans ?_
          rw [Complex.norm_real, Real.norm_eq_abs]
        have h2 : |linSymb b x| + ‖z‖ ≤ ((∑ i, |b i|) + ‖z‖ + 1) * (1 + ‖x‖) := by
          have := abs_linSymb_le b x
          have hnn : (0 : ℝ) ≤ ∑ i, |b i| := Finset.sum_nonneg fun i _ => abs_nonneg _
          nlinarith [norm_nonneg x, norm_nonneg z]
        have h3 : (1 : ℝ) + ‖x‖ ≤ Real.exp ‖x‖ := by
          have := Real.add_one_le_exp ‖x‖
          linarith
        calc ‖((linSymb b x : ℝ) : ℂ) - z‖ ≤ ((∑ i, |b i|) + ‖z‖ + 1) * (1 + ‖x‖) := h1.trans h2
          _ ≤ B * Real.exp ‖x‖ := by rw [hB]; exact mul_le_mul_of_nonneg_left h3 hBpos.le
      have hrhs : ‖((Real.exp ((c + 1) * ‖x‖) * gaussD x : ℝ) : ℂ) * W x‖
          = Real.exp ((c + 1) * ‖x‖) * gaussD x * ‖W x‖ := by
        rw [norm_mul, Complex.norm_real, Real.norm_eq_abs,
          abs_of_nonneg (by positivity : (0:ℝ) ≤ Real.exp ((c + 1) * ‖x‖) * gaussD x)]
      rw [Real.norm_eq_abs, abs_of_nonneg (by positivity), hnv, hrhs]
      have hexpadd : Real.exp ((c + 1) * ‖x‖) = Real.exp (c * ‖x‖) * Real.exp ‖x‖ := by
        rw [← Real.exp_add]; ring_nf
      rw [hexpadd]
      have hWnn : (0 : ℝ) ≤ ‖W x‖ := norm_nonneg _
      have hstep : gaussD x * (‖((linSymb b x : ℝ) : ℂ) - z‖ * ‖W x‖)
          ≤ gaussD x * ((B * Real.exp ‖x‖) * ‖W x‖) := by
        gcongr
      calc Real.exp (c * ‖x‖) * (gaussD x * (‖((linSymb b x : ℝ) : ℂ) - z‖ * ‖W x‖))
          ≤ Real.exp (c * ‖x‖) * (gaussD x * ((B * Real.exp ‖x‖) * ‖W x‖)) := by
            exact mul_le_mul_of_nonneg_left hstep (Real.exp_pos _).le
        _ = B * (Real.exp (c * ‖x‖) * Real.exp ‖x‖ * gaussD x * ‖W x‖) := by ring
  -- all polynomial moments vanish
  have hmom : ∀ q : MvPolynomial (Fin d) ℂ,
      ∫ x : Vd d, MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q * v x = 0 := by
    intro q
    set p : MvPolynomial (Fin d) ℂ := starP q with hp
    have hconj : ∀ x : Vd d, (starRingEnd ℂ) (pgFun p x) = pgFun q x := by
      intro x
      rw [pgFun, pgFun, map_mul, Complex.conj_ofReal, hp, eval_starP, Complex.conj_conj]
    -- the two integrals occurring in the deficiency identity
    have hint1 : Integrable (fun x : Vd d => pgFun q x * W x) :=
      integrable_mul_of_memLp_two (memLp_pgFun q) hWmem
    have hint2 : Integrable (fun x : Vd d => pgFun (linPoly b * q) x * W x) :=
      integrable_mul_of_memLp_two (memLp_pgFun (linPoly b * q)) hWmem
    have hpt2 : ∀ x : Vd d, pgFun (linPoly b * q) x * W x
        = ((linSymb b x : ℝ) : ℂ) * (pgFun q x * W x) := by
      intro x
      rw [pgFun, pgFun, map_mul, eval_linPoly]
      ring
    have h := hw (coreEquiv p)
    rw [foOp_coe, coreEquiv_coe, inner_pgLp, inner_pgLp] at h
    replace h : ∫ x : Vd d, (starRingEnd ℂ) (pgFun (foPoly b 0 p) x) * W x
        = z * ∫ x : Vd d, (starRingEnd ℂ) (pgFun p x) * W x := h
    have hL : ∫ x : Vd d, (starRingEnd ℂ) (pgFun (foPoly b 0 p) x) * W x
        = ∫ x : Vd d, ((linSymb b x : ℝ) : ℂ) * (pgFun q x * W x) := by
      refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
      change (starRingEnd ℂ) (pgFun (foPoly b 0 p) x) * W x
        = ((linSymb b x : ℝ) : ℂ) * (pgFun q x * W x)
      rw [foOp_linear_apply_eq_mul, map_mul, Complex.conj_ofReal, hconj]
      simp only [linSymb]
      ring
    have hR : ∫ x : Vd d, (starRingEnd ℂ) (pgFun p x) * W x = ∫ x : Vd d, pgFun q x * W x := by
      refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
      change (starRingEnd ℂ) (pgFun p x) * W x = pgFun q x * W x
      rw [hconj]
    rw [hL, hR] at h
    have hsplit : ∫ x : Vd d, MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q * v x
        = (∫ x : Vd d, ((linSymb b x : ℝ) : ℂ) * (pgFun q x * W x))
          - z * ∫ x : Vd d, pgFun q x * W x := by
      have hpt : ∀ x : Vd d, MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q * v x
          = ((linSymb b x : ℝ) : ℂ) * (pgFun q x * W x) - z * (pgFun q x * W x) := by
        intro x
        rw [hv, pgFun]
        ring
      simp_rw [hpt]
      rw [integral_sub ?_ (hint1.const_mul z), integral_const_mul]
      · exact hint2.congr (Filter.Eventually.of_forall fun x => hpt2 x)
    rw [hsplit, h]
    ring
  -- conclude
  have hzero := ae_eq_zero_of_moments_prime hmeas hexp hmom
  have hWzero : ∀ᵐ x : Vd d, W x = 0 := by
    filter_upwards [hzero] with x hx
    have hg : ((gaussD x : ℝ) : ℂ) ≠ 0 := by
      exact_mod_cast ne_of_gt (gaussD_pos x)
    have hlz : ((linSymb b x : ℝ) : ℂ) - z ≠ 0 := by
      intro h0
      apply hz
      have := congrArg Complex.im h0
      simpa using this.symm
    have h1 : (((linSymb b x : ℝ) : ℂ) - z) * W x = 0 := (mul_eq_zero.mp hx).resolve_left hg
    exact (mul_eq_zero.mp h1).resolve_left hlz
  exact Lp.eq_zero_iff_ae_eq_zero.mpr hWzero
