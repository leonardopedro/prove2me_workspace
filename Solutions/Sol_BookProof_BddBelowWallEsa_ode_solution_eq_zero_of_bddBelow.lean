-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.ode_solution_eq_zero_of_bddBelow
import Mathlib
import Theorems.Thm_BookProof_BddBelowWallEsa_continuous_zeta
import Theorems.Thm_BookProof_BddBelowWallEsa_continuous_zeta_prime
import Theorems.Thm_BookProof_BddBelowWallEsa_zeta_nonneg
import Theorems.Thm_BookProof_BddBelowWallEsa_zeta_le_one
import Theorems.Thm_BookProof_BddBelowWallEsa_zeta_one
import Theorems.Thm_BookProof_BddBelowWallEsa_hasCompactSupport_zeta
import Theorems.Thm_BookProof_BddBelowWallEsa_hasCompactSupport_zeta_sq
import Theorems.Thm_BookProof_BddBelowWallEsa_hasCompactSupport_zeta_prime_sq
import Theorems.Thm_BookProof_BddBelowWallEsa_abs_zeta_prime_le
import Theorems.Thm_BookProof_BddBelowWallEsa_hasDerivAt_reWeighted
import Theorems.Thm_BookProof_BddBelowWallEsa_hasDerivAt_imWeighted
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {V : ℝ → ℝ} (hVc : Continuous V) {K : ℝ}
    (hVK : ∀ x, -K ≤ V x) {z : ℂ} (hzre : z.re = 0) (hzim : z.im ≠ 0)
    {W W' : ℝ → ℂ} (hW : ∀ x, HasDerivAt W (W' x) x)
    (hW2 : ∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x)
    (hint : Integrable (fun x => ‖W x‖ ^ 2) volume) :
    ∀ x, W x = 0 := by

  have hWc : Continuous W := continuous_iff_continuousAt.2 fun x => (hW x).continuousAt
  have hW'c : Continuous W' := continuous_iff_continuousAt.2 fun x => (hW2 x).continuousAt
  have hPc : Continuous fun x => ((starRingEnd ℂ) (W x) * W' x).re :=
    Complex.continuous_re.comp ((Complex.continuous_conj.comp hWc).mul hW'c)
  have hQc : Continuous fun x => ((starRingEnd ℂ) (W x) * W' x).im :=
    Complex.continuous_im.comp ((Complex.continuous_conj.comp hWc).mul hW'c)
  have hPle : ∀ x, |((starRingEnd ℂ) (W x) * W' x).re| ≤ ‖W x‖ * ‖W' x‖ := by
    intro x
    calc |((starRingEnd ℂ) (W x) * W' x).re| ≤ ‖(starRingEnd ℂ) (W x) * W' x‖ :=
          Complex.abs_re_le_norm _
      _ = ‖W x‖ * ‖W' x‖ := by rw [norm_mul, RCLike.norm_conj]
  have hQle : ∀ x, |((starRingEnd ℂ) (W x) * W' x).im| ≤ ‖W x‖ * ‖W' x‖ := by
    intro x
    calc |((starRingEnd ℂ) (W x) * W' x).im| ≤ ‖(starRingEnd ℂ) (W x) * W' x‖ :=
          Complex.abs_im_le_norm _
      _ = ‖W x‖ * ‖W' x‖ := by rw [norm_mul, RCLike.norm_conj]
  set N : ℝ := ∫ x, ‖W x‖ ^ 2 with hN
  have hNnn : 0 ≤ N := integral_nonneg fun x => by positivity
  set K0 : ℝ := max K 0 with hK0def
  have hK0 : 0 ≤ K0 := le_max_right _ _
  have hVK0 : ∀ x, -K0 ≤ V x := fun x => le_trans (neg_le_neg (le_max_left K 0)) (hVK x)
  set C : ℝ := 4 * bumpM ^ 2 * N + 2 * K0 * N with hC
  -- the uniform smallness of the cutoff `L²` mass
  have key : ∀ r : ℝ, 1 ≤ r →
      |z.im| * (∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2) ≤ (C + bumpM ^ 2 * N) / r := by
    intro r hr1
    have hr : (0 : ℝ) < r := lt_of_lt_of_le one_pos hr1
    have hsuppZ2 := hasCompactSupport_zeta_sq hr
    have hsuppZ'2 := hasCompactSupport_zeta'_sq hr
    have hsuppZ := hasCompactSupport_zeta hr
    -- integrability of the basic integrands
    have iA : Integrable (fun x => (zeta r x) ^ 2 * ‖W' x‖ ^ 2) volume :=
      Continuous.integrable_of_hasCompactSupport
        (((continuous_zeta r).pow 2).mul (hW'c.norm.pow 2)) hsuppZ2.mul_right
    have iB : Integrable (fun x => (zeta r x) ^ 2 * ‖W x‖ ^ 2) volume :=
      Continuous.integrable_of_hasCompactSupport
        (((continuous_zeta r).pow 2).mul (hWc.norm.pow 2)) hsuppZ2.mul_right
    have iV : Integrable (fun x => (zeta r x) ^ 2 * (V x * ‖W x‖ ^ 2)) volume :=
      Continuous.integrable_of_hasCompactSupport
        (((continuous_zeta r).pow 2).mul (hVc.mul (hWc.norm.pow 2))) hsuppZ2.mul_right
    have iE : Integrable (fun x => (zeta' r x) ^ 2 * ‖W x‖ ^ 2) volume :=
      Continuous.integrable_of_hasCompactSupport
        (((continuous_zeta_prime r).pow 2).mul (hWc.norm.pow 2)) hsuppZ'2.mul_right
    have iJr : Integrable
        (fun x => 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re) volume :=
      Continuous.integrable_of_hasCompactSupport
        (((continuous_const.mul (continuous_zeta r)).mul (continuous_zeta_prime r)).mul hPc)
        ((hsuppZ.mul_left (f := fun _ => (2 : ℝ))).mul_right).mul_right
    have iJi : Integrable
        (fun x => 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im) volume :=
      Continuous.integrable_of_hasCompactSupport
        (((continuous_const.mul (continuous_zeta r)).mul (continuous_zeta_prime r)).mul hQc)
        ((hsuppZ.mul_left (f := fun _ => (2 : ℝ))).mul_right).mul_right
    have iFr : Integrable
        (fun x => (zeta r x) ^ 2 * ((starRingEnd ℂ) (W x) * W' x).re) volume :=
      Continuous.integrable_of_hasCompactSupport
        (((continuous_zeta r).pow 2).mul hPc) hsuppZ2.mul_right
    have iFi : Integrable
        (fun x => (zeta r x) ^ 2 * ((starRingEnd ℂ) (W x) * W' x).im) volume :=
      Continuous.integrable_of_hasCompactSupport
        (((continuous_zeta r).pow 2).mul hQc) hsuppZ2.mul_right
    have iAV : Integrable
        (fun x => (zeta r x) ^ 2 * ‖W' x‖ ^ 2 + (zeta r x) ^ 2 * (V x * ‖W x‖ ^ 2)) volume :=
      iA.add iV
    have iAV' : Integrable
        (fun x => (zeta r x) ^ 2 * (‖W' x‖ ^ 2 + (V x - z.re) * ‖W x‖ ^ 2)) volume := by
      refine iAV.congr (Filter.Eventually.of_forall fun x => ?_)
      rw [hzre]; ring
    have iBim : Integrable (fun x => (-z.im) * ((zeta r x) ^ 2 * ‖W x‖ ^ 2)) volume :=
      iB.const_mul _
    have iBim' : Integrable
        (fun x => (zeta r x) ^ 2 * (-z.im * ‖W x‖ ^ 2)) volume := by
      refine iBim.congr (Filter.Eventually.of_forall fun x => ?_)
      ring
    -- the two weighted identities
    have hidR : (∫ x, 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re)
        + ((∫ x, (zeta r x) ^ 2 * ‖W' x‖ ^ 2)
          + ∫ x, (zeta r x) ^ 2 * (V x * ‖W x‖ ^ 2)) = 0 := by
      have h0 : ∫ x, (2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re
          + (zeta r x) ^ 2 * (‖W' x‖ ^ 2 + (V x - z.re) * ‖W x‖ ^ 2)) = 0 :=
        MeasureTheory.integral_eq_zero_of_hasDerivAt_of_integrable
          (fun x => hasDerivAt_reWeighted hW hW2 r x) (iJr.add iAV') iFr
      have hpt : (fun x => 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re
            + (zeta r x) ^ 2 * (‖W' x‖ ^ 2 + (V x - z.re) * ‖W x‖ ^ 2))
          = fun x => 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re
            + ((zeta r x) ^ 2 * ‖W' x‖ ^ 2 + (zeta r x) ^ 2 * (V x * ‖W x‖ ^ 2)) := by
        funext x; rw [hzre]; ring
      rw [hpt, integral_add iJr iAV, integral_add iA iV] at h0
      exact h0
    have hidI : (∫ x, 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im)
        + (-z.im) * (∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2) = 0 := by
      have h0 : ∫ x, (2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im
          + (zeta r x) ^ 2 * (-z.im * ‖W x‖ ^ 2)) = 0 :=
        MeasureTheory.integral_eq_zero_of_hasDerivAt_of_integrable
          (fun x => hasDerivAt_imWeighted hW hW2 r x) (iJi.add iBim') iFi
      have hpt : (fun x => 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im
            + (zeta r x) ^ 2 * (-z.im * ‖W x‖ ^ 2))
          = fun x => 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im
            + (-z.im) * ((zeta r x) ^ 2 * ‖W x‖ ^ 2) := by
        funext x; ring
      rw [hpt, integral_add iJi iBim, integral_const_mul] at h0
      exact h0
    -- the cutoff derivative energy is small
    have hEle : (∫ x, (zeta' r x) ^ 2 * ‖W x‖ ^ 2) ≤ bumpM ^ 2 / r ^ 2 * N := by
      have hpt : ∀ x, (zeta' r x) ^ 2 * ‖W x‖ ^ 2 ≤ bumpM ^ 2 / r ^ 2 * ‖W x‖ ^ 2 := by
        intro x
        have h2 : (zeta' r x) ^ 2 ≤ bumpM ^ 2 / r ^ 2 := by
          have := pow_le_pow_left₀ (abs_nonneg (zeta' r x)) (abs_zeta'_le hr x) 2
          rw [sq_abs] at this
          calc (zeta' r x) ^ 2 ≤ (bumpM / r) ^ 2 := this
            _ = bumpM ^ 2 / r ^ 2 := by rw [div_pow]
        exact mul_le_mul_of_nonneg_right h2 (by positivity)
      calc (∫ x, (zeta' r x) ^ 2 * ‖W x‖ ^ 2)
          ≤ ∫ x, bumpM ^ 2 / r ^ 2 * ‖W x‖ ^ 2 := integral_mono iE (hint.const_mul _) hpt
        _ = bumpM ^ 2 / r ^ 2 * N := by rw [integral_const_mul]
    have hEle1 : (∫ x, (zeta' r x) ^ 2 * ‖W x‖ ^ 2) ≤ bumpM ^ 2 * N := by
      refine hEle.trans ?_
      have h1 : bumpM ^ 2 / r ^ 2 ≤ bumpM ^ 2 := by
        rw [div_le_iff₀ (by positivity)]
        nlinarith [mul_nonneg (sq_nonneg bumpM) (by nlinarith : (0:ℝ) ≤ r ^ 2 - 1)]
      exact mul_le_mul_of_nonneg_right h1 hNnn
    have hEnn : 0 ≤ ∫ x, (zeta' r x) ^ 2 * ‖W x‖ ^ 2 :=
      integral_nonneg fun x => by positivity
    -- the potential term is bounded below
    have hVint : -(K0 * N) ≤ ∫ x, (zeta r x) ^ 2 * (V x * ‖W x‖ ^ 2) := by
      have hpt : ∀ x, -K0 * ‖W x‖ ^ 2 ≤ (zeta r x) ^ 2 * (V x * ‖W x‖ ^ 2) := by
        intro x
        have h0 : (0 : ℝ) ≤ (zeta r x) ^ 2 := sq_nonneg _
        have h1 : (zeta r x) ^ 2 ≤ 1 := by
          nlinarith [zeta_nonneg r x, zeta_le_one r x]
        have h2 : -K0 ≤ (zeta r x) ^ 2 * V x := by
          nlinarith [mul_nonneg h0 (by linarith [hVK0 x] : (0:ℝ) ≤ V x + K0)]
        have h3 : (0 : ℝ) ≤ ‖W x‖ ^ 2 := by positivity
        nlinarith [mul_le_mul_of_nonneg_right h2 h3]
      calc -(K0 * N) = ∫ x, -K0 * ‖W x‖ ^ 2 := by rw [integral_const_mul]; ring
        _ ≤ _ := integral_mono (hint.const_mul _) iV hpt
    -- Young's inequality for the cross term, real part
    have hYr : ∀ x, |2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re|
        ≤ 1 / 2 * ((zeta r x) ^ 2 * ‖W' x‖ ^ 2) + 2 * ((zeta' r x) ^ 2 * ‖W x‖ ^ 2) := by
      intro x
      have habs : |2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re|
          = 2 * |zeta r x| * |zeta' r x| * |((starRingEnd ℂ) (W x) * W' x).re| := by
        rw [abs_mul, abs_mul, abs_mul, abs_two]
      rw [habs]
      have hstep : 2 * |zeta r x| * |zeta' r x| * |((starRingEnd ℂ) (W x) * W' x).re|
          ≤ 2 * |zeta r x| * |zeta' r x| * (‖W x‖ * ‖W' x‖) :=
        mul_le_mul_of_nonneg_left (hPle x) (by positivity)
      refine hstep.trans ?_
      have := sq_nonneg (|zeta r x| * ‖W' x‖ - 2 * (|zeta' r x| * ‖W x‖))
      nlinarith [sq_abs (zeta r x), sq_abs (zeta' r x), abs_nonneg (zeta r x),
        abs_nonneg (zeta' r x), norm_nonneg (W x), norm_nonneg (W' x)]
    -- Young's inequality for the cross term, imaginary part, with weight `1/r`
    have hYi : ∀ x, |2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im|
        ≤ 1 / r * ((zeta r x) ^ 2 * ‖W' x‖ ^ 2) + r * ((zeta' r x) ^ 2 * ‖W x‖ ^ 2) := by
      intro x
      have habs : |2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im|
          = 2 * |zeta r x| * |zeta' r x| * |((starRingEnd ℂ) (W x) * W' x).im| := by
        rw [abs_mul, abs_mul, abs_mul, abs_two]
      rw [habs]
      have hstep : 2 * |zeta r x| * |zeta' r x| * |((starRingEnd ℂ) (W x) * W' x).im|
          ≤ 2 * |zeta r x| * |zeta' r x| * (‖W x‖ * ‖W' x‖) :=
        mul_le_mul_of_nonneg_left (hQle x) (by positivity)
      refine hstep.trans ?_
      set a : ℝ := |zeta r x| * ‖W' x‖ with ha
      set b : ℝ := |zeta' r x| * ‖W x‖ with hb
      have hz2 : (zeta r x) ^ 2 * ‖W' x‖ ^ 2 = a ^ 2 := by
        rw [ha, mul_pow, sq_abs]
      have hz'2 : (zeta' r x) ^ 2 * ‖W x‖ ^ 2 = b ^ 2 := by
        rw [hb, mul_pow, sq_abs]
      have hcomm : 2 * |zeta r x| * |zeta' r x| * (‖W x‖ * ‖W' x‖) = 2 * (a * b) := by
        rw [ha, hb]; ring
      rw [hz2, hz'2, hcomm]
      have hexp : 1 / r * a ^ 2 + r * b ^ 2 - 2 * (a * b) = (a - r * b) ^ 2 / r := by
        field_simp; ring
      have hnn : (0 : ℝ) ≤ (a - r * b) ^ 2 / r := by positivity
      linarith
    -- the cutoff kinetic energy is uniformly bounded
    have hAle : (∫ x, (zeta r x) ^ 2 * ‖W' x‖ ^ 2) ≤ C := by
      have hJr : |∫ x, 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re|
          ≤ 1 / 2 * (∫ x, (zeta r x) ^ 2 * ‖W' x‖ ^ 2)
            + 2 * ∫ x, (zeta' r x) ^ 2 * ‖W x‖ ^ 2 := by
        refine (abs_integral_le_integral_abs).trans ?_
        have hb : Integrable (fun x => 1 / 2 * ((zeta r x) ^ 2 * ‖W' x‖ ^ 2)
            + 2 * ((zeta' r x) ^ 2 * ‖W x‖ ^ 2)) volume := (iA.const_mul _).add (iE.const_mul _)
        calc (∫ x, |2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re|)
            ≤ ∫ x, (1 / 2 * ((zeta r x) ^ 2 * ‖W' x‖ ^ 2)
              + 2 * ((zeta' r x) ^ 2 * ‖W x‖ ^ 2)) := integral_mono iJr.abs hb hYr
          _ = _ := by
              rw [integral_add (iA.const_mul _) (iE.const_mul _), integral_const_mul,
                integral_const_mul]
      have h1 := abs_le.1 hJr
      have := h1.1
      rw [hC]
      nlinarith [hEle1, hVint, hNnn, hEnn]
    -- and hence the cutoff `L²` mass is `O(1/r)`
    have hJi : |∫ x, 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im|
        ≤ 1 / r * (∫ x, (zeta r x) ^ 2 * ‖W' x‖ ^ 2)
          + r * ∫ x, (zeta' r x) ^ 2 * ‖W x‖ ^ 2 := by
      refine (abs_integral_le_integral_abs).trans ?_
      have hb : Integrable (fun x => 1 / r * ((zeta r x) ^ 2 * ‖W' x‖ ^ 2)
          + r * ((zeta' r x) ^ 2 * ‖W x‖ ^ 2)) volume := (iA.const_mul _).add (iE.const_mul _)
      calc (∫ x, |2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im|)
          ≤ ∫ x, (1 / r * ((zeta r x) ^ 2 * ‖W' x‖ ^ 2)
            + r * ((zeta' r x) ^ 2 * ‖W x‖ ^ 2)) := integral_mono iJi.abs hb hYi
        _ = _ := by
            rw [integral_add (iA.const_mul _) (iE.const_mul _), integral_const_mul,
              integral_const_mul]
    have hBnn : 0 ≤ ∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2 := integral_nonneg fun x => by positivity
    have hAnn : 0 ≤ ∫ x, (zeta r x) ^ 2 * ‖W' x‖ ^ 2 := integral_nonneg fun x => by positivity
    have habsB : |z.im| * (∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2)
        = |∫ x, 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im| := by
      have : (∫ x, 2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im)
          = z.im * (∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2) := by linarith [hidI]
      rw [this, abs_mul, abs_of_nonneg hBnn]
    rw [habsB]
    refine hJi.trans ?_
    have hrE : r * (∫ x, (zeta' r x) ^ 2 * ‖W x‖ ^ 2) ≤ bumpM ^ 2 * N / r := by
      have := mul_le_mul_of_nonneg_left hEle (le_of_lt hr)
      calc r * (∫ x, (zeta' r x) ^ 2 * ‖W x‖ ^ 2) ≤ r * (bumpM ^ 2 / r ^ 2 * N) := this
        _ = bumpM ^ 2 * N / r := by field_simp
    have hrA : 1 / r * (∫ x, (zeta r x) ^ 2 * ‖W' x‖ ^ 2) ≤ C / r := by
      rw [one_div, inv_mul_eq_div, div_le_div_iff_of_pos_right hr]
      exact hAle
    have : C / r + bumpM ^ 2 * N / r = (C + bumpM ^ 2 * N) / r := by ring
    linarith
  -- pass to the limit
  have hNzero : N = 0 := by
    have hsets : ∀ n : ℕ, MeasurableSet (Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1)) :=
      fun _ => measurableSet_Icc
    have hmono : Monotone fun n : ℕ => Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1) := by
      intro m n hmn
      have hmn' : (m : ℝ) ≤ n := by exact_mod_cast hmn
      exact Icc_subset_Icc (by linarith) (by linarith)
    have hunion : (⋃ n : ℕ, Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1)) = univ := by
      ext x
      simp only [mem_iUnion, mem_Icc, mem_univ, iff_true]
      obtain ⟨n, hn⟩ := exists_nat_gt |x|
      exact ⟨n, by linarith [neg_abs_le x], by linarith [le_abs_self x]⟩
    have hlim : Tendsto (fun n : ℕ => ∫ x in Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1), ‖W x‖ ^ 2)
        atTop (𝓝 N) := by
      have h := tendsto_setIntegral_of_monotone (f := fun x => ‖W x‖ ^ 2)
        (μ := (volume : Measure ℝ)) hsets hmono (by rw [hunion]; exact hint.integrableOn)
      rwa [hunion, setIntegral_univ] at h
    have himpos : (0 : ℝ) < |z.im| := abs_pos.2 hzim
    have hbound : ∀ n : ℕ, (∫ x in Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1), ‖W x‖ ^ 2)
        ≤ (C + bumpM ^ 2 * N) / (|z.im| * ((n : ℝ) + 1)) := by
      intro n
      have hcast : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
      set r : ℝ := (n : ℝ) + 1 with hrdef
      have hr1 : (1 : ℝ) ≤ r := by rw [hrdef]; linarith
      have hr : (0 : ℝ) < r := by linarith
      have iB : Integrable (fun x => (zeta r x) ^ 2 * ‖W x‖ ^ 2) volume :=
        Continuous.integrable_of_hasCompactSupport
          (((continuous_zeta r).pow 2).mul (hWc.norm.pow 2))
          (hasCompactSupport_zeta_sq hr).mul_right
      have hset : (∫ x in Icc (-r) r, ‖W x‖ ^ 2) ≤ ∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2 := by
        have heq : (∫ x in Icc (-r) r, ‖W x‖ ^ 2)
            = ∫ x in Icc (-r) r, (zeta r x) ^ 2 * ‖W x‖ ^ 2 := by
          refine setIntegral_congr_fun measurableSet_Icc fun x hx => ?_
          rw [zeta_one hr (abs_le.2 ⟨hx.1, hx.2⟩)]
          ring
        rw [heq]
        exact setIntegral_le_integral iB (Filter.Eventually.of_forall fun x => by positivity)
      have hk := key r hr1
      rw [le_div_iff₀ (by positivity : (0 : ℝ) < |z.im| * r)]
      have h1 : (∫ x in Icc (-r) r, ‖W x‖ ^ 2) * (|z.im| * r)
          ≤ (∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2) * (|z.im| * r) :=
        mul_le_mul_of_nonneg_right hset (by positivity)
      have h2 : (∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2) * (|z.im| * r) ≤ C + bumpM ^ 2 * N := by
        have h3 := mul_le_mul_of_nonneg_right hk hr.le
        rw [div_mul_cancel₀ _ (ne_of_gt hr)] at h3
        calc (∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2) * (|z.im| * r)
            = (|z.im| * (∫ x, (zeta r x) ^ 2 * ‖W x‖ ^ 2)) * r := by ring
          _ ≤ C + bumpM ^ 2 * N := h3
      linarith
    have hlim2 : Tendsto (fun n : ℕ => (C + bumpM ^ 2 * N) / (|z.im| * ((n : ℝ) + 1)))
        atTop (𝓝 0) :=
      Filter.Tendsto.div_atTop tendsto_const_nhds
        (Filter.Tendsto.const_mul_atTop himpos
          (tendsto_atTop_add_const_right _ 1 tendsto_natCast_atTop_atTop))
    have hle : N ≤ 0 := le_of_tendsto_of_tendsto' hlim hlim2 hbound
    linarith
  -- a continuous non-negative function with vanishing integral is zero
  have hae : (fun x => ‖W x‖ ^ 2) =ᵐ[(volume : Measure ℝ)] 0 :=
    (integral_eq_zero_iff_of_nonneg (fun x => by positivity) hint).1 hNzero
  have heq : (fun x => ‖W x‖ ^ 2) = (0 : ℝ → ℝ) :=
    (Continuous.ae_eq_iff_eq volume (hWc.norm.pow 2) continuous_const).1 hae
  intro x
  have hx2 : ‖W x‖ ^ 2 = 0 := congrFun heq x
  have hx0 : ‖W x‖ = 0 := by nlinarith [norm_nonneg (W x)]
  exact norm_eq_zero.1 hx0
