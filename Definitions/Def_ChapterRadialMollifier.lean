import Mathlib


/-!
# A radial smooth mollifier on `ℂ`, and the disc mean-value property

This file provides the analytic tool needed by
`BookProof/ChapterWeylCauchyRiemann.lean` — the distributional
("weak Cauchy–Riemann") version of the *Holomorphic fields* remark of `book.tex`
(line ~4105).

Mathlib's `ContDiffBump` family is only known to be *even*, not *radial*
(the abstract `ContDiffBumpBase` interface records `toFun R (-x) = toFun R x`
and nothing more), and radiality is exactly what makes a mollifier reproduce
holomorphic functions.  So we build an explicit radial mollifier on `ℂ` out of
Mathlib's `expNegInvGlue`:

* `radialBump z = expNegInvGlue (1 - ‖z‖²)` — smooth, nonnegative, supported in
  the open unit ball, and depending on `z` only through `‖z‖`;
* `moll δ` — its `L¹`-normalized rescaling, supported in `ball 0 δ` with
  `∫ moll δ = 1`.

The payoff is `integral_moll_eq_self_of_analytic`: convolving a function
holomorphic on an open set with `moll δ` reproduces the function at every point
whose closed `δ`-ball is contained in that set.  This is the disc form of the
mean value property, obtained from Mathlib's circle mean value property
(`circleAverage_of_differentiable_on_off_countable`) by integration in polar
coordinates.
-/

namespace BookProof.RadialMollifier

open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

/-- The raw radial bump on `ℂ`: `z ↦ expNegInvGlue (1 - ‖z‖²)`.  It is smooth,
nonnegative, supported exactly in the open unit ball, and radial. -/
def radialBump (z : ℂ) : ℝ := expNegInvGlue (1 - Complex.normSq z)





















/-- The total mass of the raw bump. -/
def radialMass : ℝ := ∫ z : ℂ, radialBump z



/-- The normalized radial mollifier of width `δ`: smooth, nonnegative, supported
in `ball 0 δ`, of total integral one, and radial. -/
def moll (δ : ℝ) (z : ℂ) : ℝ := radialBump (δ⁻¹ • z) / (radialMass * δ ^ 2)























ields* remark of `book.tex`
(line ~4105).

Mathlib's `ContDiffBump` family is only known to be *even*, not *radial*
(the abstract `ContDiffBumpBase` interface records `toFun R (-x) = toFun R x`
and nothing more), and radiality is exactly what makes a mollifier reproduce
holomorphic functions.  So we build an explicit radial mollifier on `ℂ` out of
Mathlib's `expNegInvGlue`:

* `radialBump z = expNegInvGlue (1 - ‖z‖²)` — smooth, nonnegative, supported in
  the open unit ball, and depending on `z` only through `‖z‖`;
* `moll δ` — its `L¹`-normalized rescaling, supported in `ball 0 δ` with
  `∫ moll δ = 1`.

The payoff is `integral_moll_eq_self_of_analytic`: convolving a function
holomorphic on an open set with `moll δ` reproduces the function at every point
whose closed `δ`-ball is contained in that set.  This is the disc form of the
mean value property, obtained from Mathlib's circle mean value property
(`circleAverage_of_differentiable_on_off_countable`) by integration in polar
coordinates.
-/

namespace BookProof.RadialMollifier

open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

/-- The raw radial bump on `ℂ`: `z ↦ expNegInvGlue (1 - ‖z‖²)`.  It is smooth,
nonnegative, supported exactly in the open unit ball, and radial. -/
def radialBump (z : ℂ) : ℝ := expNegInvGlue (1 - Complex.normSq z)

theorem contDiff_normSq : ContDiff ℝ ∞ (fun z : ℂ => Complex.normSq z) := by
  simp only [Complex.normSq_apply]
  exact (Complex.reCLM.contDiff.mul Complex.reCLM.contDiff).add
    (Complex.imCLM.contDiff.mul Complex.imCLM.contDiff)

theorem radialBump_contDiff : ContDiff ℝ ∞ radialBump :=
  expNegInvGlue.contDiff.comp (contDiff_const.sub contDiff_normSq)

theorem radialBump_continuous : Continuous radialBump :=
  radialBump_contDiff.continuous

theorem radialBump_nonneg (z : ℂ) : 0 ≤ radialBump z := expNegInvGlue.nonneg _

/-- `radialBump` depends on `z` only through `‖z‖`: it is genuinely radial. -/
theorem radialBump_congr_norm {z w : ℂ} (h : ‖z‖ = ‖w‖) :
    radialBump z = radialBump w := by
  simp only [radialBump, Complex.normSq_eq_norm_sq, h]

theorem radialBump_eq_zero_of_one_le {z : ℂ} (h : 1 ≤ ‖z‖) : radialBump z = 0 := by
  refine expNegInvGlue.zero_of_nonpos ?_
  have : (1 : ℝ) ≤ ‖z‖ ^ 2 := by nlinarith [norm_nonneg z]
  simp only [Complex.normSq_eq_norm_sq]
  linarith

theorem radialBump_pos_of_lt_one {z : ℂ} (h : ‖z‖ < 1) : 0 < radialBump z := by
  refine expNegInvGlue.pos_of_pos ?_
  have : ‖z‖ ^ 2 < 1 := by nlinarith [norm_nonneg z]
  simp only [Complex.normSq_eq_norm_sq]
  linarith

theorem radialBump_support : Function.support radialBump = ball (0 : ℂ) 1 := by
  ext z
  simp only [Function.mem_support, mem_ball, dist_zero_right]
  constructor
  · intro hz
    by_contra hcon
    exact hz (radialBump_eq_zero_of_one_le (not_lt.1 hcon))
  · intro hz
    exact (radialBump_pos_of_lt_one hz).ne'

theorem radialBump_hasCompactSupport : HasCompactSupport radialBump := by
  apply HasCompactSupport.of_support_subset_isCompact (isCompact_closedBall (0 : ℂ) 1)
  rw [radialBump_support]
  exact ball_subset_closedBall

theorem radialBump_integrable : Integrable radialBump :=
  radialBump_continuous.integrable_of_hasCompactSupport radialBump_hasCompactSupport

/-- The total mass of the raw bump. -/
def radialMass : ℝ := ∫ z : ℂ, radialBump z

theorem radialMass_pos : 0 < radialMass := by
  rw [radialMass]
  rw [integral_pos_iff_support_of_nonneg radialBump_nonneg radialBump_integrable]
  rw [radialBump_support]
  simpa using (measure_ball_pos volume (0 : ℂ) one_pos)

/-- The normalized radial mollifier of width `δ`: smooth, nonnegative, supported
in `ball 0 δ`, of total integral one, and radial. -/
def moll (δ : ℝ) (z : ℂ) : ℝ := radialBump (δ⁻¹ • z) / (radialMass * δ ^ 2)

theorem moll_contDiff (δ : ℝ) : ContDiff ℝ ∞ (moll δ) := by
  have h : ContDiff ℝ ∞ (fun z : ℂ => radialBump (δ⁻¹ • z)) :=
    radialBump_contDiff.comp (contDiff_const_smul _)
  exact h.div_const _

theorem moll_continuous (δ : ℝ) : Continuous (moll δ) := (moll_contDiff δ).continuous

theorem moll_nonneg (δ : ℝ) (z : ℂ) : 0 ≤ moll δ z := by
  exact div_nonneg (radialBump_nonneg _) (mul_nonneg radialMass_pos.le (sq_nonneg δ))

theorem moll_congr_norm {δ : ℝ} {z w : ℂ} (h : ‖z‖ = ‖w‖) : moll δ z = moll δ w := by
  simp only [moll]
  congr 1
  refine radialBump_congr_norm ?_
  simp [h]

theorem moll_eq_zero_of_le {δ : ℝ} (hδ : 0 < δ) {z : ℂ} (h : δ ≤ ‖z‖) : moll δ z = 0 := by
  have : (1 : ℝ) ≤ ‖δ⁻¹ • z‖ := by
    rw [norm_smul]
    simp only [norm_inv, Real.norm_eq_abs, abs_of_pos hδ]
    rw [inv_mul_eq_div, le_div_iff₀ hδ]
    simpa using h
  rw [moll, radialBump_eq_zero_of_one_le this, zero_div]

theorem moll_support_subset {δ : ℝ} (hδ : 0 < δ) :
    Function.support (moll δ) ⊆ ball (0 : ℂ) δ := by
  intro z hz
  simp only [Function.mem_support] at hz
  simp only [mem_ball, dist_zero_right]
  by_contra hcon
  exact hz (moll_eq_zero_of_le hδ (not_lt.1 hcon))

theorem moll_hasCompactSupport {δ : ℝ} (hδ : 0 < δ) : HasCompactSupport (moll δ) := by
  apply HasCompactSupport.of_support_subset_isCompact (isCompact_closedBall (0 : ℂ) δ)
  exact (moll_support_subset hδ).trans ball_subset_closedBall

theorem moll_integrable {δ : ℝ} (hδ : 0 < δ) : Integrable (moll δ) :=
  (moll_continuous δ).integrable_of_hasCompactSupport (moll_hasCompactSupport hδ)

theorem moll_integral {δ : ℝ} (hδ : 0 < δ) : ∫ z : ℂ, moll δ z = 1 := by
  have hfr : Module.finrank ℝ ℂ = 2 := Complex.finrank_real_complex
  have h : ∫ z : ℂ, radialBump (δ⁻¹ • z) = δ ^ 2 • radialMass := by
    rw [MeasureTheory.Measure.integral_comp_inv_smul_of_nonneg volume radialBump hδ.le, hfr,
      radialMass]
  simp only [moll]
  rw [MeasureTheory.integral_div, h, smul_eq_mul]
  have hm := radialMass_pos.ne'
  field_simp

theorem continuous_polarSymm : Continuous (fun p : ℝ × ℝ => Complex.polarCoord.symm p) := by
  simp only [Complex.polarCoord_symm_apply]
  fun_prop

theorem moll_polarSymm {δ r θ : ℝ} (hr : 0 < r) :
    moll δ (Complex.polarCoord.symm (r, θ)) = moll δ (r : ℂ) := by
  refine moll_congr_norm ?_
  rw [Complex.norm_polarCoord_symm]
  simp [abs_of_pos hr]

/-- Polar form of a radially weighted integral. -/
theorem polar_radial {δ : ℝ} (hδ : 0 < δ) (G : ℂ → ℂ) (hG : Continuous G) :
    ∫ u : ℂ, (moll δ u : ℂ) * G u
      = ∫ r in Ioi (0 : ℝ), ((r * moll δ r : ℝ) : ℂ) *
          ∫ θ in (-π)..π, G (Complex.polarCoord.symm (r, θ)) := by
  classical
  set f : ℂ → ℂ := fun u => (moll δ u : ℂ) * G u with hf
  set F : ℝ × ℝ → ℂ := fun p => p.1 • f (Complex.polarCoord.symm p) with hF
  have hFcont : Continuous F := by
    refine Continuous.smul continuous_fst ?_
    exact (Continuous.mul (Complex.continuous_ofReal.comp
      ((moll_continuous δ).comp continuous_polarSymm)) (hG.comp continuous_polarSymm))
  -- the integrand vanishes unless `|p.1| < δ`
  have hvanish : ∀ p : ℝ × ℝ, δ ≤ |p.1| → F p = 0 := by
    intro p hp
    have : moll δ (Complex.polarCoord.symm p) = 0 := by
      refine moll_eq_zero_of_le hδ ?_
      rw [Complex.norm_polarCoord_symm]
      exact hp
    change p.1 • ((moll δ (Complex.polarCoord.symm p) : ℂ) * G _) = 0
    rw [this]
    simp
  -- integrability on the polar target
  have hint : IntegrableOn F (Ioi (0 : ℝ) ×ˢ Ioo (-π) π) (volume.prod volume) := by
    have hmeas : MeasurableSet (Ioi (0 : ℝ) ×ˢ Ioo (-π) π) :=
      measurableSet_Ioi.prod measurableSet_Ioo
    obtain ⟨C, hC⟩ := (isCompact_Icc (a := (-δ, -π)) (b := (δ, π))).exists_bound_of_continuousOn
      hFcont.continuousOn
    rw [← integrable_indicator_iff hmeas]
    refine Integrable.mono' (g := (Icc (-δ, -π) (δ, π)).indicator (fun _ => max C 0)) ?_
      (hFcont.aestronglyMeasurable.indicator hmeas) ?_
    · rw [integrable_indicator_iff measurableSet_Icc]
      exact integrableOn_const (C := max C 0) (by
        refine ne_of_lt ?_
        exact (measure_Icc_lt_top (μ := (volume : Measure (ℝ × ℝ))))) |>.mono_set (le_refl _)
    · filter_upwards with p
      by_cases hp : p ∈ Ioi (0 : ℝ) ×ˢ Ioo (-π) π
      · rw [Set.indicator_of_mem hp]
        by_cases hp1 : δ ≤ |p.1|
        · rw [hvanish p hp1]
          simpa using Set.indicator_apply_nonneg (a := p)
            (fun _ => le_max_right C 0)
        · have hmem : p ∈ Icc (-δ, -π) (δ, π) := by
            obtain ⟨hp1', hp2⟩ := hp
            simp only [mem_Icc, Prod.le_def]
            push_neg at hp1
            constructor
            · exact ⟨by cases abs_lt.1 hp1 with | intro h1 h2 => linarith,
                le_of_lt (mem_Ioo.1 hp2).1⟩
            · exact ⟨le_of_lt (abs_lt.1 hp1).2, le_of_lt (mem_Ioo.1 hp2).2⟩
          rw [Set.indicator_of_mem hmem]
          exact le_trans (hC p hmem) (le_max_left _ _)
      · rw [Set.indicator_of_notMem hp]
        simp only [norm_zero]
        exact Set.indicator_apply_nonneg fun _ => le_max_right _ _
  have key : (∫ p in Complex.polarCoord.target, F p) = ∫ u : ℂ, f u :=
    Complex.integral_comp_polarCoord_symm f
  rw [← key, Complex.polarCoord_target, Measure.volume_eq_prod, setIntegral_prod F hint]
  refine setIntegral_congr_fun measurableSet_Ioi ?_
  intro r hr
  have hr0 : 0 < r := hr
  have hinner : ∀ θ : ℝ,
      F (r, θ) = ((r * moll δ r : ℝ) : ℂ) * G (Complex.polarCoord.symm (r, θ)) := by
    intro θ
    simp only [hF, hf, moll_polarSymm hr0, Complex.real_smul, Complex.ofReal_mul]
    ring
  simp only [hinner]
  rw [MeasureTheory.integral_const_mul, ← integral_Ioc_eq_integral_Ioo,
    ← intervalIntegral.integral_of_le (by linarith [Real.pi_pos] : (-π : ℝ) ≤ π)]

theorem circle_integral_eq {h : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s) (hh : DifferentiableOn ℂ h s)
    {z : ℂ} {r : ℝ} (hr : 0 < r) (hsub : closedBall z r ⊆ s) :
    ∫ θ in (-π)..π, h (z - (r : ℂ) * Complex.exp (θ * Complex.I)) = ((2 * π : ℝ) : ℂ) * h z := by
  have e1 : ∀ θ : ℝ, z - (r : ℂ) * Complex.exp (θ * Complex.I) = circleMap z (-r) θ := by
    intro θ
    simp [circleMap]
    ring
  have hper : Function.Periodic (fun θ : ℝ => h (circleMap z (-r) θ)) (2 * π) := by
    intro θ
    simp [periodic_circleMap z (-r) θ]
  have hshift : (∫ θ in (-π)..π, h (circleMap z (-r) θ))
      = ∫ θ in (0 : ℝ)..(2 * π), h (circleMap z (-r) θ) := by
    have := hper.intervalIntegral_add_eq (-π) 0
    simpa [add_comm, two_mul] using this
  have habs : |(-r)| = r := by rw [abs_neg, abs_of_pos hr]
  have hcavg : circleAverage h z (-r) = h z := by
    refine circleAverage_of_differentiable_on_off_countable (s := (∅ : Set ℂ)) countable_empty ?_ ?_
    · rw [habs]
      exact (hh.continuousOn).mono hsub
    · intro w hw
      rw [habs] at hw
      exact hh.differentiableAt (hs.mem_nhds (hsub (ball_subset_closedBall hw.1)))
  simp only [e1]
  rw [hshift]
  have : (∫ θ in (0:ℝ)..(2 * π), h (circleMap z (-r) θ)) = (2 * π) • circleAverage h z (-r) := by
    rw [circleAverage_def, smul_smul]
    rw [mul_inv_cancel₀ (by positivity : (2 * π : ℝ) ≠ 0), one_smul]
  rw [this, hcavg]
  simp [Complex.real_smul]







end

end BookProof.RadialMollifier
