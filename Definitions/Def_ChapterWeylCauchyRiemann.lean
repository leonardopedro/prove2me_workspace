import Definitions.Def_ChapterRadialMollifier
import Mathlib


/-!
# Weyl's lemma for the Cauchy–Riemann operator — the *Holomorphic fields* remark

`book.tex`, section *"Holomorphic fields"* (line ~4105), states:

> *"Note that if a complex function of complex variable is locally integrable in
> an open domain, and satisfies the Cauchy–Riemann equations weakly, then the
> function agrees almost everywhere with an analytic function in such open
> domain."*

`BookProof/ChapterHolomorphic.lean` formalizes the classical (pointwise
derivative) core and the Morera form for *continuous* functions, and records the
distributional statement above as its remaining boundary.  This file closes that
boundary.

* `dbar φ z` — the (unnormalized) Cauchy–Riemann operator `∂φ/∂x + i ∂φ/∂y` of a
  real-differentiable function, and `dbarR` for a real-valued function;
* `WeakCauchyRiemannOn f U` — `f` satisfies the Cauchy–Riemann equations *weakly*
  on `U`: `∫ f · ∂̄φ = 0` for every smooth `φ` compactly supported in `U`;
* `weak_cauchyRiemann_ae_eq_analytic` — **the book's statement**: a function
  locally integrable on an open set `U` and weakly Cauchy–Riemann there agrees
  almost everywhere on `U` with a function analytic on `U`;
* `weakCauchyRiemannOn_of_analyticOn` — the converse: a function analytic on `U`
  is weakly Cauchy–Riemann there;
* `weak_cauchyRiemann_iff_ae_eq_analytic` — the two together, as an
  `iff` characterization of the locally integrable weak solutions of `∂̄f = 0`.

The proof is the classical mollification argument.  Convolving (a truncation of)
`f` with any smooth compactly supported kernel produces a smooth function whose
`∂̄` vanishes — the weak equation applied to the reflected kernel — hence a
holomorphic function.  Mathlib's Lebesgue-differentiation theorem for bump
functions (`ContDiffBump.ae_convolution_tendsto_right_of_locallyIntegrable`)
makes the bump mollifications converge to `f` almost everywhere, while the
*radial* mollifier of `BookProof/ChapterRadialMollifier.lean` reproduces
holomorphic functions exactly (disc mean value property).  Comparing the two
families identifies the almost-everywhere limit with one fixed holomorphic
mollification.
-/

namespace BookProof.WeylCauchyRiemann

open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

/-- The (unnormalized) Cauchy–Riemann operator `∂̄φ = ∂φ/∂x + i ∂φ/∂y`, written
with the real Fréchet derivative of `φ`. A real-differentiable `φ` is complex
differentiable at `z` exactly when `dbar φ z = 0`. -/
def dbar (φ : ℂ → ℂ) (z : ℂ) : ℂ := fderiv ℝ φ z 1 + Complex.I * fderiv ℝ φ z Complex.I

/-- The Cauchy–Riemann operator applied to a real-valued function. -/
def dbarR (χ : ℂ → ℝ) (z : ℂ) : ℂ :=
  ((fderiv ℝ χ z 1 : ℝ) : ℂ) + Complex.I * ((fderiv ℝ χ z Complex.I : ℝ) : ℂ)

/-- `f` satisfies the Cauchy–Riemann equations **weakly** (in the distributional
sense) on the open set `U`: its pairing with `∂̄φ` vanishes for every smooth test
function `φ` compactly supported inside `U`. -/
def WeakCauchyRiemannOn (f : ℂ → ℂ) (U : Set ℂ) : Prop :=
  ∀ φ : ℂ → ℂ, ContDiff ℝ ∞ φ → HasCompactSupport φ → tsupport φ ⊆ U →
    ∫ z : ℂ, f z * dbar φ z = 0

/-- Mollification: convolution of `F` with a real kernel `χ`. -/
def mollify (F : ℂ → ℂ) (χ : ℂ → ℝ) : ℂ → ℂ := fun z => ∫ w : ℂ, (χ (z - w) : ℂ) * F w



















/-- The bump family used to extract almost-everywhere convergence. -/
def bumpSeq (n : ℕ) : ContDiffBump (0 : ℂ) where
  rIn := 1 / (n + 2)
  rOut := 2 / (n + 2)
  rIn_pos := by positivity
  rIn_lt_rOut := by
    have h : (0 : ℝ) < (n : ℝ) + 2 := by positivity
    rw [div_lt_div_iff_of_pos_right h]
    norm_num




















/-! ## The converse: an analytic function is weakly Cauchy–Riemann

The remaining half of the characterization.  For a smooth compactly supported
`ψ` the integral of `∂̄ψ` over the plane vanishes (Fubini and the fundamental
theorem of calculus in each of the two real directions); applying this to
`ψ = g · φ`, with `g` analytic on `U` and `φ` a test function supported in `U`,
gives the weak Cauchy–Riemann equation for `g`.
-/































the (unnormalized) Cauchy–Riemann operator `∂φ/∂x + i ∂φ/∂y` of a
  real-differentiable function, and `dbarR` for a real-valued function;
* `WeakCauchyRiemannOn f U` — `f` satisfies the Cauchy–Riemann equations *weakly*
  on `U`: `∫ f · ∂̄φ = 0` for every smooth `φ` compactly supported in `U`;
* `weak_cauchyRiemann_ae_eq_analytic` — **the book's statement**: a function
  locally integrable on an open set `U` and weakly Cauchy–Riemann there agrees
  almost everywhere on `U` with a function analytic on `U`;
* `weakCauchyRiemannOn_of_analyticOn` — the converse: a function analytic on `U`
  is weakly Cauchy–Riemann there;
* `weak_cauchyRiemann_iff_ae_eq_analytic` — the two together, as an
  `iff` characterization of the locally integrable weak solutions of `∂̄f = 0`.

The proof is the classical mollification argument.  Convolving (a truncation of)
`f` with any smooth compactly supported kernel produces a smooth function whose
`∂̄` vanishes — the weak equation applied to the reflected kernel — hence a
holomorphic function.  Mathlib's Lebesgue-differentiation theorem for bump
functions (`ContDiffBump.ae_convolution_tendsto_right_of_locallyIntegrable`)
makes the bump mollifications converge to `f` almost everywhere, while the
*radial* mollifier of `BookProof/ChapterRadialMollifier.lean` reproduces
holomorphic functions exactly (disc mean value property).  Comparing the two
families identifies the almost-everywhere limit with one fixed holomorphic
mollification.
-/

namespace BookProof.WeylCauchyRiemann

open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

/-- The (unnormalized) Cauchy–Riemann operator `∂̄φ = ∂φ/∂x + i ∂φ/∂y`, written
with the real Fréchet derivative of `φ`. A real-differentiable `φ` is complex
differentiable at `z` exactly when `dbar φ z = 0`. -/
def dbar (φ : ℂ → ℂ) (z : ℂ) : ℂ := fderiv ℝ φ z 1 + Complex.I * fderiv ℝ φ z Complex.I

/-- The Cauchy–Riemann operator applied to a real-valued function. -/
def dbarR (χ : ℂ → ℝ) (z : ℂ) : ℂ :=
  ((fderiv ℝ χ z 1 : ℝ) : ℂ) + Complex.I * ((fderiv ℝ χ z Complex.I : ℝ) : ℂ)

/-- `f` satisfies the Cauchy–Riemann equations **weakly** (in the distributional
sense) on the open set `U`: its pairing with `∂̄φ` vanishes for every smooth test
function `φ` compactly supported inside `U`. -/
def WeakCauchyRiemannOn (f : ℂ → ℂ) (U : Set ℂ) : Prop :=
  ∀ φ : ℂ → ℂ, ContDiff ℝ ∞ φ → HasCompactSupport φ → tsupport φ ⊆ U →
    ∫ z : ℂ, f z * dbar φ z = 0

/-- Mollification: convolution of `F` with a real kernel `χ`. -/
def mollify (F : ℂ → ℂ) (χ : ℂ → ℝ) : ℂ → ℂ := fun z => ∫ w : ℂ, (χ (z - w) : ℂ) * F w

theorem mollify_eq_convolution_left (F : ℂ → ℂ) (χ : ℂ → ℝ) :
    mollify F χ = χ ⋆[ContinuousLinearMap.lsmul ℝ ℝ, volume] F := by
  funext z
  rw [convolution_eq_swap]
  simp [mollify, Complex.real_smul]

theorem mollify_eq_convolution_right (F : ℂ → ℂ) (χ : ℂ → ℝ) :
    mollify F χ = F ⋆[(ContinuousLinearMap.lsmul ℝ ℝ).flip, volume] χ := by
  rw [mollify_eq_convolution_left, convolution_flip]

/-- A smooth function with vanishing `∂̄` on an open set is analytic there:
the translation of `BookProof.ChapterHolomorphic.cauchyRiemann_analyticOn` into
the `dbar` notation. -/
theorem analyticOn_of_dbar_eq_zero {g : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hg : ∀ z ∈ s, DifferentiableAt ℝ g z) (hdbar : ∀ z ∈ s, dbar g z = 0) :
    AnalyticOn ℂ g s := by
  refine BookProof.ChapterHolomorphic.cauchyRiemann_analyticOn hs hg fun z hz => ?_
  have h := hdbar z hz
  simp only [dbar] at h
  have hI : fderiv ℝ g z Complex.I = Complex.I * fderiv ℝ g z 1 := by
    linear_combination (-Complex.I) * h + (fderiv ℝ g z Complex.I) * Complex.I_sq
  simpa [smul_eq_mul] using hI

/-- Mollification of a locally integrable function by a smooth compactly
supported kernel is smooth. -/
theorem mollify_contDiff {F : ℂ → ℂ} (hF : LocallyIntegrable F) {χ : ℂ → ℝ}
    (hχ : ContDiff ℝ ∞ χ) (hχc : HasCompactSupport χ) :
    ContDiff ℝ ∞ (mollify F χ) := by
  rw [mollify_eq_convolution_right]
  exact hχc.contDiff_convolution_right _ hF hχ

/-- Reflecting the argument flips the sign of `∂̄`. -/
theorem dbar_ofReal_comp_sub {χ : ℂ → ℝ} (hχ : ContDiff ℝ ∞ χ) (z w : ℂ) :
    dbar (fun v => ((χ (z - v) : ℝ) : ℂ)) w = -dbarR χ (z - w) := by
  have hdiff : Differentiable ℝ χ := hχ.differentiable (by simp)
  have h1 : HasFDerivAt (fun v : ℂ => z - v) (-ContinuousLinearMap.id ℝ ℂ) w := by
    simpa using (hasFDerivAt_id (𝕜 := ℝ) w).const_sub z
  have h2 : HasFDerivAt χ (fderiv ℝ χ (z - w)) (z - w) := (hdiff (z - w)).hasFDerivAt
  have h3 : HasFDerivAt (fun v : ℂ => ((χ (z - v) : ℝ) : ℂ))
      (Complex.ofRealCLM.comp ((fderiv ℝ χ (z - w)).comp (-ContinuousLinearMap.id ℝ ℂ))) w :=
    (Complex.ofRealCLM.hasFDerivAt).comp w (h2.comp w h1)
  rw [dbar, h3.fderiv, dbarR]
  simp
  ring

/-- The `∂̄` of a mollification is the mollification of `F` by the `∂̄` of the
kernel: the derivative falls on the smooth factor. -/
theorem dbar_mollify {F : ℂ → ℂ} (hF : LocallyIntegrable F) {χ : ℂ → ℝ}
    (hχ : ContDiff ℝ ∞ χ) (hχc : HasCompactSupport χ) (z : ℂ) :
    dbar (mollify F χ) z = ∫ w : ℂ, dbarR χ (z - w) * F w := by
  set L : ℂ →L[ℝ] ℝ →L[ℝ] ℂ := (ContinuousLinearMap.lsmul ℝ ℝ).flip with hLdef
  have hχ1 : ContDiff ℝ 1 χ := hχ.of_le (by simp)
  have hfd : HasFDerivAt (mollify F χ) ((F ⋆[L.precompR ℂ, volume] fderiv ℝ χ) z) z := by
    rw [mollify_eq_convolution_right]
    exact hχc.hasFDerivAt_convolution_right L hF hχ1 z
  have hcfd : HasCompactSupport (fderiv ℝ χ) := hχc.fderiv ℝ
  have hcontfd : Continuous (fderiv ℝ χ) := hχ.continuous_fderiv (by simp)
  have happ : ∀ v : ℂ, fderiv ℝ (mollify F χ) z v
      = ∫ w : ℂ, ((fderiv ℝ χ (z - w) v : ℝ) : ℂ) * F w := by
    intro v
    rw [hfd.fderiv, convolution_precompR_apply L hF hcfd hcontfd z v]
    simp [convolution_def, hLdef, Complex.real_smul]
  have hint : ∀ v : ℂ, Integrable (fun w : ℂ => ((fderiv ℝ χ (z - w) v : ℝ) : ℂ) * F w) := by
    intro v
    have hcs : HasCompactSupport (fun a : ℂ => (fderiv ℝ χ a v : ℝ)) :=
      hcfd.comp_left (g := fun T : ℂ →L[ℝ] ℝ => T v) (by simp)
    have hcont : Continuous (fun a : ℂ => (fderiv ℝ χ a v : ℝ)) :=
      hcontfd.clm_apply continuous_const
    have hthis := hcs.convolutionExists_right L hF hcont z
    rw [ConvolutionExistsAt] at hthis
    simpa [hLdef, Complex.real_smul] using hthis
  rw [dbar, happ 1, happ Complex.I, ← MeasureTheory.integral_const_mul,
    ← integral_add (hint 1) ((hint Complex.I).const_mul _)]
  congr 1
  funext w
  simp only [dbarR]
  ring

/-- **Mollification is holomorphic.**  If `f` is weakly Cauchy–Riemann on `U`,
`K = closedBall c R ⊆ U`, and `χ` is a smooth kernel supported in `ball 0 δ`,
then the mollification of the truncation `F = 1_K · f` is analytic on every ball
`ball c r` with `r + δ ≤ R`. -/
theorem mollify_analyticOn {f : ℂ → ℂ} {U : Set ℂ}
    (hf : LocallyIntegrableOn f U) (hCR : WeakCauchyRiemannOn f U)
    {c : ℂ} {R r δ : ℝ} (hδ : 0 < δ) (hr : 0 < r) (hrR : r + δ ≤ R)
    (hKU : closedBall c R ⊆ U) {χ : ℂ → ℝ} (hχ : ContDiff ℝ ∞ χ)
    (hχc : HasCompactSupport χ) (hsupp : Function.support χ ⊆ ball (0 : ℂ) δ) :
    AnalyticOn ℂ (mollify ((closedBall c R).indicator f) χ) (ball c r) := by
  set F : ℂ → ℂ := (closedBall c R).indicator f with hFdef
  have hRpos : 0 < R := by linarith
  have hFint : Integrable F := by
    rw [hFdef]
    exact (integrable_indicator_iff measurableSet_closedBall).2
      (hf.integrableOn_compact_subset hKU (isCompact_closedBall c R))
  have hFloc : LocallyIntegrable F := hFint.locallyIntegrable
  have hsmooth : ContDiff ℝ ∞ (mollify F χ) := mollify_contDiff hFloc hχ hχc
  have htsupp : tsupport χ ⊆ closedBall (0 : ℂ) δ :=
    closure_minimal (hsupp.trans ball_subset_closedBall) isClosed_closedBall
  refine analyticOn_of_dbar_eq_zero isOpen_ball
    (fun z _ => (hsmooth.differentiable (by simp)) z) ?_
  intro z hz
  have hzc : ‖z - c‖ < r := by
    simpa [Complex.dist_eq] using mem_ball.1 hz
  -- the reflected kernel is a legitimate test function
  set φ : ℂ → ℂ := fun v => ((χ (z - v) : ℝ) : ℂ) with hφdef
  have hφsmooth : ContDiff ℝ ∞ φ :=
    Complex.ofRealCLM.contDiff.comp (hχ.comp (contDiff_const.sub contDiff_id))
  have hφsupp : Function.support φ ⊆ closedBall z δ := by
    intro v hv
    simp only [hφdef, Function.mem_support, ne_eq, Complex.ofReal_eq_zero] at hv
    have : z - v ∈ ball (0 : ℂ) δ := hsupp hv
    simp only [mem_ball, dist_zero_right] at this
    simp only [mem_closedBall, Complex.dist_eq]
    rw [← norm_neg]
    simpa using this.le
  have hφc : HasCompactSupport φ :=
    HasCompactSupport.of_support_subset_isCompact (isCompact_closedBall z δ) hφsupp
  have hφU : tsupport φ ⊆ U := by
    refine subset_trans (closure_minimal hφsupp isClosed_closedBall) (subset_trans ?_ hKU)
    intro v hv
    simp only [mem_closedBall, Complex.dist_eq] at hv ⊢
    calc ‖v - c‖ = ‖(v - z) + (z - c)‖ := by ring_nf
      _ ≤ ‖v - z‖ + ‖z - c‖ := norm_add_le _ _
      _ ≤ δ + ‖z - c‖ := by
          have : ‖v - z‖ = ‖z - v‖ := by rw [← norm_neg]; ring_nf
          rw [this]; linarith [hv]
      _ ≤ R := by linarith
  have hweak := hCR φ hφsmooth hφc hφU
  -- rewrite the weak equation as the vanishing of the mollified `∂̄`
  have hdb : ∀ w : ℂ, dbar φ w = -dbarR χ (z - w) := fun w =>
    dbar_ofReal_comp_sub hχ z w
  have hzero : ∫ w : ℂ, dbarR χ (z - w) * f w = 0 := by
    have : ∫ w : ℂ, f w * dbar φ w = -∫ w : ℂ, dbarR χ (z - w) * f w := by
      rw [← MeasureTheory.integral_neg]
      congr 1
      funext w
      rw [hdb w]
      ring
    rw [this] at hweak
    exact neg_eq_zero.1 hweak
  have hFf : ∀ w : ℂ, dbarR χ (z - w) * F w = dbarR χ (z - w) * f w := by
    intro w
    by_cases hd : dbarR χ (z - w) = 0
    · simp [hd]
    · have hsupp' : z - w ∈ tsupport χ := by
        by_contra hcon
        have hz0 : fderiv ℝ χ (z - w) = 0 := by
          have := support_fderiv_subset (𝕜 := ℝ) (f := χ)
          by_contra hne
          exact hcon (this (by simpa [Function.mem_support] using hne))
        apply hd
        simp [dbarR, hz0]
      have hwmem : w ∈ closedBall c R := by
        have h1 : ‖z - w‖ ≤ δ := by
          have := htsupp hsupp'
          simpa [mem_closedBall, dist_zero_right] using this
        simp only [mem_closedBall, Complex.dist_eq]
        calc ‖w - c‖ = ‖-(z - w) + (z - c)‖ := by ring_nf
          _ ≤ ‖-(z - w)‖ + ‖z - c‖ := norm_add_le _ _
          _ ≤ δ + ‖z - c‖ := by rw [norm_neg]; linarith
          _ ≤ R := by linarith
      rw [hFdef, Set.indicator_of_mem hwmem]
  rw [dbar_mollify hFloc hχ hχc z]
  calc ∫ w : ℂ, dbarR χ (z - w) * F w
      = ∫ w : ℂ, dbarR χ (z - w) * f w := by
        congr 1
        funext w
        exact hFf w
    _ = 0 := hzero

/-- Mollifications commute: mollifying by `χ₁` and then by `χ₂` is the same as
mollifying by `χ₂` and then by `χ₁`. -/
theorem mollify_comm {F : ℂ → ℂ} (hF : Integrable F) {χ₁ χ₂ : ℂ → ℝ}
    (hχ₁ : Continuous χ₁) (hχ₁c : HasCompactSupport χ₁)
    (hχ₂ : Continuous χ₂) (hχ₂c : HasCompactSupport χ₂) :
    mollify (mollify F χ₁) χ₂ = mollify (mollify F χ₂) χ₁ := by
  have hprod : ∀ (a b : ℂ → ℝ), Continuous a → HasCompactSupport a → Continuous b →
      HasCompactSupport b → ∀ z : ℂ, Integrable
        (fun p : ℂ × ℂ => ((b (z - p.1) : ℂ) * (a (p.1 - p.2) : ℂ)) * F p.2)
        (volume.prod volume) := by
    intro a b ha hac hb hbc z
    obtain ⟨Ma, hMa⟩ := ha.bounded_above_of_compact_support hac
    obtain ⟨Mb, hMb⟩ := hb.bounded_above_of_compact_support hbc
    have hMa0 : 0 ≤ Ma := le_trans (norm_nonneg _) (hMa 0)
    have hMb0 : 0 ≤ Mb := le_trans (norm_nonneg _) (hMb 0)
    set K : Set ℂ := (fun v : ℂ => z - v) '' (tsupport b) with hK
    have hKc : IsCompact K := hbc.isCompact.image (by fun_prop)
    have hmeasK : MeasurableSet K := hKc.isClosed.measurableSet
    have hindint : Integrable (K.indicator (fun _ : ℂ => (Mb * Ma : ℝ))) :=
      (integrable_indicator_iff hmeasK).2
        (integrableOn_const (C := Mb * Ma) (ne_of_lt hKc.measure_lt_top))
    refine Integrable.mono' (hindint.mul_prod hF.norm) ?_ ?_
    · refine AEStronglyMeasurable.mul ?_ hF.aestronglyMeasurable.comp_snd
      exact ((Complex.continuous_ofReal.comp
          (hb.comp (continuous_const.sub continuous_fst))).mul
        (Complex.continuous_ofReal.comp
          (ha.comp (continuous_fst.sub continuous_snd)))).aestronglyMeasurable
    · filter_upwards with p
      by_cases hp : p.1 ∈ K
      · rw [Set.indicator_of_mem hp]
        have hle : ‖b (z - p.1)‖ * ‖a (p.1 - p.2)‖ ≤ Mb * Ma :=
          mul_le_mul (hMb _) (hMa _) (norm_nonneg _) hMb0
        simp only [norm_mul, Complex.norm_real]
        exact mul_le_mul_of_nonneg_right hle (norm_nonneg _)
      · have hb0 : b (z - p.1) = 0 := by
          by_contra hne
          exact hp ⟨z - p.1, subset_tsupport b hne, by ring⟩
        simp only [hb0, Complex.ofReal_zero, zero_mul, norm_zero]
        exact mul_nonneg (Set.indicator_apply_nonneg fun _ => mul_nonneg hMb0 hMa0)
          (norm_nonneg _)
  funext z
  have hstep : ∀ (a b : ℂ → ℝ), Continuous a → HasCompactSupport a → Continuous b →
      HasCompactSupport b →
      mollify (mollify F a) b z
        = ∫ w : ℂ, ∫ v : ℂ, ((b (z - v) : ℂ) * (a (v - w) : ℂ)) * F w := by
    intro a b ha hac hb hbc
    have h1 : mollify (mollify F a) b z
        = ∫ v : ℂ, ∫ w : ℂ, ((b (z - v) : ℂ) * (a (v - w) : ℂ)) * F w := by
      simp only [mollify]
      congr 1
      funext v
      rw [← MeasureTheory.integral_const_mul]
      congr 1
      funext w
      ring
    rw [h1, integral_integral_swap (hprod a b ha hac hb hbc z)]
  rw [hstep χ₁ χ₂ hχ₁ hχ₁c hχ₂ hχ₂c, hstep χ₂ χ₁ hχ₂ hχ₂c hχ₁ hχ₁c]
  congr 1
  funext w
  have := integral_sub_left_eq_self
    (fun v : ℂ => ((χ₂ (z - v) : ℂ) * (χ₁ (v - w) : ℂ)) * F w) volume (z + w)
  rw [← this]
  refine integral_congr_ae (Eventually.of_forall fun v => ?_)
  simp only
  rw [show z - (z + w - v) = v - w by ring, show z + w - v - w = z - v by ring]
  ring

/-- The radial mollifier reproduces a holomorphic function (disc mean value
property), in the `mollify` notation. -/
theorem mollify_moll_eq_self {h : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hh : DifferentiableOn ℂ h s) (hcont : Continuous h) {δ : ℝ} (hδ : 0 < δ) {z : ℂ}
    (hz : closedBall z δ ⊆ s) : mollify h (moll δ) z = h z :=
  integral_moll_eq_self_of_analytic hs hh hcont hδ hz

/-- The bump family used to extract almost-everywhere convergence. -/
def bumpSeq (n : ℕ) : ContDiffBump (0 : ℂ) where
  rIn := 1 / (n + 2)
  rOut := 2 / (n + 2)
  rIn_pos := by positivity
  rIn_lt_rOut := by
    have h : (0 : ℝ) < (n : ℝ) + 2 := by positivity
    rw [div_lt_div_iff_of_pos_right h]
    norm_num

theorem bumpSeq_rOut_tendsto : Tendsto (fun n => (bumpSeq n).rOut) atTop (nhds 0) := by
  have h : Tendsto (fun n : ℕ => ((n : ℝ) + 2)) atTop atTop :=
    tendsto_atTop_add_const_right _ 2 tendsto_natCast_atTop_atTop
  simpa [bumpSeq] using tendsto_const_nhds.div_atTop (f := fun _ : ℕ => (2 : ℝ)) h

theorem bumpSeq_rOut_le (n : ℕ) : (bumpSeq n).rOut ≤ 2 * (bumpSeq n).rIn := by
  simp only [bumpSeq]
  rw [mul_one_div]

theorem bumpSeq_support (n : ℕ) :
    Function.support ((bumpSeq n).normed volume) ⊆ ball (0 : ℂ) ((bumpSeq n).rOut) :=
  (bumpSeq n).support_normed_eq.subset

theorem bumpSeq_contDiff (n : ℕ) : ContDiff ℝ ∞ ((bumpSeq n).normed volume) :=
  (bumpSeq n).contDiff_normed

theorem bumpSeq_hasCompactSupport (n : ℕ) :
    HasCompactSupport ((bumpSeq n).normed volume) := (bumpSeq n).hasCompactSupport_normed

/-- Almost-everywhere convergence of the bump mollifications of a locally
integrable function (Mathlib's Lebesgue differentiation theorem for bumps). -/
theorem ae_tendsto_mollify_bump {F : ℂ → ℂ} (hF : LocallyIntegrable F) :
    ∀ᵐ z : ℂ, Tendsto (fun n => mollify F ((bumpSeq n).normed volume) z) atTop (nhds (F z)) := by
  have := ContDiffBump.ae_convolution_tendsto_right_of_locallyIntegrable
    (φ := bumpSeq) (l := atTop) (K := 2) bumpSeq_rOut_tendsto
    (Eventually.of_forall bumpSeq_rOut_le) hF
  filter_upwards [this] with z hz
  simpa only [mollify_eq_convolution_left] using hz

/-- Pointwise convergence of the bump mollifications of a continuous function. -/
theorem tendsto_mollify_bump_of_continuous {h : ℂ → ℂ} (hh : Continuous h) (z : ℂ) :
    Tendsto (fun n => mollify h ((bumpSeq n).normed volume) z) atTop (nhds (h z)) := by
  simpa only [mollify_eq_convolution_left] using
    ContDiffBump.convolution_tendsto_right_of_continuous (φ := bumpSeq) (l := atTop)
      bumpSeq_rOut_tendsto hh z

/-- **Weyl's lemma for `∂̄`, local form.**  On a ball whose closure lies in `U`,
a weakly Cauchy–Riemann locally integrable function agrees almost everywhere
with an analytic function. -/
theorem exists_analyticOn_ae_eq_ball {f : ℂ → ℂ} {U : Set ℂ}
    (hf : LocallyIntegrableOn f U) (hCR : WeakCauchyRiemannOn f U)
    {c : ℂ} {R : ℝ} (hR : 0 < R) (hKU : closedBall c R ⊆ U) :
    ∃ g : ℂ → ℂ, AnalyticOn ℂ g (ball c (R / 4)) ∧
      ∀ᵐ z : ℂ, z ∈ ball c (R / 4) → f z = g z := by
  set δ : ℝ := R / 4 with hδdef
  have hδ : 0 < δ := by positivity
  set F : ℂ → ℂ := (closedBall c R).indicator f with hFdef
  have hFint : Integrable F := by
    rw [hFdef]
    exact (integrable_indicator_iff measurableSet_closedBall).2
      (hf.integrableOn_compact_subset hKU (isCompact_closedBall c R))
  have hFloc : LocallyIntegrable F := hFint.locallyIntegrable
  set h : ℂ → ℂ := mollify F (moll δ) with hhdef
  have hsmooth : ContDiff ℝ ∞ h :=
    mollify_contDiff hFloc (moll_contDiff δ) (moll_hasCompactSupport hδ)
  have hcont : Continuous h := hsmooth.continuous
  have hana : AnalyticOn ℂ h (ball c (R / 2)) :=
    mollify_analyticOn hf hCR hδ (by positivity) (by linarith) hKU
      (moll_contDiff δ) (moll_hasCompactSupport hδ) (moll_support_subset hδ)
  refine ⟨h, hana.mono (ball_subset_ball (by linarith)), ?_⟩
  -- the bump mollifications are holomorphic too, for small radii
  have hev : ∀ᶠ n in atTop, (bumpSeq n).rOut < δ :=
    Filter.Tendsto.eventually_lt_const hδ bumpSeq_rOut_tendsto
  have hbana : ∀ n, (bumpSeq n).rOut < δ →
      AnalyticOn ℂ (mollify F ((bumpSeq n).normed volume)) (ball c (R / 2)) := by
    intro n hn
    refine mollify_analyticOn hf hCR hδ (by positivity) (by linarith) hKU
      (bumpSeq_contDiff n) (bumpSeq_hasCompactSupport n) ?_
    exact (bumpSeq_support n).trans (ball_subset_ball hn.le)
  -- for small radii the two mollifications agree on the small ball
  have hkey : ∀ n, (bumpSeq n).rOut < δ → ∀ z ∈ ball c (R / 4),
      mollify F ((bumpSeq n).normed volume) z = mollify h ((bumpSeq n).normed volume) z := by
    intro n hn z hz
    have hball : closedBall z δ ⊆ ball c (R / 2) := by
      intro v hv
      have h1 : dist v z ≤ δ := mem_closedBall.1 hv
      have h2 : dist z c < R / 4 := mem_ball.1 hz
      have : dist v c < R / 2 := by
        calc dist v c ≤ dist v z + dist z c := dist_triangle _ _ _
          _ < δ + R / 4 := by linarith
          _ = R / 2 := by rw [hδdef]; ring
      exact mem_ball.2 this
    have hbcont : Continuous (mollify F ((bumpSeq n).normed volume)) :=
      (mollify_contDiff hFloc (bumpSeq_contDiff n) (bumpSeq_hasCompactSupport n)).continuous
    have h1 : mollify (mollify F ((bumpSeq n).normed volume)) (moll δ) z
        = mollify F ((bumpSeq n).normed volume) z :=
      mollify_moll_eq_self isOpen_ball ((hbana n hn).differentiableOn) hbcont hδ hball
    have h2 : mollify (mollify F ((bumpSeq n).normed volume)) (moll δ)
        = mollify (mollify F (moll δ)) ((bumpSeq n).normed volume) :=
      mollify_comm hFint (bumpSeq_contDiff n).continuous (bumpSeq_hasCompactSupport n)
        (moll_continuous δ) (moll_hasCompactSupport hδ)
    rw [← h1, h2, hhdef]
  -- pass to the limit
  filter_upwards [ae_tendsto_mollify_bump hFloc] with z hzlim hzmem
  have hlim2 : Tendsto (fun n => mollify h ((bumpSeq n).normed volume) z) atTop (nhds (h z)) :=
    tendsto_mollify_bump_of_continuous hcont z
  have hlim1 : Tendsto (fun n => mollify F ((bumpSeq n).normed volume) z) atTop (nhds (h z)) := by
    refine hlim2.congr' ?_
    filter_upwards [hev] with n hn
    exact (hkey n hn z hzmem).symm
  have hFz : F z = h z := tendsto_nhds_unique hzlim hlim1
  have hzin : z ∈ closedBall c R := by
    have : dist z c < R / 4 := mem_ball.1 hzmem
    exact mem_closedBall.2 (by linarith)
  rwa [hFdef, Set.indicator_of_mem hzin] at hFz

/-- **Weyl's lemma for `∂̄` — the book's statement.**  A function locally
integrable on an open set `U` of the complex plane, satisfying the
Cauchy–Riemann equations in the weak (distributional) sense on `U`, agrees
almost everywhere on `U` with a function analytic on `U`. -/
theorem weak_cauchyRiemann_ae_eq_analytic {f : ℂ → ℂ} {U : Set ℂ} (hU : IsOpen U)
    (hf : LocallyIntegrableOn f U) (hCR : WeakCauchyRiemannOn f U) :
    ∃ g : ℂ → ℂ, AnalyticOn ℂ g U ∧ ∀ᵐ z : ℂ, z ∈ U → f z = g z := by
  classical
  -- a local analytic representative around every point of `U`
  have hloc : ∀ c ∈ U, ∃ (ρ : ℝ) (gc : ℂ → ℂ), 0 < ρ ∧ ball c ρ ⊆ U ∧
      AnalyticOn ℂ gc (ball c ρ) ∧ ∀ᵐ z : ℂ, z ∈ ball c ρ → f z = gc z := by
    intro c hc
    obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.1 hU c hc
    have hsub : closedBall c (ε / 2) ⊆ U :=
      (closedBall_subset_ball (by linarith)).trans hball
    obtain ⟨gc, hgc, hae⟩ :=
      exists_analyticOn_ae_eq_ball hf hCR (by linarith : (0 : ℝ) < ε / 2) hsub
    exact ⟨ε / 2 / 4, gc, by linarith, (ball_subset_ball (by linarith)).trans hball, hgc, hae⟩
  choose! ρ gc hρ hballU hana hae using hloc
  -- the local representatives agree on overlaps
  have hagree : ∀ c ∈ U, ∀ z ∈ U, EqOn (gc c) (gc z) (ball c (ρ c) ∩ ball z (ρ z)) := by
    intro c hc z hz
    have hopen : IsOpen (ball c (ρ c) ∩ ball z (ρ z)) := isOpen_ball.inter isOpen_ball
    refine MeasureTheory.Measure.eqOn_open_of_ae_eq (μ := volume) ?_ hopen
      (((hana c hc).continuousOn).mono inter_subset_left)
      (((hana z hz).continuousOn).mono inter_subset_right)
    rw [Filter.EventuallyEq, ae_restrict_iff' hopen.measurableSet]
    filter_upwards [hae c hc, hae z hz] with w h1 h2 hw
    rw [← h1 hw.1, ← h2 hw.2]
  set G : ℂ → ℂ := fun z => gc z z with hGdef
  have hGloc : ∀ c ∈ U, ∀ w ∈ ball c (ρ c), G w = gc c w := by
    intro c hc w hw
    have hwU : w ∈ U := hballU c hc hw
    exact (hagree c hc w hwU ⟨hw, mem_ball_self (hρ w hwU)⟩).symm
  refine ⟨G, ?_, ?_⟩
  · rw [hU.analyticOn_iff_analyticOnNhd]
    intro c hc
    have hEq : EqOn G (gc c) (ball c (ρ c)) := fun w hw => hGloc c hc w hw
    have hAt : AnalyticAt ℂ (gc c) c :=
      ((isOpen_ball.analyticOn_iff_analyticOnNhd).1 (hana c hc)) c (mem_ball_self (hρ c hc))
    exact hAt.congr (Filter.eventuallyEq_of_mem (isOpen_ball.mem_nhds (mem_ball_self (hρ c hc)))
      hEq).symm
  · -- a countable subcover makes the exceptional set null
    obtain ⟨T, hTU, hTc, hTeq⟩ :=
      TopologicalSpace.isOpen_biUnion_countable U (fun c => ball c (ρ c))
        (fun c _ => isOpen_ball)
    have hcover : U ⊆ ⋃ c ∈ T, ball c (ρ c) := by
      rw [hTeq]
      intro z hz
      exact mem_biUnion hz (mem_ball_self (hρ z hz))
    rw [ae_iff]
    have hsubset : {z : ℂ | ¬(z ∈ U → f z = G z)} ⊆
        ⋃ c ∈ T, {z : ℂ | ¬(z ∈ ball c (ρ c) → f z = gc c z)} := by
      intro z hz
      simp only [mem_setOf_eq, Classical.not_imp] at hz
      obtain ⟨hzU, hzne⟩ := hz
      obtain ⟨c, hcT, hzc⟩ := mem_iUnion₂.1 (hcover hzU)
      refine mem_iUnion₂.2 ⟨c, hcT, ?_⟩
      simp only [mem_setOf_eq, Classical.not_imp]
      exact ⟨hzc, fun hcon => hzne (by rw [hGloc c (hTU hcT) z hzc]; exact hcon)⟩
    exact measure_mono_null hsubset
      ((measure_biUnion_null_iff hTc).2 fun c hc => ae_iff.1 (hae c (hTU hc)))


/-! ## The converse: an analytic function is weakly Cauchy–Riemann

The remaining half of the characterization.  For a smooth compactly supported
`ψ` the integral of `∂̄ψ` over the plane vanishes (Fubini and the fundamental
theorem of calculus in each of the two real directions); applying this to
`ψ = g · φ`, with `g` analytic on `U` and `φ` a test function supported in `U`,
gives the weak Cauchy–Riemann equation for `g`.
-/

/-- The integral of the derivative of a compactly supported `C¹` function vanishes. -/
theorem integral_deriv_eq_zero_of_hasCompactSupport {u : ℝ → ℂ} (hu : ContDiff ℝ 1 u)
    (huc : HasCompactSupport u) : ∫ t : ℝ, deriv u t = 0 := by
  have hcd : Continuous (deriv u) := hu.continuous_deriv le_rfl
  have hint : Integrable (deriv u) :=
    hcd.integrable_of_hasCompactSupport (huc.deriv)
  have h1 : ∫ x in Iic (0 : ℝ), deriv u x = u 0 :=
    HasCompactSupport.integral_Iic_deriv_eq hu huc 0
  have h2 : ∫ x in Ioi (0 : ℝ), deriv u x = -u 0 :=
    HasCompactSupport.integral_Ioi_deriv_eq hu huc 0
  have h3 := intervalIntegral.integral_Iic_add_Ioi (μ := volume) (f := deriv u) (b := (0 : ℝ))
    hint.integrableOn hint.integrableOn
  rw [h1, h2] at h3
  simpa using h3.symm

/-- Transfer of an integral over `ℂ` to an integral over `ℝ × ℝ`. -/
theorem integral_complex_eq_prod (G : ℂ → ℂ) :
    ∫ z : ℂ, G z = ∫ p : ℝ × ℝ, G (p.1 + p.2 * Complex.I) := by
  rw [← (Complex.volume_preserving_equiv_real_prod.symm).integral_comp
    Complex.measurableEquivRealProd.symm.measurableEmbedding G]
  refine integral_congr_ae (Eventually.of_forall fun p => ?_)
  simp only
  congr 1
  rw [Complex.measurableEquivRealProd_symm_apply]
  apply Complex.ext <;> simp

theorem hasCompactSupport_slice_im {ψ : ℂ → ℂ} (hψc : HasCompactSupport ψ) (x : ℝ) :
    HasCompactSupport (fun t : ℝ => ψ ((x : ℂ) + t * Complex.I)) := by
  obtain ⟨M, hM⟩ := hψc.isCompact.isBounded.subset_closedBall 0
  refine HasCompactSupport.of_support_subset_isCompact (isCompact_Icc (a := -M) (b := M)) ?_
  intro t ht
  have hmem : (x : ℂ) + t * Complex.I ∈ tsupport ψ := subset_tsupport ψ ht
  have := hM hmem
  simp only [mem_closedBall, dist_zero_right] at this
  have himle : |t| ≤ ‖(x : ℂ) + t * Complex.I‖ := by
    have : ((x : ℂ) + t * Complex.I).im = t := by simp
    calc |t| = |((x : ℂ) + t * Complex.I).im| := by rw [this]
      _ ≤ ‖(x : ℂ) + t * Complex.I‖ := Complex.abs_im_le_norm _
  rw [mem_Icc]
  constructor <;> [linarith [abs_le.1 (le_trans himle this) |>.1];
    linarith [abs_le.1 (le_trans himle this) |>.2]]

theorem hasCompactSupport_slice_re {ψ : ℂ → ℂ} (hψc : HasCompactSupport ψ) (y : ℝ) :
    HasCompactSupport (fun t : ℝ => ψ ((t : ℂ) + y * Complex.I)) := by
  obtain ⟨M, hM⟩ := hψc.isCompact.isBounded.subset_closedBall 0
  refine HasCompactSupport.of_support_subset_isCompact (isCompact_Icc (a := -M) (b := M)) ?_
  intro t ht
  have hmem : (t : ℂ) + y * Complex.I ∈ tsupport ψ := subset_tsupport ψ ht
  have := hM hmem
  simp only [mem_closedBall, dist_zero_right] at this
  have hrele : |t| ≤ ‖(t : ℂ) + y * Complex.I‖ := by
    have hre : ((t : ℂ) + y * Complex.I).re = t := by simp
    calc |t| = |((t : ℂ) + y * Complex.I).re| := by rw [hre]
      _ ≤ ‖(t : ℂ) + y * Complex.I‖ := Complex.abs_re_le_norm _
  rw [mem_Icc]
  constructor <;> [linarith [abs_le.1 (le_trans hrele this) |>.1];
    linarith [abs_le.1 (le_trans hrele this) |>.2]]

theorem hasCompactSupport_comp_realProd {F : ℂ → ℂ} (hF : HasCompactSupport F) :
    HasCompactSupport (fun p : ℝ × ℝ => F ((p.1 : ℂ) + p.2 * Complex.I)) := by
  obtain ⟨M, hM⟩ := hF.isCompact.isBounded.subset_closedBall 0
  refine HasCompactSupport.of_support_subset_isCompact
    ((isCompact_Icc (a := -M) (b := M)).prod (isCompact_Icc (a := -M) (b := M))) ?_
  rintro ⟨x, y⟩ hxy
  have hmem : ((x : ℂ) + y * Complex.I) ∈ tsupport F := subset_tsupport F hxy
  have hb := hM hmem
  simp only [mem_closedBall, dist_zero_right] at hb
  have hx : |x| ≤ ‖(x : ℂ) + y * Complex.I‖ := by
    have hre : ((x : ℂ) + y * Complex.I).re = x := by simp
    calc |x| = |((x : ℂ) + y * Complex.I).re| := by rw [hre]
      _ ≤ _ := Complex.abs_re_le_norm _
  have hy : |y| ≤ ‖(x : ℂ) + y * Complex.I‖ := by
    have him : ((x : ℂ) + y * Complex.I).im = y := by simp
    calc |y| = |((x : ℂ) + y * Complex.I).im| := by rw [him]
      _ ≤ _ := Complex.abs_im_le_norm _
  have hx' := abs_le.1 (hx.trans hb)
  have hy' := abs_le.1 (hy.trans hb)
  exact ⟨mem_Icc.2 ⟨hx'.1, hx'.2⟩, mem_Icc.2 ⟨hy'.1, hy'.2⟩⟩

theorem deriv_slice_re {ψ : ℂ → ℂ} (hψ : Differentiable ℝ ψ) (x y : ℝ) :
    deriv (fun t : ℝ => ψ ((t : ℂ) + y * Complex.I)) x
      = fderiv ℝ ψ ((x : ℂ) + y * Complex.I) 1 := by
  have hg : HasDerivAt (fun t : ℝ => (t : ℂ) + y * Complex.I) 1 x := by
    simpa using (Complex.ofRealCLM.hasDerivAt (x := x)).add_const ((y : ℂ) * Complex.I)
  have := (hψ ((x : ℂ) + y * Complex.I)).hasFDerivAt.comp_hasDerivAt x hg
  exact this.deriv

theorem deriv_slice_im {ψ : ℂ → ℂ} (hψ : Differentiable ℝ ψ) (x y : ℝ) :
    deriv (fun t : ℝ => ψ ((x : ℂ) + t * Complex.I)) y
      = fderiv ℝ ψ ((x : ℂ) + y * Complex.I) Complex.I := by
  have hg : HasDerivAt (fun t : ℝ => (x : ℂ) + t * Complex.I) Complex.I y := by
    simpa using ((Complex.ofRealCLM.hasDerivAt (x := y)).mul_const Complex.I).const_add
      ((x : ℂ))
  have := (hψ ((x : ℂ) + y * Complex.I)).hasFDerivAt.comp_hasDerivAt y hg
  exact this.deriv

theorem hasCompactSupport_fderiv_apply {ψ : ℂ → ℂ} (hψc : HasCompactSupport ψ) (v : ℂ) :
    HasCompactSupport (fun z : ℂ => fderiv ℝ ψ z v) := by
  refine HasCompactSupport.of_support_subset_isCompact hψc.isCompact ?_
  intro z hz
  have : fderiv ℝ ψ z ≠ 0 := by
    intro h
    apply hz
    simp [h]
  exact support_fderiv_subset ℝ (f := ψ) this

theorem contDiff_slice_re (y : ℝ) : ContDiff ℝ ∞ (fun t : ℝ => (t : ℂ) + y * Complex.I) := by
  exact (Complex.ofRealCLM.contDiff).add contDiff_const

theorem contDiff_slice_im (x : ℝ) : ContDiff ℝ ∞ (fun t : ℝ => (x : ℂ) + t * Complex.I) := by
  exact contDiff_const.add ((Complex.ofRealCLM.contDiff).mul contDiff_const)

theorem integral_fderiv_one_eq_zero {ψ : ℂ → ℂ} (hψ : ContDiff ℝ ∞ ψ)
    (hψc : HasCompactSupport ψ) : ∫ z : ℂ, fderiv ℝ ψ z 1 = 0 := by
  have hdiff : Differentiable ℝ ψ := hψ.differentiable (by simp)
  have hcontF : Continuous fun z : ℂ => fderiv ℝ ψ z 1 :=
    (hψ.continuous_fderiv (by simp)).clm_apply continuous_const
  have hcsF : HasCompactSupport fun z : ℂ => fderiv ℝ ψ z 1 :=
    hasCompactSupport_fderiv_apply hψc 1
  rw [integral_complex_eq_prod]
  have hcont : Continuous fun p : ℝ × ℝ => fderiv ℝ ψ ((p.1 : ℂ) + p.2 * Complex.I) 1 :=
    hcontF.comp (by fun_prop)
  have hint : Integrable fun p : ℝ × ℝ => fderiv ℝ ψ ((p.1 : ℂ) + p.2 * Complex.I) 1 :=
    hcont.integrable_of_hasCompactSupport (hasCompactSupport_comp_realProd hcsF)
  rw [MeasureTheory.Measure.volume_eq_prod, integral_prod_symm _ hint]
  have hinner : ∀ y : ℝ, ∫ x : ℝ, fderiv ℝ ψ ((x : ℂ) + y * Complex.I) 1 = 0 := by
    intro y
    have h1 : (fun x : ℝ => fderiv ℝ ψ ((x : ℂ) + y * Complex.I) 1)
        = deriv fun t : ℝ => ψ ((t : ℂ) + y * Complex.I) := by
      funext x
      exact (deriv_slice_re hdiff x y).symm
    rw [h1]
    exact integral_deriv_eq_zero_of_hasCompactSupport
      ((hψ.comp (contDiff_slice_re y)).of_le (by simp))
      (hasCompactSupport_slice_re hψc y)
  simp [hinner]

set_option maxHeartbeats 1000000 in
-- the Fubini rewrite for the vertical slices needs more than the default budget
theorem integral_fderiv_I_eq_zero {ψ : ℂ → ℂ} (hψ : ContDiff ℝ ∞ ψ)
    (hψc : HasCompactSupport ψ) : ∫ z : ℂ, fderiv ℝ ψ z Complex.I = 0 := by
  have hdiff : Differentiable ℝ ψ := hψ.differentiable (by simp)
  have hcontF : Continuous fun z : ℂ => fderiv ℝ ψ z Complex.I :=
    (hψ.continuous_fderiv (by simp)).clm_apply continuous_const
  have hcsF : HasCompactSupport fun z : ℂ => fderiv ℝ ψ z Complex.I :=
    hasCompactSupport_fderiv_apply hψc Complex.I
  rw [integral_complex_eq_prod]
  have hcont : Continuous fun p : ℝ × ℝ => fderiv ℝ ψ ((p.1 : ℂ) + p.2 * Complex.I) Complex.I :=
    hcontF.comp (by fun_prop)
  have hint : Integrable fun p : ℝ × ℝ => fderiv ℝ ψ ((p.1 : ℂ) + p.2 * Complex.I) Complex.I :=
    hcont.integrable_of_hasCompactSupport (hasCompactSupport_comp_realProd hcsF)
  rw [MeasureTheory.Measure.volume_eq_prod, integral_prod _ hint]
  have hinner : ∀ x : ℝ, ∫ y : ℝ, fderiv ℝ ψ ((x : ℂ) + y * Complex.I) Complex.I = 0 := by
    intro x
    have h1 : (fun y : ℝ => fderiv ℝ ψ ((x : ℂ) + y * Complex.I) Complex.I)
        = deriv fun t : ℝ => ψ ((x : ℂ) + t * Complex.I) := by
      funext y
      exact (deriv_slice_im hdiff x y).symm
    rw [h1]
    exact integral_deriv_eq_zero_of_hasCompactSupport
      ((hψ.comp (contDiff_slice_im x)).of_le (by simp))
      (hasCompactSupport_slice_im hψc x)
  simp [hinner]

/-- The integral over `ℂ` of `∂̄ψ` vanishes for a smooth compactly supported `ψ`. -/
theorem integral_dbar_eq_zero {ψ : ℂ → ℂ} (hψ : ContDiff ℝ ∞ ψ)
    (hψc : HasCompactSupport ψ) : ∫ z : ℂ, dbar ψ z = 0 := by
  have h1 : Integrable fun z : ℂ => fderiv ℝ ψ z 1 :=
    ((hψ.continuous_fderiv (by simp)).clm_apply continuous_const).integrable_of_hasCompactSupport
      (hasCompactSupport_fderiv_apply hψc 1)
  have h2 : Integrable fun z : ℂ => Complex.I * fderiv ℝ ψ z Complex.I := by
    have hc : Continuous fun z : ℂ => Complex.I * fderiv ℝ ψ z Complex.I :=
      continuous_const.mul ((hψ.continuous_fderiv (by simp)).clm_apply continuous_const)
    exact hc.integrable_of_hasCompactSupport
      (hasCompactSupport_fderiv_apply hψc Complex.I).mul_left
  simp only [dbar]
  rw [integral_add h1 h2, integral_fderiv_one_eq_zero hψ hψc,
    MeasureTheory.integral_const_mul, integral_fderiv_I_eq_zero hψ hψc]
  simp

theorem dbar_eq_zero_of_differentiableAt {g : ℂ → ℂ} {z : ℂ} (h : DifferentiableAt ℂ g z) :
    dbar g z = 0 := by
  have hr := (h.hasDerivAt.hasFDerivAt).restrictScalars ℝ
  simp only [dbar, hr.fderiv, ContinuousLinearMap.coe_restrictScalars',
    ContinuousLinearMap.toSpanSingleton_apply, smul_eq_mul]
  linear_combination (deriv g z) * Complex.I_sq

theorem dbar_mul {a b : ℂ → ℂ} {z : ℂ} (ha : DifferentiableAt ℝ a z)
    (hb : DifferentiableAt ℝ b z) :
    dbar (fun w => a w * b w) z = dbar a z * b z + a z * dbar b z := by
  have he : (fun w => a w * b w) = a * b := rfl
  simp only [dbar, he, fderiv_mul ha hb, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_smul', Pi.smul_apply, smul_eq_mul]
  ring

/-- **Converse of Weyl's lemma.** A function analytic on an open set satisfies the
Cauchy–Riemann equations weakly there. -/
theorem weakCauchyRiemannOn_of_analyticOn {g : ℂ → ℂ} {U : Set ℂ} (hU : IsOpen U)
    (hg : AnalyticOn ℂ g U) : WeakCauchyRiemannOn g U := by
  classical
  intro φ hφ hφc hφU
  have hgn : AnalyticOnNhd ℂ g U := (hU.analyticOn_iff_analyticOnNhd.1 hg)
  set ψ : ℂ → ℂ := fun z => if z ∈ U then g z * φ z else 0 with hψdef
  have hUmem : ∀ z ∈ U, ψ =ᶠ[𝓝 z] fun w => g w * φ w := by
    intro z hz
    filter_upwards [hU.mem_nhds hz] with w hw
    simp [hψdef, hw]
  have hφ0 : ∀ z ∉ tsupport φ, φ =ᶠ[𝓝 z] fun _ => 0 := by
    intro z hz
    filter_upwards [(isOpen_compl_iff.2 (isClosed_tsupport φ)).mem_nhds hz] with w hw
    exact image_eq_zero_of_notMem_tsupport hw
  have hout : ∀ z ∉ tsupport φ, ψ =ᶠ[𝓝 z] fun _ => 0 := by
    intro z hz
    filter_upwards [(isOpen_compl_iff.2 (isClosed_tsupport φ)).mem_nhds hz] with w hw
    have : φ w = 0 := image_eq_zero_of_notMem_tsupport hw
    simp [hψdef, this]
  have hψsmooth : ContDiff ℝ ∞ ψ := by
    rw [contDiff_iff_contDiffAt]
    intro z
    by_cases hz : z ∈ U
    · have h1 : ContDiffAt ℝ ∞ (fun w => g w * φ w) z :=
        (((hgn z hz).contDiffAt).restrict_scalars ℝ).mul hφ.contDiffAt
      exact h1.congr_of_eventuallyEq (hUmem z hz)
    · have hz' : z ∉ tsupport φ := fun h => hz (hφU h)
      exact contDiffAt_const.congr_of_eventuallyEq (hout z hz')
  have hψc : HasCompactSupport ψ := by
    refine HasCompactSupport.of_support_subset_isCompact hφc.isCompact ?_
    intro z hz
    by_contra h
    exact hz ((hout z h).self_of_nhds)
  have key : ∀ z, g z * dbar φ z = dbar ψ z := by
    intro z
    by_cases hz Riemann operator `∂φ/∂x + i ∂φ/∂y` of a
  real-differentiable function, and `dbarR` for a real-valued function;
* `WeakCauchyRiemannOn f U` — `f` satisfies the Cauchy–Riemann equations *weakly*
  on `U`: `∫ f · ∂̄φ = 0` for every smooth `φ` compactly supported in `U`;
* `weak_cauchyRiemann_ae_eq_analytic` — **the book's statement**: a function
  locally integrable on an open set `U` and weakly Cauchy–Riemann there agrees
  almost everywhere on `U` with a function analytic on `U`;
* `weakCauchyRiemannOn_of_analyticOn` — the converse: a function analytic on `U`
  is weakly Cauchy–Riemann there;
* `weak_cauchyRiemann_iff_ae_eq_analytic` — the two together, as an
  `iff` characterization of the locally integrable weak solutions of `∂̄f = 0`.

The proof is the classical mollification argument.  Convolving (a truncation of)
`f` with any smooth compactly supported kernel produces a smooth function whose
`∂̄` vanishes — the weak equation applied to the reflected kernel — hence a
holomorphic function.  Mathlib's Lebesgue-differentiation theorem for bump
functions (`ContDiffBump.ae_convolution_tendsto_right_of_locallyIntegrable`)
makes the bump mollifications converge to `f` almost everywhere, while the
*radial* mollifier of `BookProof/ChapterRadialMollifier.lean` reproduces
holomorphic functions exactly (disc mean value property).  Comparing the two
families identifies the almost-everywhere limit with one fixed holomorphic
mollification.
-/

namespace BookProof.WeylCauchyRiemann

open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

/-- The (unnormalized) Cauchy–Riemann operator `∂̄φ = ∂φ/∂x + i ∂φ/∂y`, written
with the real Fréchet derivative of `φ`. A real-differentiable `φ` is complex
differentiable at `z` exactly when `dbar φ z = 0`. -/
def dbar (φ : ℂ → ℂ) (z : ℂ) : ℂ := fderiv ℝ φ z 1 + Complex.I * fderiv ℝ φ z Complex.I

/-- The Cauchy–Riemann operator applied to a real-valued function. -/
def dbarR (χ : ℂ → ℝ) (z : ℂ) : ℂ :=
  ((fderiv ℝ χ z 1 : ℝ) : ℂ) + Complex.I * ((fderiv ℝ χ z Complex.I : ℝ) : ℂ)

/-- `f` satisfies the Cauchy–Riemann equations **weakly** (in the distributional
sense) on the open set `U`: its pairing with `∂̄φ` vanishes for every smooth test
function `φ` compactly supported inside `U`. -/
def WeakCauchyRiemannOn (f : ℂ → ℂ) (U : Set ℂ) : Prop :=
  ∀ φ : ℂ → ℂ, ContDiff ℝ ∞ φ → HasCompactSupport φ → tsupport φ ⊆ U →
    ∫ z : ℂ, f z * dbar φ z = 0

/-- Mollification: convolution of `F` with a real kernel `χ`. -/
def mollify (F : ℂ → ℂ) (χ : ℂ → ℝ) : ℂ → ℂ := fun z => ∫ w : ℂ, (χ (z - w) : ℂ) * F w

theorem mollify_eq_convolution_left (F : ℂ → ℂ) (χ : ℂ → ℝ) :
    mollify F χ = χ ⋆[ContinuousLinearMap.lsmul ℝ ℝ, volume] F := by
  funext z
  rw [convolution_eq_swap]
  simp [mollify, Complex.real_smul]

theorem mollify_eq_convolution_right (F : ℂ → ℂ) (χ : ℂ → ℝ) :
    mollify F χ = F ⋆[(ContinuousLinearMap.lsmul ℝ ℝ).flip, volume] χ := by
  rw [mollify_eq_convolution_left, convolution_flip]

/-- A smooth function with vanishing `∂̄` on an open set is analytic there:
the translation of `BookProof.ChapterHolomorphic.cauchyRiemann_analyticOn` into
the `dbar` notation. -/
theorem analyticOn_of_dbar_eq_zero {g : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hg : ∀ z ∈ s, DifferentiableAt ℝ g z) (hdbar : ∀ z ∈ s, dbar g z = 0) :
    AnalyticOn ℂ g s := by
  refine BookProof.ChapterHolomorphic.cauchyRiemann_analyticOn hs hg fun z hz => ?_
  have h := hdbar z hz
  simp only [dbar] at h
  have hI : fderiv ℝ g z Complex.I = Complex.I * fderiv ℝ g z 1 := by
    linear_combination (-Complex.I) * h + (fderiv ℝ g z Complex.I) * Complex.I_sq
  simpa [smul_eq_mul] using hI

/-- Mollification of a locally integrable function by a smooth compactly
supported kernel is smooth. -/
theorem mollify_contDiff {F : ℂ → ℂ} (hF : LocallyIntegrable F) {χ : ℂ → ℝ}
    (hχ : ContDiff ℝ ∞ χ) (hχc : HasCompactSupport χ) :
    ContDiff ℝ ∞ (mollify F χ) := by
  rw [mollify_eq_convolution_right]
  exact hχc.contDiff_convolution_right _ hF hχ

/-- Reflecting the argument flips the sign of `∂̄`. -/
theorem dbar_ofReal_comp_sub {χ : ℂ → ℝ} (hχ : ContDiff ℝ ∞ χ) (z w : ℂ) :
    dbar (fun v => ((χ (z - v) : ℝ) : ℂ)) w = -dbarR χ (z - w) := by
  have hdiff : Differentiable ℝ χ := hχ.differentiable (by simp)
  have h1 : HasFDerivAt (fun v : ℂ => z - v) (-ContinuousLinearMap.id ℝ ℂ) w := by
    simpa using (hasFDerivAt_id (𝕜 := ℝ) w).const_sub z
  have h2 : HasFDerivAt χ (fderiv ℝ χ (z - w)) (z - w) := (hdiff (z - w)).hasFDerivAt
  have h3 : HasFDerivAt (fun v : ℂ => ((χ (z - v) : ℝ) : ℂ))
      (Complex.ofRealCLM.comp ((fderiv ℝ χ (z - w)).comp (-ContinuousLinearMap.id ℝ ℂ))) w :=
    (Complex.ofRealCLM.hasFDerivAt).comp w (h2.comp w h1)
  rw [dbar, h3.fderiv, dbarR]
  simp
  ring

/-- The `∂̄` of a mollification is the mollification of `F` by the `∂̄` of the
kernel: the derivative falls on the smooth factor. -/
theorem dbar_mollify {F : ℂ → ℂ} (hF : LocallyIntegrable F) {χ : ℂ → ℝ}
    (hχ : ContDiff ℝ ∞ χ) (hχc : HasCompactSupport χ) (z : ℂ) :
    dbar (mollify F χ) z = ∫ w : ℂ, dbarR χ (z - w) * F w := by
  set L : ℂ →L[ℝ] ℝ →L[ℝ] ℂ := (ContinuousLinearMap.lsmul ℝ ℝ).flip with hLdef
  have hχ1 : ContDiff ℝ 1 χ := hχ.of_le (by simp)
  have hfd : HasFDerivAt (mollify F χ) ((F ⋆[L.precompR ℂ, volume] fderiv ℝ χ) z) z := by
    rw [mollify_eq_convolution_right]
    exact hχc.hasFDerivAt_convolution_right L hF hχ1 z
  have hcfd : HasCompactSupport (fderiv ℝ χ) := hχc.fderiv ℝ
  have hcontfd : Continuous (fderiv ℝ χ) := hχ.continuous_fderiv (by simp)
  have happ : ∀ v : ℂ, fderiv ℝ (mollify F χ) z v
      = ∫ w : ℂ, ((fderiv ℝ χ (z - w) v : ℝ) : ℂ) * F w := by
    intro v
    rw [hfd.fderiv, convolution_precompR_apply L hF hcfd hcontfd z v]
    simp [convolution_def, hLdef, Complex.real_smul]
  have hint : ∀ v : ℂ, Integrable (fun w : ℂ => ((fderiv ℝ χ (z - w) v : ℝ) : ℂ) * F w) := by
    intro v
    have hcs : HasCompactSupport (fun a : ℂ => (fderiv ℝ χ a v : ℝ)) :=
      hcfd.comp_left (g := fun T : ℂ →L[ℝ] ℝ => T v) (by simp)
    have hcont : Continuous (fun a : ℂ => (fderiv ℝ χ a v : ℝ)) :=
      hcontfd.clm_apply continuous_const
    have hthis := hcs.convolutionExists_right L hF hcont z
    rw [ConvolutionExistsAt] at hthis
    simpa [hLdef, Complex.real_smul] using hthis
  rw [dbar, happ 1, happ Complex.I, ← MeasureTheory.integral_const_mul,
    ← integral_add (hint 1) ((hint Complex.I).const_mul _)]
  congr 1
  funext w
  simp only [dbarR]
  ring

/-- **Mollification is holomorphic.**  If `f` is weakly Cauchy–Riemann on `U`,
`K = closedBall c R ⊆ U`, and `χ` is a smooth kernel supported in `ball 0 δ`,
then the mollification of the truncation `F = 1_K · f` is analytic on every ball
`ball c r` with `r + δ ≤ R`. -/
theorem mollify_analyticOn {f : ℂ → ℂ} {U : Set ℂ}
    (hf : LocallyIntegrableOn f U) (hCR : WeakCauchyRiemannOn f U)
    {c : ℂ} {R r δ : ℝ} (hδ : 0 < δ) (hr : 0 < r) (hrR : r + δ ≤ R)
    (hKU : closedBall c R ⊆ U) {χ : ℂ → ℝ} (hχ : ContDiff ℝ ∞ χ)
    (hχc : HasCompactSupport χ) (hsupp : Function.support χ ⊆ ball (0 : ℂ) δ) :
    AnalyticOn ℂ (mollify ((closedBall c R).indicator f) χ) (ball c r) := by
  set F : ℂ → ℂ := (closedBall c R).indicator f with hFdef
  have hRpos : 0 < R := by linarith
  have hFint : Integrable F := by
    rw [hFdef]
    exact (integrable_indicator_iff measurableSet_closedBall).2
      (hf.integrableOn_compact_subset hKU (isCompact_closedBall c R))
  have hFloc : LocallyIntegrable F := hFint.locallyIntegrable
  have hsmooth : ContDiff ℝ ∞ (mollify F χ) := mollify_contDiff hFloc hχ hχc
  have htsupp : tsupport χ ⊆ closedBall (0 : ℂ) δ :=
    closure_minimal (hsupp.trans ball_subset_closedBall) isClosed_closedBall
  refine analyticOn_of_dbar_eq_zero isOpen_ball
    (fun z _ => (hsmooth.differentiable (by simp)) z) ?_
  intro z hz
  have hzc : ‖z - c‖ < r := by
    simpa [Complex.dist_eq] using mem_ball.1 hz
  -- the reflected kernel is a legitimate test function
  set φ : ℂ → ℂ := fun v => ((χ (z - v) : ℝ) : ℂ) with hφdef
  have hφsmooth : ContDiff ℝ ∞ φ :=
    Complex.ofRealCLM.contDiff.comp (hχ.comp (contDiff_const.sub contDiff_id))
  have hφsupp : Function.support φ ⊆ closedBall z δ := by
    intro v hv
    simp only [hφdef, Function.mem_support, ne_eq, Complex.ofReal_eq_zero] at hv
    have : z - v ∈ ball (0 : ℂ) δ := hsupp hv
    simp only [mem_ball, dist_zero_right] at this
    simp only [mem_closedBall, Complex.dist_eq]
    rw [← norm_neg]
    simpa using this.le
  have hφc : HasCompactSupport φ :=
    HasCompactSupport.of_support_subset_isCompact (isCompact_closedBall z δ) hφsupp
  have hφU : tsupport φ ⊆ U := by
    refine subset_trans (closure_minimal hφsupp isClosed_closedBall) (subset_trans ?_ hKU)
    intro v hv
    simp only [mem_closedBall, Complex.dist_eq] at hv ⊢
    calc ‖v - c‖ = ‖(v - z) + (z - c)‖ := by ring_nf
      _ ≤ ‖v - z‖ + ‖z - c‖ := norm_add_le _ _
      _ ≤ δ + ‖z - c‖ := by
          have : ‖v - z‖ = ‖z - v‖ := by rw [← norm_neg]; ring_nf
          rw [this]; linarith [hv]
      _ ≤ R := by linarith
  have hweak := hCR φ hφsmooth hφc hφU
  -- rewrite the weak equation as the vanishing of the mollified `∂̄`
  have hdb : ∀ w : ℂ, dbar φ w = -dbarR χ (z - w) := fun w =>
    dbar_ofReal_comp_sub hχ z w
  have hzero : ∫ w : ℂ, dbarR χ (z - w) * f w = 0 := by
    have : ∫ w : ℂ, f w * dbar φ w = -∫ w : ℂ, dbarR χ (z - w) * f w := by
      rw [← MeasureTheory.integral_neg]
      congr 1
      funext w
      rw [hdb w]
      ring
    rw [this] at hweak
    exact neg_eq_zero.1 hweak
  have hFf : ∀ w : ℂ, dbarR χ (z - w) * F w = dbarR χ (z - w) * f w := by
    intro w
    by_cases hd : dbarR χ (z - w) = 0
    · simp [hd]
    · have hsupp' : z - w ∈ tsupport χ := by
        by_contra hcon
        have hz0 : fderiv ℝ χ (z - w) = 0 := by
          have := support_fderiv_subset (𝕜 := ℝ) (f := χ)
          by_contra hne
          exact hcon (this (by simpa [Function.mem_support] using hne))
        apply hd
        simp [dbarR, hz0]
      have hwmem : w ∈ closedBall c R := by
        have h1 : ‖z - w‖ ≤ δ := by
          have := htsupp hsupp'
          simpa [mem_closedBall, dist_zero_right] using this
        simp only [mem_closedBall, Complex.dist_eq]
        calc ‖w - c‖ = ‖-(z - w) + (z - c)‖ := by ring_nf
          _ ≤ ‖-(z - w)‖ + ‖z - c‖ := norm_add_le _ _
          _ ≤ δ + ‖z - c‖ := by rw [norm_neg]; linarith
          _ ≤ R := by linarith
      rw [hFdef, Set.indicator_of_mem hwmem]
  rw [dbar_mollify hFloc hχ hχc z]
  calc ∫ w : ℂ, dbarR χ (z - w) * F w
      = ∫ w : ℂ, dbarR χ (z - w) * f w := by
        congr 1
        funext w
        exact hFf w
    _ = 0 := hzero

/-- Mollifications commute: mollifying by `χ₁` and then by `χ₂` is the same as
mollifying by `χ₂` and then by `χ₁`. -/
theorem mollify_comm {F : ℂ → ℂ} (hF : Integrable F) {χ₁ χ₂ : ℂ → ℝ}
    (hχ₁ : Continuous χ₁) (hχ₁c : HasCompactSupport χ₁)
    (hχ₂ : Continuous χ₂) (hχ₂c : HasCompactSupport χ₂) :
    mollify (mollify F χ₁) χ₂ = mollify (mollify F χ₂) χ₁ := by
  have hprod : ∀ (a b : ℂ → ℝ), Continuous a → HasCompactSupport a → Continuous b →
      HasCompactSupport b → ∀ z : ℂ, Integrable
        (fun p : ℂ × ℂ => ((b (z - p.1) : ℂ) * (a (p.1 - p.2) : ℂ)) * F p.2)
        (volume.prod volume) := by
    intro a b ha hac hb hbc z
    obtain ⟨Ma, hMa⟩ := ha.bounded_above_of_compact_support hac
    obtain ⟨Mb, hMb⟩ := hb.bounded_above_of_compact_support hbc
    have hMa0 : 0 ≤ Ma := le_trans (norm_nonneg _) (hMa 0)
    have hMb0 : 0 ≤ Mb := le_trans (norm_nonneg _) (hMb 0)
    set K : Set ℂ := (fun v : ℂ => z - v) '' (tsupport b) with hK
    have hKc : IsCompact K := hbc.isCompact.image (by fun_prop)
    have hmeasK : MeasurableSet K := hKc.isClosed.measurableSet
    have hindint : Integrable (K.indicator (fun _ : ℂ => (Mb * Ma : ℝ))) :=
      (integrable_indicator_iff hmeasK).2
        (integrableOn_const (C := Mb * Ma) (ne_of_lt hKc.measure_lt_top))
    refine Integrable.mono' (hindint.mul_prod hF.norm) ?_ ?_
    · refine AEStronglyMeasurable.mul ?_ hF.aestronglyMeasurable.comp_snd
      exact ((Complex.continuous_ofReal.comp
          (hb.comp (continuous_const.sub continuous_fst))).mul
        (Complex.continuous_ofReal.comp
          (ha.comp (continuous_fst.sub continuous_snd)))).aestronglyMeasurable
    · filter_upwards with p
      by_cases hp : p.1 ∈ K
      · rw [Set.indicator_of_mem hp]
        have hle : ‖b (z - p.1)‖ * ‖a (p.1 - p.2)‖ ≤ Mb * Ma :=
          mul_le_mul (hMb _) (hMa _) (norm_nonneg _) hMb0
        simp only [norm_mul, Complex.norm_real]
        exact mul_le_mul_of_nonneg_right hle (norm_nonneg _)
      · have hb0 : b (z - p.1) = 0 := by
          by_contra hne
          exact hp ⟨z - p.1, subset_tsupport b hne, by ring⟩
        simp only [hb0, Complex.ofReal_zero, zero_mul, norm_zero]
        exact mul_nonneg (Set.indicator_apply_nonneg fun _ => mul_nonneg hMb0 hMa0)
          (norm_nonneg _)
  funext z
  have hstep : ∀ (a b : ℂ → ℝ), Continuous a → HasCompactSupport a → Continuous b →
      HasCompactSupport b →
      mollify (mollify F a) b z
        = ∫ w : ℂ, ∫ v : ℂ, ((b (z - v) : ℂ) * (a (v - w) : ℂ)) * F w := by
    intro a b ha hac hb hbc
    have h1 : mollify (mollify F a) b z
        = ∫ v : ℂ, ∫ w : ℂ, ((b (z - v) : ℂ) * (a (v - w) : ℂ)) * F w := by
      simp only [mollify]
      congr 1
      funext v
      rw [← MeasureTheory.integral_const_mul]
      congr 1
      funext w
      ring
    rw [h1, integral_integral_swap (hprod a b ha hac hb hbc z)]
  rw [hstep χ₁ χ₂ hχ₁ hχ₁c hχ₂ hχ₂c, hstep χ₂ χ₁ hχ₂ hχ₂c hχ₁ hχ₁c]
  congr 1
  funext w
  have := integral_sub_left_eq_self
    (fun v : ℂ => ((χ₂ (z - v) : ℂ) * (χ₁ (v - w) : ℂ)) * F w) volume (z + w)
  rw [← this]
  refine integral_congr_ae (Eventually.of_forall fun v => ?_)
  simp only
  rw [show z - (z + w - v) = v - w by ring, show z + w - v - w = z - v by ring]
  ring

/-- The radial mollifier reproduces a holomorphic function (disc mean value
property), in the `mollify` notation. -/
theorem mollify_moll_eq_self {h : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hh : DifferentiableOn ℂ h s) (hcont : Continuous h) {δ : ℝ} (hδ : 0 < δ) {z : ℂ}
    (hz : closedBall z δ ⊆ s) : mollify h (moll δ) z = h z :=
  integral_moll_eq_self_of_analytic hs hh hcont hδ hz

/-- The bump family used to extract almost-everywhere convergence. -/
def bumpSeq (n : ℕ) : ContDiffBump (0 : ℂ) where
  rIn := 1 / (n + 2)
  rOut := 2 / (n + 2)
  rIn_pos := by positivity
  rIn_lt_rOut := by
    have h : (0 : ℝ) < (n : ℝ) + 2 := by positivity
    rw [div_lt_div_iff_of_pos_right h]
    norm_num

theorem bumpSeq_rOut_tendsto : Tendsto (fun n => (bumpSeq n).rOut) atTop (nhds 0) := by
  have h : Tendsto (fun n : ℕ => ((n : ℝ) + 2)) atTop atTop :=
    tendsto_atTop_add_const_right _ 2 tendsto_natCast_atTop_atTop
  simpa [bumpSeq] using tendsto_const_nhds.div_atTop (f := fun _ : ℕ => (2 : ℝ)) h

theorem bumpSeq_rOut_le (n : ℕ) : (bumpSeq n).rOut ≤ 2 * (bumpSeq n).rIn := by
  simp only [bumpSeq]
  rw [mul_one_div]

theorem bumpSeq_support (n : ℕ) :
    Function.support ((bumpSeq n).normed volume) ⊆ ball (0 : ℂ) ((bumpSeq n).rOut) :=
  (bumpSeq n).support_normed_eq.subset

theorem bumpSeq_contDiff (n : ℕ) : ContDiff ℝ ∞ ((bumpSeq n).normed volume) :=
  (bumpSeq n).contDiff_normed

theorem bumpSeq_hasCompactSupport (n : ℕ) :
    HasCompactSupport ((bumpSeq n).normed volume) := (bumpSeq n).hasCompactSupport_normed

/-- Almost-everywhere convergence of the bump mollifications of a locally
integrable function (Mathlib's Lebesgue differentiation theorem for bumps). -/
theorem ae_tendsto_mollify_bump {F : ℂ → ℂ} (hF : LocallyIntegrable F) :
    ∀ᵐ z : ℂ, Tendsto (fun n => mollify F ((bumpSeq n).normed volume) z) atTop (nhds (F z)) := by
  have := ContDiffBump.ae_convolution_tendsto_right_of_locallyIntegrable
    (φ := bumpSeq) (l := atTop) (K := 2) bumpSeq_rOut_tendsto
    (Eventually.of_forall bumpSeq_rOut_le) hF
  filter_upwards [this] with z hz
  simpa only [mollify_eq_convolution_left] using hz

/-- Pointwise convergence of the bump mollifications of a continuous function. -/
theorem tendsto_mollify_bump_of_continuous {h : ℂ → ℂ} (hh : Continuous h) (z : ℂ) :
    Tendsto (fun n => mollify h ((bumpSeq n).normed volume) z) atTop (nhds (h z)) := by
  simpa only [mollify_eq_convolution_left] using
    ContDiffBump.convolution_tendsto_right_of_continuous (φ := bumpSeq) (l := atTop)
      bumpSeq_rOut_tendsto hh z

/-- **Weyl's lemma for `∂̄`, local form.**  On a ball whose closure lies in `U`,
a weakly Cauchy–Riemann locally integrable function agrees almost everywhere
with an analytic function. -/
theorem exists_analyticOn_ae_eq_ball {f : ℂ → ℂ} {U : Set ℂ}
    (hf : LocallyIntegrableOn f U) (hCR : WeakCauchyRiemannOn f U)
    {c : ℂ} {R : ℝ} (hR : 0 < R) (hKU : closedBall c R ⊆ U) :
    ∃ g : ℂ → ℂ, AnalyticOn ℂ g (ball c (R / 4)) ∧
      ∀ᵐ z : ℂ, z ∈ ball c (R / 4) → f z = g z := by
  set δ : ℝ := R / 4 with hδdef
  have hδ : 0 < δ := by positivity
  set F : ℂ → ℂ := (closedBall c R).indicator f with hFdef
  have hFint : Integrable F := by
    rw [hFdef]
    exact (integrable_indicator_iff measurableSet_closedBall).2
      (hf.integrableOn_compact_subset hKU (isCompact_closedBall c R))
  have hFloc : LocallyIntegrable F := hFint.locallyIntegrable
  set h : ℂ → ℂ := mollify F (moll δ) with hhdef
  have hsmooth : ContDiff ℝ ∞ h :=
    mollify_contDiff hFloc (moll_contDiff δ) (moll_hasCompactSupport hδ)
  have hcont : Continuous h := hsmooth.continuous
  have hana : AnalyticOn ℂ h (ball c (R / 2)) :=
    mollify_analyticOn hf hCR hδ (by positivity) (by linarith) hKU
      (moll_contDiff δ) (moll_hasCompactSupport hδ) (moll_support_subset hδ)
  refine ⟨h, hana.mono (ball_subset_ball (by linarith)), ?_⟩
  -- the bump mollifications are holomorphic too, for small radii
  have hev : ∀ᶠ n in atTop, (bumpSeq n).rOut < δ :=
    Filter.Tendsto.eventually_lt_const hδ bumpSeq_rOut_tendsto
  have hbana : ∀ n, (bumpSeq n).rOut < δ →
      AnalyticOn ℂ (mollify F ((bumpSeq n).normed volume)) (ball c (R / 2)) := by
    intro n hn
    refine mollify_analyticOn hf hCR hδ (by positivity) (by linarith) hKU
      (bumpSeq_contDiff n) (bumpSeq_hasCompactSupport n) ?_
    exact (bumpSeq_support n).trans (ball_subset_ball hn.le)
  -- for small radii the two mollifications agree on the small ball
  have hkey : ∀ n, (bumpSeq n).rOut < δ → ∀ z ∈ ball c (R / 4),
      mollify F ((bumpSeq n).normed volume) z = mollify h ((bumpSeq n).normed volume) z := by
    intro n hn z hz
    have hball : closedBall z δ ⊆ ball c (R / 2) := by
      intro v hv
      have h1 : dist v z ≤ δ := mem_closedBall.1 hv
      have h2 : dist z c < R / 4 := mem_ball.1 hz
      have : dist v c < R / 2 := by
        calc dist v c ≤ dist v z + dist z c := dist_triangle _ _ _
          _ < δ + R / 4 := by linarith
          _ = R / 2 := by rw [hδdef]; ring
      exact mem_ball.2 this
    have hbcont : Continuous (mollify F ((bumpSeq n).normed volume)) :=
      (mollify_contDiff hFloc (bumpSeq_contDiff n) (bumpSeq_hasCompactSupport n)).continuous
    have h1 : mollify (mollify F ((bumpSeq n).normed volume)) (moll δ) z
        = mollify F ((bumpSeq n).normed volume) z :=
      mollify_moll_eq_self isOpen_ball ((hbana n hn).differentiableOn) hbcont hδ hball
    have h2 : mollify (mollify F ((bumpSeq n).normed volume)) (moll δ)
        = mollify (mollify F (moll δ)) ((bumpSeq n).normed volume) :=
      mollify_comm hFint (bumpSeq_contDiff n).continuous (bumpSeq_hasCompactSupport n)
        (moll_continuous δ) (moll_hasCompactSupport hδ)
    rw [← h1, h2, hhdef]
  -- pass to the limit
  filter_upwards [ae_tendsto_mollify_bump hFloc] with z hzlim hzmem
  have hlim2 : Tendsto (fun n => mollify h ((bumpSeq n).normed volume) z) atTop (nhds (h z)) :=
    tendsto_mollify_bump_of_continuous hcont z
  have hlim1 : Tendsto (fun n => mollify F ((bumpSeq n).normed volume) z) atTop (nhds (h z)) := by
    refine hlim2.congr' ?_
    filter_upwards [hev] with n hn
    exact (hkey n hn z hzmem).symm
  have hFz : F z = h z := tendsto_nhds_unique hzlim hlim1
  have hzin : z ∈ closedBall c R := by
    have : dist z c < R / 4 := mem_ball.1 hzmem
    exact mem_closedBall.2 (by linarith)
  rwa [hFdef, Set.indicator_of_mem hzin] at hFz

/-- **Weyl's lemma for `∂̄` — the book's statement.**  A function locally
integrable on an open set `U` of the complex plane, satisfying the
Cauchy–Riemann equations in the weak (distributional) sense on `U`, agrees
almost everywhere on `U` with a function analytic on `U`. -/
theorem weak_cauchyRiemann_ae_eq_analytic {f : ℂ → ℂ} {U : Set ℂ} (hU : IsOpen U)
    (hf : LocallyIntegrableOn f U) (hCR : WeakCauchyRiemannOn f U) :
    ∃ g : ℂ → ℂ, AnalyticOn ℂ g U ∧ ∀ᵐ z : ℂ, z ∈ U → f z = g z := by
  classical
  -- a local analytic representative around every point of `U`
  have hloc : ∀ c ∈ U, ∃ (ρ : ℝ) (gc : ℂ → ℂ), 0 < ρ ∧ ball c ρ ⊆ U ∧
      AnalyticOn ℂ gc (ball c ρ) ∧ ∀ᵐ z : ℂ, z ∈ ball c ρ → f z = gc z := by
    intro c hc
    obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.1 hU c hc
    have hsub : closedBall c (ε / 2) ⊆ U :=
      (closedBall_subset_ball (by linarith)).trans hball
    obtain ⟨gc, hgc, hae⟩ :=
      exists_analyticOn_ae_eq_ball hf hCR (by linarith : (0 : ℝ) < ε / 2) hsub
    exact ⟨ε / 2 / 4, gc, by linarith, (ball_subset_ball (by linarith)).trans hball, hgc, hae⟩
  choose! ρ gc hρ hballU hana hae using hloc
  -- the local representatives agree on overlaps
  have hagree : ∀ c ∈ U, ∀ z ∈ U, EqOn (gc c) (gc z) (ball c (ρ c) ∩ ball z (ρ z)) := by
    intro c hc z hz
    have hopen : IsOpen (ball c (ρ c) ∩ ball z (ρ z)) := isOpen_ball.inter isOpen_ball
    refine MeasureTheory.Measure.eqOn_open_of_ae_eq (μ := volume) ?_ hopen
      (((hana c hc).continuousOn).mono inter_subset_left)
      (((hana z hz).continuousOn).mono inter_subset_right)
    rw [Filter.EventuallyEq, ae_restrict_iff' hopen.measurableSet]
    filter_upwards [hae c hc, hae z hz] with w h1 h2 hw
    rw [← h1 hw.1, ← h2 hw.2]
  set G : ℂ → ℂ := fun z => gc z z with hGdef
  have hGloc : ∀ c ∈ U, ∀ w ∈ ball c (ρ c), G w = gc c w := by
    intro c hc w hw
    have hwU : w ∈ U := hballU c hc hw
    exact (hagree c hc w hwU ⟨hw, mem_ball_self (hρ w hwU)⟩).symm
  refine ⟨G, ?_, ?_⟩
  · rw [hU.analyticOn_iff_analyticOnNhd]
    intro c hc
    have hEq : EqOn G (gc c) (ball c (ρ c)) := fun w hw => hGloc c hc w hw
    have hAt : AnalyticAt ℂ (gc c) c :=
      ((isOpen_ball.analyticOn_iff_analyticOnNhd).1 (hana c hc)) c (mem_ball_self (hρ c hc))
    exact hAt.congr (Filter.eventuallyEq_of_mem (isOpen_ball.mem_nhds (mem_ball_self (hρ c hc)))
      hEq).symm
  · -- a countable subcover makes the exceptional set null
    obtain ⟨T, hTU, hTc, hTeq⟩ :=
      TopologicalSpace.isOpen_biUnion_countable U (fun c => ball c (ρ c))
        (fun c _ => isOpen_ball)
    have hcover : U ⊆ ⋃ c ∈ T, ball c (ρ c) := by
      rw [hTeq]
      intro z hz
      exact mem_biUnion hz (mem_ball_self (hρ z hz))
    rw [ae_iff]
    have hsubset : {z : ℂ | ¬(z ∈ U → f z = G z)} ⊆
        ⋃ c ∈ T, {z : ℂ | ¬(z ∈ ball c (ρ c) → f z = gc c z)} := by
      intro z hz
      simp only [mem_setOf_eq, Classical.not_imp] at hz
      obtain ⟨hzU, hzne⟩ := hz
      obtain ⟨c, hcT, hzc⟩ := mem_iUnion₂.1 (hcover hzU)
      refine mem_iUnion₂.2 ⟨c, hcT, ?_⟩
      simp only [mem_setOf_eq, Classical.not_imp]
      exact ⟨hzc, fun hcon => hzne (by rw [hGloc c (hTU hcT) z hzc]; exact hcon)⟩
    exact measure_mono_null hsubset
      ((measure_biUnion_null_iff hTc).2 fun c hc => ae_iff.1 (hae c (hTU hc)))


/-! ## The converse: an analytic function is weakly Cauchy–Riemann

The remaining half of the characterization.  For a smooth compactly supported
`ψ` the integral of `∂̄ψ` over the plane vanishes (Fubini and the fundamental
theorem of calculus in each of the two real directions); applying this to
`ψ = g · φ`, with `g` analytic on `U` and `φ` a test function supported in `U`,
gives the weak Cauchy–Riemann equation for `g`.
-/

/-- The integral of the derivative of a compactly supported `C¹` function vanishes. -/
theorem integral_deriv_eq_zero_of_hasCompactSupport {u : ℝ → ℂ} (hu : ContDiff ℝ 1 u)
    (huc : HasCompactSupport u) : ∫ t : ℝ, deriv u t = 0 := by
  have hcd : Continuous (deriv u) := hu.continuous_deriv le_rfl
  have hint : Integrable (deriv u) :=
    hcd.integrable_of_hasCompactSupport (huc.deriv)
  have h1 : ∫ x in Iic (0 : ℝ), deriv u x = u 0 :=
    HasCompactSupport.integral_Iic_deriv_eq hu huc 0
  have h2 : ∫ x in Ioi (0 : ℝ), deriv u x = -u 0 :=
    HasCompactSupport.integral_Ioi_deriv_eq hu huc 0
  have h3 := intervalIntegral.integral_Iic_add_Ioi (μ := volume) (f := deriv u) (b := (0 : ℝ))
    hint.integrableOn hint.integrableOn
  rw [h1, h2] at h3
  simpa using h3.symm

/-- Transfer of an integral over `ℂ` to an integral over `ℝ × ℝ`. -/
theorem integral_complex_eq_prod (G : ℂ → ℂ) :
    ∫ z : ℂ, G z = ∫ p : ℝ × ℝ, G (p.1 + p.2 * Complex.I) := by
  rw [← (Complex.volume_preserving_equiv_real_prod.symm).integral_comp
    Complex.measurableEquivRealProd.symm.measurableEmbedding G]
  refine integral_congr_ae (Eventually.of_forall fun p => ?_)
  simp only
  congr 1
  rw [Complex.measurableEquivRealProd_symm_apply]
  apply Complex.ext <;> simp

theorem hasCompactSupport_slice_im {ψ : ℂ → ℂ} (hψc : HasCompactSupport ψ) (x : ℝ) :
    HasCompactSupport (fun t : ℝ => ψ ((x : ℂ) + t * Complex.I)) := by
  obtain ⟨M, hM⟩ := hψc.isCompact.isBounded.subset_closedBall 0
  refine HasCompactSupport.of_support_subset_isCompact (isCompact_Icc (a := -M) (b := M)) ?_
  intro t ht
  have hmem : (x : ℂ) + t * Complex.I ∈ tsupport ψ := subset_tsupport ψ ht
  have := hM hmem
  simp only [mem_closedBall, dist_zero_right] at this
  have himle : |t| ≤ ‖(x : ℂ) + t * Complex.I‖ := by
    have : ((x : ℂ) + t * Complex.I).im = t := by simp
    calc |t| = |((x : ℂ) + t * Complex.I).im| := by rw [this]
      _ ≤ ‖(x : ℂ) + t * Complex.I‖ := Complex.abs_im_le_norm _
  rw [mem_Icc]
  constructor <;> [linarith [abs_le.1 (le_trans himle this) |>.1];
    linarith [abs_le.1 (le_trans himle this) |>.2]]

theorem hasCompactSupport_slice_re {ψ : ℂ → ℂ} (hψc : HasCompactSupport ψ) (y : ℝ) :
    HasCompactSupport (fun t : ℝ => ψ ((t : ℂ) + y * Complex.I)) := by
  obtain ⟨M, hM⟩ := hψc.isCompact.isBounded.subset_closedBall 0
  refine HasCompactSupport.of_support_subset_isCompact (isCompact_Icc (a := -M) (b := M)) ?_
  intro t ht
  have hmem : (t : ℂ) + y * Complex.I ∈ tsupport ψ := subset_tsupport ψ ht
  have := hM hmem
  simp only [mem_closedBall, dist_zero_right] at this
  have hrele : |t| ≤ ‖(t : ℂ) + y * Complex.I‖ := by
    have hre : ((t : ℂ) + y * Complex.I).re = t := by simp
    calc |t| = |((t : ℂ) + y * Complex.I).re| := by rw [hre]
      _ ≤ ‖(t : ℂ) + y * Complex.I‖ := Complex.abs_re_le_norm _
  rw [mem_Icc]
  constructor <;> [linarith [abs_le.1 (le_trans hrele this) |>.1];
    linarith [abs_le.1 (le_trans hrele this) |>.2]]

theorem hasCompactSupport_comp_realProd {F : ℂ → ℂ} (hF : HasCompactSupport F) :
    HasCompactSupport (fun p : ℝ × ℝ => F ((p.1 : ℂ) + p.2 * Complex.I)) := by
  obtain ⟨M, hM⟩ := hF.isCompact.isBounded.subset_closedBall 0
  refine HasCompactSupport.of_support_subset_isCompact
    ((isCompact_Icc (a := -M) (b := M)).prod (isCompact_Icc (a := -M) (b := M))) ?_
  rintro ⟨x, y⟩ hxy
  have hmem : ((x : ℂ) + y * Complex.I) ∈ tsupport F := subset_tsupport F hxy
  have hb := hM hmem
  simp only [mem_closedBall, dist_zero_right] at hb
  have hx : |x| ≤ ‖(x : ℂ) + y * Complex.I‖ := by
    have hre : ((x : ℂ) + y * Complex.I).re = x := by simp
    calc |x| = |((x : ℂ) + y * Complex.I).re| := by rw [hre]
      _ ≤ _ := Complex.abs_re_le_norm _
  have hy : |y| ≤ ‖(x : ℂ) + y * Complex.I‖ := by
    have him : ((x : ℂ) + y * Complex.I).im = y := by simp
    calc |y| = |((x : ℂ) + y * Complex.I).im| := by rw [him]
      _ ≤ _ := Complex.abs_im_le_norm _
  have hx' := abs_le.1 (hx.trans hb)
  have hy' := abs_le.1 (hy.trans hb)
  exact ⟨mem_Icc.2 ⟨hx'.1, hx'.2⟩, mem_Icc.2 ⟨hy'.1, hy'.2⟩⟩

theorem deriv_slice_re {ψ : ℂ → ℂ} (hψ : Differentiable ℝ ψ) (x y : ℝ) :
    deriv (fun t : ℝ => ψ ((t : ℂ) + y * Complex.I)) x
      = fderiv ℝ ψ ((x : ℂ) + y * Complex.I) 1 := by
  have hg : HasDerivAt (fun t : ℝ => (t : ℂ) + y * Complex.I) 1 x := by
    simpa using (Complex.ofRealCLM.hasDerivAt (x := x)).add_const ((y : ℂ) * Complex.I)
  have := (hψ ((x : ℂ) + y * Complex.I)).hasFDerivAt.comp_hasDerivAt x hg
  exact this.deriv

theorem deriv_slice_im {ψ : ℂ → ℂ} (hψ : Differentiable ℝ ψ) (x y : ℝ) :
    deriv (fun t : ℝ => ψ ((x : ℂ) + t * Complex.I)) y
      = fderiv ℝ ψ ((x : ℂ) + y * Complex.I) Complex.I := by
  have hg : HasDerivAt (fun t : ℝ => (x : ℂ) + t * Complex.I) Complex.I y := by
    simpa using ((Complex.ofRealCLM.hasDerivAt (x := y)).mul_const Complex.I).const_add
      ((x : ℂ))
  have := (hψ ((x : ℂ) + y * Complex.I)).hasFDerivAt.comp_hasDerivAt y hg
  exact this.deriv

theorem hasCompactSupport_fderiv_apply {ψ : ℂ → ℂ} (hψc : HasCompactSupport ψ) (v : ℂ) :
    HasCompactSupport (fun z : ℂ => fderiv ℝ ψ z v) := by
  refine HasCompactSupport.of_support_subset_isCompact hψc.isCompact ?_
  intro z hz
  have : fderiv ℝ ψ z ≠ 0 := by
    intro h
    apply hz
    simp [h]
  exact support_fderiv_subset ℝ (f := ψ) this

theorem contDiff_slice_re (y : ℝ) : ContDiff ℝ ∞ (fun t : ℝ => (t : ℂ) + y * Complex.I) := by
  exact (Complex.ofRealCLM.contDiff).add contDiff_const

theorem contDiff_slice_im (x : ℝ) : ContDiff ℝ ∞ (fun t : ℝ => (x : ℂ) + t * Complex.I) := by
  exact contDiff_const.add ((Complex.ofRealCLM.contDiff).mul contDiff_const)

theorem integral_fderiv_one_eq_zero {ψ : ℂ → ℂ} (hψ : ContDiff ℝ ∞ ψ)
    (hψc : HasCompactSupport ψ) : ∫ z : ℂ, fderiv ℝ ψ z 1 = 0 := by
  have hdiff : Differentiable ℝ ψ := hψ.differentiable (by simp)
  have hcontF : Continuous fun z : ℂ => fderiv ℝ ψ z 1 :=
    (hψ.continuous_fderiv (by simp)).clm_apply continuous_const
  have hcsF : HasCompactSupport fun z : ℂ => fderiv ℝ ψ z 1 :=
    hasCompactSupport_fderiv_apply hψc 1
  rw [integral_complex_eq_prod]
  have hcont : Continuous fun p : ℝ × ℝ => fderiv ℝ ψ ((p.1 : ℂ) + p.2 * Complex.I) 1 :=
    hcontF.comp (by fun_prop)
  have hint : Integrable fun p : ℝ × ℝ => fderiv ℝ ψ ((p.1 : ℂ) + p.2 * Complex.I) 1 :=
    hcont.integrable_of_hasCompactSupport (hasCompactSupport_comp_realProd hcsF)
  rw [MeasureTheory.Measure.volume_eq_prod, integral_prod_symm _ hint]
  have hinner : ∀ y : ℝ, ∫ x : ℝ, fderiv ℝ ψ ((x : ℂ) + y * Complex.I) 1 = 0 := by
    intro y
    have h1 : (fun x : ℝ => fderiv ℝ ψ ((x : ℂ) + y * Complex.I) 1)
        = deriv fun t : ℝ => ψ ((t : ℂ) + y * Complex.I) := by
      funext x
      exact (deriv_slice_re hdiff x y).symm
    rw [h1]
    exact integral_deriv_eq_zero_of_hasCompactSupport
      ((hψ.comp (contDiff_slice_re y)).of_le (by simp))
      (hasCompactSupport_slice_re hψc y)
  simp [hinner]

set_option maxHeartbeats 1000000 in
-- the Fubini rewrite for the vertical slices needs more than the default budget
theorem integral_fderiv_I_eq_zero {ψ : ℂ → ℂ} (hψ : ContDiff ℝ ∞ ψ)
    (hψc : HasCompactSupport ψ) : ∫ z : ℂ, fderiv ℝ ψ z Complex.I = 0 := by
  have hdiff : Differentiable ℝ ψ := hψ.differentiable (by simp)
  have hcontF : Continuous fun z : ℂ => fderiv ℝ ψ z Complex.I :=
    (hψ.continuous_fderiv (by simp)).clm_apply continuous_const
  have hcsF : HasCompactSupport fun z : ℂ => fderiv ℝ ψ z Complex.I :=
    hasCompactSupport_fderiv_apply hψc Complex.I
  rw [integral_complex_eq_prod]
  have hcont : Continuous fun p : ℝ × ℝ => fderiv ℝ ψ ((p.1 : ℂ) + p.2 * Complex.I) Complex.I :=
    hcontF.comp (by fun_prop)
  have hint : Integrable fun p : ℝ × ℝ => fderiv ℝ ψ ((p.1 : ℂ) + p.2 * Complex.I) Complex.I :=
    hcont.integrable_of_hasCompactSupport (hasCompactSupport_comp_realProd hcsF)
  rw [MeasureTheory.Measure.volume_eq_prod, integral_prod _ hint]
  have hinner : ∀ x : ℝ, ∫ y : ℝ, fderiv ℝ ψ ((x : ℂ) + y * Complex.I) Complex.I = 0 := by
    intro x
    have h1 : (fun y : ℝ => fderiv ℝ ψ ((x : ℂ) + y * Complex.I) Complex.I)
        = deriv fun t : ℝ => ψ ((x : ℂ) + t * Complex.I) := by
      funext y
      exact (deriv_slice_im hdiff x y).symm
    rw [h1]
    exact integral_deriv_eq_zero_of_hasCompactSupport
      ((hψ.comp (contDiff_slice_im x)).of_le (by simp))
      (hasCompactSupport_slice_im hψc x)
  simp [hinner]

/-- The integral over `ℂ` of `∂̄ψ` vanishes for a smooth compactly supported `ψ`. -/
theorem integral_dbar_eq_zero {ψ : ℂ → ℂ} (hψ : ContDiff ℝ ∞ ψ)
    (hψc : HasCompactSupport ψ) : ∫ z : ℂ, dbar ψ z = 0 := by
  have h1 : Integrable fun z : ℂ => fderiv ℝ ψ z 1 :=
    ((hψ.continuous_fderiv (by simp)).clm_apply continuous_const).integrable_of_hasCompactSupport
      (hasCompactSupport_fderiv_apply hψc 1)
  have h2 : Integrable fun z : ℂ => Complex.I * fderiv ℝ ψ z Complex.I := by
    have hc : Continuous fun z : ℂ => Complex.I * fderiv ℝ ψ z Complex.I :=
      continuous_const.mul ((hψ.continuous_fderiv (by simp)).clm_apply continuous_const)
    exact hc.integrable_of_hasCompactSupport
      (hasCompactSupport_fderiv_apply hψc Complex.I).mul_left
  simp only [dbar]
  rw [integral_add h1 h2, integral_fderiv_one_eq_zero hψ hψc,
    MeasureTheory.integral_const_mul, integral_fderiv_I_eq_zero hψ hψc]
  simp

theorem dbar_eq_zero_of_differentiableAt {g : ℂ → ℂ} {z : ℂ} (h : DifferentiableAt ℂ g z) :
    dbar g z = 0 := by
  have hr := (h.hasDerivAt.hasFDerivAt).restrictScalars ℝ
  simp only [dbar, hr.fderiv, ContinuousLinearMap.coe_restrictScalars',
    ContinuousLinearMap.toSpanSingleton_apply, smul_eq_mul]
  linear_combination (deriv g z) * Complex.I_sq

theorem dbar_mul {a b : ℂ → ℂ} {z : ℂ} (ha : DifferentiableAt ℝ a z)
    (hb : DifferentiableAt ℝ b z) :
    dbar (fun w => a w * b w) z = dbar a z * b z + a z * dbar b z := by
  have he : (fun w => a w * b w) = a * b := rfl
  simp only [dbar, he, fderiv_mul ha hb, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_smul', Pi.smul_apply, smul_eq_mul]
  ring

/-- **Converse of Weyl's lemma.** A function analytic on an open set satisfies the
Cauchy–Riemann equations weakly there. -/
theorem weakCauchyRiemannOn_of_analyticOn {g : ℂ → ℂ} {U : Set ℂ} (hU : IsOpen U)
    (hg : AnalyticOn ℂ g U) : WeakCauchyRiemannOn g U := by
  classical
  intro φ hφ hφc hφU
  have hgn : AnalyticOnNhd ℂ g U := (hU.analyticOn_iff_analyticOnNhd.1 hg)
  set ψ : ℂ → ℂ := fun z => if z ∈ U then g z * φ z else 0 with hψdef
  have hUmem : ∀ z ∈ U, ψ =ᶠ[𝓝 z] fun w => g w * φ w := by
    intro z hz
    filter_upwards [hU.mem_nhds hz] with w hw
    simp [hψdef, hw]
  have hφ0 : ∀ z ∉ tsupport φ, φ =ᶠ[𝓝 z] fun _ => 0 := by
    intro z hz
    filter_upwards [(isOpen_compl_iff.2 (isClosed_tsupport φ)).mem_nhds hz] with w hw
    exact image_eq_zero_of_notMem_tsupport hw
  have hout : ∀ z ∉ tsupport φ, ψ =ᶠ[𝓝 z] fun _ => 0 := by
    intro z hz
    filter_upwards [(isOpen_compl_iff.2 (isClosed_tsupport φ)).mem_nhds hz] with w hw
    have : φ w = 0 := image_eq_zero_of_notMem_tsupport hw
    simp [hψdef, this]
  have hψsmooth : ContDiff ℝ ∞ ψ := by
    rw [contDiff_iff_contDiffAt]
    intro z
    by_cases hz : z ∈ U
    · have h1 : ContDiffAt ℝ ∞ (fun w => g w * φ w) z :=
        (((hgn z hz).contDiffAt).restrict_scalars ℝ).mul hφ.contDiffAt
      exact h1.congr_of_eventuallyEq (hUmem z hz)
    · have hz' : z ∉ tsupport φ := fun h => hz (hφU h)
      exact contDiffAt_const.congr_of_eventuallyEq (hout z hz')
  have hψc : HasCompactSupport ψ := by
    refine HasCompactSupport.of_support_subset_isCompact hφc.isCompact ?_
    intro z hz
    by_contra h
    exact hz ((hout z h).self_of_nhds)
  have key : ∀ z, g z * dbar φ z = dbar ψ z := by
    intro z
    by_cases hz : z ∈ U
    · have h1 : dbar ψ z = dbar (fun w => g w * φ w) z := by
        simp only [dbar, (hUmem z hz).fderiv_eq]
      have hga : DifferentiableAt ℂ g z := (hgn z hz).differentiableAt
      rw [h1, dbar_mul (hga.restrictScalars ℝ) (hφ.differentiable (by simp) z),
        dbar_eq_zero_of_differentiableAt hga]
      ring
    · have hz' : z ∉ tsupport φ := fun h => hz (hφU h)
      have h1 : dbar ψ z = 0 := by
        simp only [dbar, (hout z hz').fderiv_eq]
        simp
      have h2 : dbar φ z = 0 := by
        simp only [dbar, (hφ0 z hz').fderiv_eq]
        simp
      rw [h1, h2, mul_zero]
  calc ∫ z : ℂ, g z * dbar φ z = ∫ z : ℂ, dbar ψ z := by simp only [key]
    _ = 0 := integral_dbar_eq_zero hψsmooth hψc

/-- Outside the support of `φ` the Cauchy–Riemann operator vanishes. -/
theorem dbar_eq_zero_of_notMem_tsupport {φ : ℂ → ℂ} {z : ℂ} (hz : z ∉ tsupport φ) :
    dbar φ z = 0 := by
  have h0 : φ =ᶠ[𝓝 z] fun _ => 0 := by
    filter_upwards [(isOpen_compl_iff.2 (isClosed_tsupport φ)).mem_nhds hz] with w hw
    exact image_eq_zero_of_notMem_tsupport hw
  simp only [dbar, h0.fderiv_eq]
  simp



/-- **Weyl's lemma for `∂̄`, as a characterization.**  For a locally integrable
function on an open set `U ⊆ ℂ`, satisfying the Cauchy–Riemann equations weakly
on `U` is *equivalent* to agreeing almost everywhere on `U` with a function
analytic on `U`. -/
theorem weak_cauchyRiemann_iff_ae_eq_analytic {f : ℂ → ℂ} {U : Set ℂ} (hU : IsOpen U)
    (hf : LocallyIntegrableOn f U) :
    WeakCauchyRiemannOn f U ↔ ∃ g : ℂ → ℂ, AnalyticOn ℂ g U ∧ ∀ᵐ z : ℂ, z ∈ U → f z = g z := by
  refine ⟨fun hCR => weak_cauchyRiemann_ae_eq_analytic hU hf hCR, ?_⟩
  rintro ⟨g, hg, hae⟩
  exact (weakCauchyRiemannOn_of_analyticOn hU hg).congr_ae hae

end

end BookProof.WeylCauchyRiemann
