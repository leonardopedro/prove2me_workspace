import Mathlib
import BookProof.ChapterWeakSecondDerivative
import BookProof.ChapterScalaronCoreEsa

/-!
# The exponential scalaron wall: `−d²/dφ² + V` is essentially self-adjoint

`CONSOLIDATED_PLAN.md` §10.6.1/§10.6.2 leaves one item of the quantum-gravity chapter open:
the Schrödinger operator with the **exponentially growing** Einstein-frame scalaron wall

`V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²`,

whose growth as `φ → −∞` beats every polynomial (`starobinskyV_not_hasTemperateGrowth`).
Every route the project had tried was perturbative relative to the harmonic (Gauss/Hermite)
core, and each of them is *refuted* for such a wall: relative boundedness fails
(`BookProof/ChapterHermiteExpWall.lean`) and the Carleman flux criterion is inapplicable
because `∑ 1/Aₙ` converges.  `BookProof/ChapterScalaronCoreEsa.lean` settles the
multiplication operator alone; what was missing is the **sum** `−d²/dφ² + V`.

## The non-perturbative argument

For a *non-negative* potential the classical argument needs no perturbation theory at all.
A deficiency vector `u ∈ L²(ℝ)` at `z = ±i` satisfies the differential equation
`u'' = (V − z)u` in the sense of distributions.  The regularity toolkit of
`BookProof/ChapterWeakSecondDerivative.lean` upgrades it to a genuine `C²` solution `W`
with `u = W` almost everywhere, and then

`(|W|²)'' = 2 Re(conj W · W'') + 2|W'|² = 2 (V − Re z)|W|² + 2|W'|² ≥ 0`

because `Re z = 0` and `V ≥ 0`.  So `|W|²` is a **convex**, non-negative and *integrable*
function on the whole line — and such a function vanishes identically
(`eq_zero_of_convexOn_nonneg_integrable`: convexity forces
`F(a−s) + F(a+s) ≥ 2F(a)`, so `2 F(a) R ≤ ∫ F` for every `R`).  Hence `u = 0`, both
deficiency spaces are trivial and the operator is essentially self-adjoint.

## What is proved

* `eq_zero_of_convexOn_nonneg_integrable` — a non-negative integrable convex function on
  `ℝ` is zero;
* `ode_solution_eq_zero` — the ODE step: an `L²` solution of `W'' = (V − z)W` with `V ≥ 0`
  and `Re z = 0` vanishes;
* `wallHam` — the operator `−d²/dφ² + V` on the compactly supported smooth core of `L²(ℝ)`,
  with `wallHam_symmetricOn`;
* `wallHam_weak_eq` — the deficiency equation in distributional form;
* **`wallHam_essentiallySelfAdjoint`** — essential self-adjointness for *every* smooth
  `V ≥ 0`, with no growth hypothesis whatsoever;
* `starobinskyWall_esa` — the scalaron instance, and `starobinskyWall_stone_flow` its
  unitary group `e^{−itH}`.
-/

namespace BookProof.ScalaronWallEsa

open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

/-! ## 1. A non-negative integrable convex function on the line vanishes -/

/-- **A non-negative, integrable, convex function on `ℝ` is identically zero.**  Convexity
gives `F(a−s) + F(a+s) ≥ 2F(a)`; integrating over `s ∈ [0, R]` bounds `2 F(a) R` by the total
integral for every `R`, which forces `F(a) = 0`. -/
theorem eq_zero_of_convexOn_nonneg_integrable {F : ℝ → ℝ} (hconv : ConvexOn ℝ univ F)
    (hnn : ∀ x, 0 ≤ F x) (hint : Integrable F volume) (a : ℝ) : F a = 0 := by
  by_contra hne
  have hpos : 0 < F a := lt_of_le_of_ne (hnn a) (Ne.symm hne)
  set C := ∫ x, F x with hCdef
  have hC0 : 0 ≤ C := integral_nonneg fun x => hnn x
  have hmid : ∀ s : ℝ, 2 * F a ≤ F (a - s) + F (a + s) := by
    intro s
    have h := hconv.2 (mem_univ (a - s)) (mem_univ (a + s)) (by norm_num : (0:ℝ) ≤ 1/2)
      (by norm_num : (0:ℝ) ≤ 1/2) (by norm_num)
    simp only [smul_eq_mul] at h
    have hmid' : (1/2 : ℝ) * (a - s) + (1/2) * (a + s) = a := by ring
    rw [hmid'] at h
    linarith
  have hkey : ∀ R : ℝ, 0 < R → 2 * F a * R ≤ C := by
    intro R hR
    have hi1 : IntervalIntegrable (fun s => F (a - s)) volume 0 R :=
      (hint.comp_sub_left a).intervalIntegrable
    have hi2 : IntervalIntegrable (fun s => F (a + s)) volume 0 R :=
      (hint.comp_add_left a).intervalIntegrable
    have hmono : ∫ s in (0:ℝ)..R, (2 * F a) ≤ ∫ s in (0:ℝ)..R, (F (a - s) + F (a + s)) :=
      intervalIntegral.integral_mono_on hR.le _root_.intervalIntegrable_const (hi1.add hi2)
        (fun s _ => hmid s)
    rw [intervalIntegral.integral_add hi1 hi2, intervalIntegral.integral_comp_sub_left F a,
      intervalIntegral.integral_comp_add_left F a] at hmono
    simp only [sub_zero, add_zero, intervalIntegral.integral_const, smul_eq_mul] at hmono
    have hadj : (∫ x in (a - R)..a, F x) + ∫ x in a..(a + R), F x = ∫ x in (a-R)..(a+R), F x :=
      intervalIntegral.integral_add_adjacent_intervals hint.intervalIntegrable
        hint.intervalIntegrable
    rw [hadj] at hmono
    have hle : (∫ x in (a-R)..(a+R), F x) ≤ C := by
      rw [intervalIntegral.integral_of_le (by linarith)]
      exact setIntegral_le_integral hint (Filter.Eventually.of_forall fun x => hnn x)
    nlinarith
  have h2 := hkey ((C + 1) / (2 * F a)) (by positivity)
  rw [mul_div_cancel₀] at h2
  · linarith
  · positivity

/-! ## 2. The ODE step -/

/-- **The ODE step.**  A twice differentiable solution of `W'' = (V − z)W` with a
non-negative potential `V`, a purely imaginary `z` and `|W|² ∈ L¹` vanishes identically:
`|W|²` is convex (its second derivative is `2(V|W|² + |W'|²) ≥ 0`), non-negative and
integrable. -/
theorem ode_solution_eq_zero {V : ℝ → ℝ} (hVnn : ∀ x, 0 ≤ V x) {z : ℂ} (hz : z.re = 0)
    {W W' : ℝ → ℂ} (hW : ∀ x, HasDerivAt W (W' x) x)
    (hW' : ∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x)
    (hint : Integrable (fun x => ‖W x‖ ^ 2) volume) :
    ∀ x, W x = 0 := by
  have hdp : ∀ x, HasDerivAt (fun y => (W y).re) ((W' x).re) x := fun x =>
    Complex.reCLM.hasFDerivAt.comp_hasDerivAt x (hW x)
  have hdq : ∀ x, HasDerivAt (fun y => (W y).im) ((W' x).im) x := fun x =>
    Complex.imCLM.hasFDerivAt.comp_hasDerivAt x (hW x)
  have hdp' : ∀ x, HasDerivAt (fun y => (W' y).re) (((((V x : ℝ) : ℂ) - z) * W x).re) x := fun x =>
    Complex.reCLM.hasFDerivAt.comp_hasDerivAt x (hW' x)
  have hdq' : ∀ x, HasDerivAt (fun y => (W' y).im) (((((V x : ℝ) : ℂ) - z) * W x).im) x := fun x =>
    Complex.imCLM.hasFDerivAt.comp_hasDerivAt x (hW' x)
  have hdF : ∀ x, HasDerivAt (fun y => (W y).re ^ 2 + (W y).im ^ 2)
      (2 * (W x).re * (W' x).re + 2 * (W x).im * (W' x).im) x := by
    intro x
    have h1 : HasDerivAt (fun y => (W y).re ^ 2) (2 * (W x).re * (W' x).re) x := by
      simpa [mul_comm, mul_assoc, mul_left_comm] using (hdp x).pow 2
    have h2 : HasDerivAt (fun y => (W y).im ^ 2) (2 * (W x).im * (W' x).im) x := by
      simpa [mul_comm, mul_assoc, mul_left_comm] using (hdq x).pow 2
    exact h1.add h2
  have hdG : ∀ x, HasDerivAt (fun y => 2 * (W y).re * (W' y).re + 2 * (W y).im * (W' y).im)
      (2 * ((W' x).re ^ 2 + (W' x).im ^ 2) + 2 * V x * ((W x).re ^ 2 + (W x).im ^ 2)) x := by
    intro x
    have hsum := (((hdp x).const_mul (2:ℝ)).mul (hdp' x)).add
      (((hdq x).const_mul (2:ℝ)).mul (hdq' x))
    have hval : 2 * (W' x).re * (W' x).re + 2 * (W x).re * ((((V x : ℝ) : ℂ) - z) * W x).re
        + (2 * (W' x).im * (W' x).im + 2 * (W x).im * ((((V x : ℝ) : ℂ) - z) * W x).im)
        = 2 * ((W' x).re ^ 2 + (W' x).im ^ 2) + 2 * V x * ((W x).re ^ 2 + (W x).im ^ 2) := by
      simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im,
        Complex.ofReal_re, Complex.ofReal_im, hz]
      ring
    rw [← hval]
    exact hsum
  have hFconv : ConvexOn ℝ univ (fun y => (W y).re ^ 2 + (W y).im ^ 2) := by
    have h1 : deriv (fun y => (W y).re ^ 2 + (W y).im ^ 2)
        = fun y => 2 * (W y).re * (W' y).re + 2 * (W y).im * (W' y).im :=
      funext fun x => (hdF x).deriv
    refine convexOn_univ_of_deriv2_nonneg (fun x => (hdF x).differentiableAt) ?_ ?_
    · rw [h1]; exact fun x => (hdG x).differentiableAt
    · intro x
      have h2 : deriv^[2] (fun y => (W y).re ^ 2 + (W y).im ^ 2)
          = deriv fun y => 2 * (W y).re * (W' y).re + 2 * (W y).im * (W' y).im := by
        simp [Function.iterate_succ, h1]
      rw [h2, (hdG x).deriv]
      have := hVnn x
      positivity
  have hFnn : ∀ x, 0 ≤ (W x).re ^ 2 + (W x).im ^ 2 := fun x => by positivity
  have hFint : Integrable (fun y => (W y).re ^ 2 + (W y).im ^ 2) volume := by
    refine hint.congr (Filter.Eventually.of_forall fun x => ?_)
    change ‖W x‖ ^ 2 = (W x).re ^ 2 + (W x).im ^ 2
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; ring
  intro x
  have hzero := eq_zero_of_convexOn_nonneg_integrable hFconv hFnn hFint x
  have hn : Complex.normSq (W x) = 0 := by
    rw [Complex.normSq_apply]; nlinarith [hzero]
  exact Complex.normSq_eq_zero.1 hn

/-! ## 3. The Schrödinger operator on the compactly supported smooth core of `L²(ℝ)` -/

/-- The one-dimensional kinetic operator `−d²/dx²` on Schwartz space. -/
def kinOpR : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  constCoeffOp (fun _ : Fin 1 => (-1 : ℝ)) (fun _ : Fin 1 => (1 : ℝ)) 0

lemma kinOpR_apply (f : 𝓢(ℝ, ℂ)) (x : ℝ) :
    (kinOpR f) x = -deriv (deriv (f : ℝ → ℂ)) x := by
  have h : kinOpR f
      = (∑ _i : Fin 1, ((-1 : ℝ) : ℂ) • secondDeriv (1 : ℝ) f) + ((0 : ℝ) : ℂ) • f := by
    simp [kinOpR, constCoeffOp]
  rw [h]
  simp [secondDeriv]
  rfl

/-- The kinetic term on the compactly supported smooth core of `L²(ℝ)`. -/
def kinCcR : ccDomain ℝ →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ) :=
  opL2 kinOpR ∘ₗ Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ))

/-- **The Schrödinger operator `−d²/dx² + V`** on the compactly supported smooth core of
`L²(ℝ)`, for an arbitrary smooth real potential. -/
def wallHam (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) :
    ccDomain ℝ →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ) :=
  kinCcR + opCc V hV

theorem kinCcR_symmetricOn : SymmetricOn (ccDomain ℝ) kinCcR :=
  symmetricOn_inclusion _ _ (constCoeffOp_symmetric _ _ _)

theorem wallHam_symmetricOn (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) :
    SymmetricOn (ccDomain ℝ) (wallHam V hV) := by
  intro x y
  have h1 := kinCcR_symmetricOn x y
  have h2 := smoothPotential_symmetric V hV x y
  simp only [wallHam, LinearMap.add_apply, inner_add_left, inner_add_right]
  linear_combination h1 + h2

/-! ## 4. The deficiency equation in distributional form -/

/-- The complexification of a real function differentiates componentwise. -/
lemma deriv_ofReal_comp {g : ℝ → ℝ} (hg : Differentiable ℝ g) :
    deriv (fun y => ((g y : ℝ) : ℂ)) = fun x => ((deriv g x : ℝ) : ℂ) :=
  funext fun x => ((hg x).hasDerivAt.ofReal_comp).deriv

/-- A real test function, viewed as an element of the compactly supported smooth core. -/
def testCc {g : ℝ → ℝ} (hg : IsTestFun g) : ccSchwartz ℝ :=
  ⟨(HasCompactSupport.comp_left (g := fun r : ℝ => (r : ℂ)) hg.hasCompactSupport
      (by simp)).toSchwartzMap (Complex.ofRealCLM.contDiff.comp hg.contDiff),
    HasCompactSupport.comp_left (g := fun r : ℝ => (r : ℂ)) hg.hasCompactSupport (by simp)⟩

@[simp] lemma testCc_apply {g : ℝ → ℝ} (hg : IsTestFun g) (x : ℝ) :
    ((testCc hg : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x = ((g x : ℝ) : ℂ) := rfl

/-- **The deficiency equation of `−d²/dx² + V`, tested against real test functions.**  This
is exactly the hypothesis of the regularity theorem
`BookProof.WeakSecondDeriv.exists_deriv2_of_weak_eq` for the coefficient `V − z`. -/
theorem wallHam_weak_eq (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ)
    (u : Lp ℂ 2 (volume : Measure ℝ))
    (hu : ∀ v : ccDomain ℝ,
      (inner ℂ (wallHam V hV v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    {g : ℝ → ℝ} (hg : IsTestFun g) :
    ∫ x, ((deriv (deriv g) x : ℝ) : ℂ) * u x
      = ∫ x, ((g x : ℝ) : ℂ) * ((((V x : ℝ) : ℂ) - z) * u x) := by
  set ψ : ccSchwartz ℝ := testCc hg with hψ
  have hψx : ∀ x, ((ψ : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x = ((g x : ℝ) : ℂ) := fun _ => rfl
  -- the kinetic part of the pairing
  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ)) (ccEquiv ℝ ψ)
      = schwartzEquiv ℝ (ψ : 𝓢(ℝ, ℂ)) := Subtype.ext rfl
  have hkin : kinCcR (ccEquiv ℝ ψ) = (kinOpR (ψ : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ) := by
    simp only [kinCcR, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
  have hd2 : deriv (deriv ((ψ : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) = fun x => ((deriv (deriv g) x : ℝ) : ℂ) := by
    have he : ((ψ : 𝓢(ℝ, ℂ)) : ℝ → ℂ) = fun y => ((g y : ℝ) : ℂ) := funext hψx
    rw [he, deriv_ofReal_comp hg.differentiable, deriv_ofReal_comp hg.deriv.differentiable]
  have hkinint : (inner ℂ (kinCcR (ccEquiv ℝ ψ)) u : ℂ)
      = -∫ x, ((deriv (deriv g) x : ℝ) : ℂ) * u x := by
    rw [hkin, inner_toLp_left, ← integral_neg]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    change (starRingEnd ℂ) ((kinOpR (ψ : 𝓢(ℝ, ℂ))) x) * u x
      = -(((deriv (deriv g) x : ℝ) : ℂ) * u x)
    rw [kinOpR_apply, hd2]
    simp
  -- the potential part of the pairing
  have hpot : (inner ℂ (opCc V hV (ccEquiv ℝ ψ)) u : ℂ)
      = ∫ x, ((V x : ℝ) : ℂ) * (((g x : ℝ) : ℂ) * u x) := by
    rw [opCc_apply, inner_toLp_left]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [mulCc_apply, hψx, map_mul, Complex.conj_ofReal]
    ring
  have hplain : (inner ℂ ((ccEquiv ℝ ψ : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) u : ℂ)
      = ∫ x, ((g x : ℝ) : ℂ) * u x := by
    rw [ccEquiv_coe, inner_toLp_left]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp [hψx]
  -- integrability
  have hint1 : Integrable (fun x => ((g x : ℝ) : ℂ) * u x) (volume : Measure ℝ) := by
    have := integrable_conj_schwartz_mul (ψ : 𝓢(ℝ, ℂ)) u
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp [hψx]
  have hint2 : Integrable (fun x => ((V x : ℝ) : ℂ) * (((g x : ℝ) : ℂ) * u x))
      (volume : Measure ℝ) := by
    have := integrable_conj_schwartz_mul (mulCc V hV ψ) u
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [mulCc_apply, hψx, map_mul, Complex.conj_ofReal]
    ring
  have h1 := hu (ccEquiv ℝ ψ)
  simp only [wallHam, LinearMap.add_apply, inner_add_left, hkinint, hpot, hplain] at h1
  have hsplit : ∫ x, ((g x : ℝ) : ℂ) * ((((V x : ℝ) : ℂ) - z) * u x)
      = (∫ x, ((V x : ℝ) : ℂ) * (((g x : ℝ) : ℂ) * u x))
        - z * ∫ x, ((g x : ℝ) : ℂ) * u x := by
    rw [← MeasureTheory.integral_const_mul, ← integral_sub hint2 (hint1.const_mul z)]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  rw [hsplit]
  linear_combination -h1

/-! ## 5. Essential self-adjointness -/

/-- **Trivial deficiency spaces at `±i` for every smooth non-negative potential.** -/
theorem wallHam_deficiencyTrivialAt (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    (hVnn : ∀ x, 0 ≤ V x) {z : ℂ} (hz : z.re = 0) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z := by
  intro u hu
  have hloc : LocallyIntegrable (fun x => (u x : ℂ)) (volume : Measure ℝ) :=
    (Lp.memLp u).locallyIntegrable (by norm_num)
  have hc : Continuous fun x : ℝ => ((V x : ℝ) : ℂ) - z :=
    (Complex.continuous_ofReal.comp hV.continuous).sub continuous_const
  obtain ⟨W, W', hW, hW', hWae⟩ :=
    exists_deriv2_of_weak_eq hloc hc (fun g hg => wallHam_weak_eq V hV z u hu hg)
  have hintu : Integrable (fun x => ‖u x‖ ^ 2) (volume : Measure ℝ) :=
    (memLp_two_iff_integrable_sq_norm (Lp.aestronglyMeasurable u)).1 (Lp.memLp u)
  have hintW : Integrable (fun x => ‖W x‖ ^ 2) (volume : Measure ℝ) := by
    refine hintu.congr ?_
    filter_upwards [hWae] with x hx
    rw [hx]
  have hzero := ode_solution_eq_zero hVnn hz hW hW' hintW
  refine Lp.eq_zero_iff_ae_eq_zero.mpr ?_
  filter_upwards [hWae] with x hx
  simp [hx, hzero x]

/-- **The main theorem: `−d²/dx² + V` is essentially self-adjoint on the compactly supported
smooth core of `L²(ℝ)` for every smooth non-negative potential `V`** — with no growth
hypothesis at all, so in particular for an exponentially growing wall.  No perturbative
comparison with the harmonic oscillator is involved. -/
theorem wallHam_essentiallySelfAdjoint (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    (hVnn : ∀ x, 0 ≤ V x) :
    EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) :=
  ⟨wallHam_deficiencyTrivialAt V hV hVnn (by simp),
    wallHam_deficiencyTrivialAt V hV hVnn (by simp)⟩

/-! ## 6. The scalaron wall -/

/-- **The scalaron Hamiltonian `−d²/dφ² + V(φ)` of the Starobinsky `R + αR²` model is
essentially self-adjoint** on the compactly supported smooth core of `L²(ℝ)`.  This is the
step that the perturbative routes cannot reach: the wall grows exponentially as `φ → −∞`
(`starobinskyV_not_hasTemperateGrowth`), but it is non-negative, and non-negativity is all
the convexity argument needs. -/
theorem starobinskyWall_esa {M alpha : ℝ} (halpha : 0 < alpha) :
    EssentiallySelfAdjointOn (ccDomain ℝ)
      (wallHam (fun phi : ℝ => starobinskyV M alpha phi) (contDiff_starobinskyV M alpha)) :=
  wallHam_essentiallySelfAdjoint _ _ (fun phi => starobinskyV_nonneg halpha phi)

/-- **The unitary flow of the scalaron Hamiltonian.**  Essential self-adjointness on a dense
core selects one self-adjoint extension, and Stone's theorem turns it into the strongly
continuous unitary group `e^{−itH}` solving the Schrödinger equation globally in time. -/
theorem starobinskyWall_stone_flow {M alpha : ℝ} (halpha : 0 < alpha) :
    ∃ (T : UnboundedSelfAdjoint (Lp ℂ 2 (volume : Measure ℝ)))
      (U : ℝ → (Lp ℂ 2 (volume : Measure ℝ) →L[ℂ] Lp ℂ 2 (volume : Measure ℝ))),
      IsSelfAdjointExtension
          (wallHam (fun phi : ℝ => starobinskyV M alpha phi)
            (contDiff_starobinskyV M alpha)) T.op ∧
        IsStoneFlow T U :=
  exists_stone_flow_of_esa _ ccDomain_dense (wallHam_symmetricOn _ _) (starobinskyWall_esa halpha)

end

end BookProof.ScalaronWallEsa
