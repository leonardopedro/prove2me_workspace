import Mathlib

/-!
# One-dimensional distributional regularity: `u'' = c·u` in the weak sense

`CONSOLIDATED_PLAN.md` §10.6.1/§10.6.2 leaves one gap of the quantum-gravity chapter open:
the *exponentially growing* scalaron wall.  Every route the project has tried so far is a
perturbative one — Kato–Rellich on the Gauss–polynomial core, the Carleman flux criterion
on the Hermite lattice — and both are refuted or inapplicable for a wall that grows faster
than every polynomial (`BookProof/ChapterHermiteExpWall.lean`).

The classical route that *does* reach an arbitrarily fast growing **non-negative** potential
is not perturbative at all: a deficiency vector `u` of `−d²/dx² + V` solves the ordinary
differential equation `u'' = (V − z)u`, and a non-negative `V` makes `|u|²` convex — hence,
being integrable and non-negative, zero.  The step that has to be supplied before the ODE
argument can start is *regularity*: the deficiency vector is a priori only an `L²` function
and the equation it satisfies is a distributional one.

This module supplies exactly that step, in one variable, with no reference to the physics:

* `exists_antideriv` — a test function of vanishing integral is the derivative of a test
  function (the elementary fact that makes the du Bois-Reymond argument work);
* `ae_eq_const_of_integral_deriv_smul_eq_zero` — **du Bois-Reymond**: a locally integrable
  function orthogonal to the derivative of every test function is a.e. constant;
* `ae_eq_affine_of_integral_deriv2_smul_eq_zero` — the second-order version: orthogonal to
  every *second* derivative means a.e. affine;
* `integral_deriv_mul_indefiniteIntegral` — integration by parts against an indefinite
  integral of a merely locally integrable function (through Mathlib's
  `AbsolutelyContinuousOnInterval` calculus, since such a primitive is differentiable only
  almost everywhere);
* `exists_ae_eq_doubleAntideriv_add_affine` — the real-valued regularity theorem: a weak
  solution of `u'' = G` is a.e. the double antiderivative of `G` plus an affine function;
* **`exists_deriv2_of_weak_eq`** — the complex-valued statement in the form the Schrödinger
  argument consumes: if `u` is locally integrable, `c` is continuous and `∫ g'' u = ∫ g c u`
  for every real test function `g`, then `u` agrees almost everywhere with a genuinely twice
  differentiable `W` satisfying `W'' = c·W` *everywhere*.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.WeakSecondDeriv

open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

/-- A **test function** on the line: smooth and compactly supported. -/
def IsTestFun (g : ℝ → ℝ) : Prop :=
  ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g ∧ HasCompactSupport g

namespace IsTestFun

theorem contDiff {g : ℝ → ℝ} (h : IsTestFun g) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g := h.1

theorem hasCompactSupport {g : ℝ → ℝ} (h : IsTestFun g) : HasCompactSupport g := h.2

theorem continuous {g : ℝ → ℝ} (h : IsTestFun g) : Continuous g := h.contDiff.continuous

theorem differentiable {g : ℝ → ℝ} (h : IsTestFun g) : Differentiable ℝ g :=
  (contDiff_infty_iff_deriv.1 h.contDiff).1

/-- The derivative of a test function is a test function. -/
theorem deriv {g : ℝ → ℝ} (h : IsTestFun g) : IsTestFun (_root_.deriv g) :=
  ⟨(contDiff_infty_iff_deriv.1 h.contDiff).2, h.hasCompactSupport.deriv⟩

theorem integrable {g : ℝ → ℝ} (h : IsTestFun g) : Integrable g volume :=
  h.continuous.integrable_of_hasCompactSupport h.hasCompactSupport

theorem sub {f g : ℝ → ℝ} (h1 : IsTestFun f) (h2 : IsTestFun g) :
    IsTestFun (fun x => f x - g x) := ⟨h1.contDiff.sub h2.contDiff, h1.2.sub h2.2⟩

theorem const_mul {g : ℝ → ℝ} (h : IsTestFun g) (a : ℝ) : IsTestFun (fun x => a * g x) :=
  ⟨contDiff_const.mul h.contDiff, h.hasCompactSupport.mul_left⟩

/-- Multiplying a test function by the coordinate gives a test function. -/
theorem coord_mul {g : ℝ → ℝ} (h : IsTestFun g) : IsTestFun (fun x => x * g x) :=
  ⟨contDiff_id.mul h.contDiff, h.hasCompactSupport.mul_left⟩

end IsTestFun

/-! ## 1. Elementary facts about test functions -/

/-- There is a test function of integral one. -/
theorem exists_unitTest : ∃ ρ : ℝ → ℝ, IsTestFun ρ ∧ ∫ x, ρ x = 1 := by
  let f : ContDiffBump (0 : ℝ) := ⟨1, 2, one_pos, one_lt_two⟩
  exact ⟨f.normed volume, ⟨f.contDiff_normed, f.hasCompactSupport_normed⟩, f.integral_normed⟩

/-- A test function has its support in a symmetric compact interval. -/
theorem exists_supp {g : ℝ → ℝ} (h : IsTestFun g) :
    ∃ R : ℝ, 0 ≤ R ∧ tsupport g ⊆ Icc (-R) R := by
  obtain ⟨R, hR⟩ := (h.hasCompactSupport.isCompact.isBounded).subset_closedBall (0 : ℝ)
  refine ⟨|R|, abs_nonneg R, fun x hx => ?_⟩
  have hx' := hR hx
  rw [Real.closedBall_eq_Icc] at hx'
  simp only [zero_sub, zero_add, mem_Icc] at hx' ⊢
  exact ⟨by linarith [le_abs_self R, hx'.1], by linarith [le_abs_self R, hx'.2]⟩

theorem eq_zero_out {g : ℝ → ℝ} {R : ℝ} (hsupp : tsupport g ⊆ Icc (-R) R)
    {x : ℝ} (hx : x ∉ Icc (-R) R) : g x = 0 :=
  image_eq_zero_of_notMem_tsupport (fun h => hx (hsupp h))

theorem deriv_eq_zero_out {g : ℝ → ℝ} {R : ℝ} (hsupp : tsupport g ⊆ Icc (-R) R)
    {x : ℝ} (hx : x ∉ Icc (-R) R) : deriv g x = 0 := by
  by_contra hne
  exact hx (hsupp (support_deriv_subset (by exact hne)))

/-- An integral over the line of a function vanishing outside `[-R, R]` is an interval
integral. -/
theorem integral_eq_intervalIntegral {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F]
    {f : ℝ → F} {R a b : ℝ} (hR : 0 ≤ R)
    (hf : ∀ x, x ∉ Icc (-R) R → f x = 0) (ha : a < -R) (hb : R < b) :
    ∫ x, f x = ∫ x in a..b, f x := by
  have hab : a ≤ b := by linarith
  rw [intervalIntegral.integral_of_le hab, setIntegral_eq_integral_of_forall_compl_eq_zero]
  intro x hx
  simp only [mem_Ioc, not_and_or, not_lt, not_le] at hx
  refine hf x ?_
  simp only [mem_Icc, not_and_or, not_le]
  rcases hx with h | h
  · exact Or.inl (by linarith)
  · exact Or.inr (by linarith)

/-- The integral of the derivative of a test function vanishes. -/
theorem integral_deriv_of_test {g : ℝ → ℝ} (h : IsTestFun g) : ∫ x, deriv g x = 0 := by
  obtain ⟨R, hR, hsupp⟩ := exists_supp h
  rw [integral_eq_intervalIntegral (R := R) (a := -R - 1) (b := R + 1) hR
    (fun x hx => deriv_eq_zero_out hsupp hx) (by linarith) (by linarith)]
  rw [intervalIntegral.integral_deriv_eq_sub (fun x _ => h.differentiable x)
    (h.deriv.continuous.intervalIntegrable _ _)]
  rw [eq_zero_out hsupp (by simp), eq_zero_out (x := -R - 1) hsupp (by simp)]
  ring

/-- **A test function of vanishing integral is a derivative.** -/
theorem exists_antideriv {g : ℝ → ℝ} (h : IsTestFun g) (h0 : ∫ x, g x = 0) :
    ∃ G : ℝ → ℝ, IsTestFun G ∧ deriv G = g := by
  obtain ⟨R, hR, hsupp⟩ := exists_supp h
  set G : ℝ → ℝ := fun x => ∫ t in (-R - 1)..x, g t with hG
  have hderiv : ∀ x, HasDerivAt G (g x) x := fun x =>
    intervalIntegral.integral_hasDerivAt_right (h.continuous.intervalIntegrable _ _)
      (h.continuous.stronglyMeasurableAtFilter _ _) h.continuous.continuousAt
  have hdG : deriv G = g := funext fun x => (hderiv x).deriv
  refine ⟨G, ⟨?_, ?_⟩, hdG⟩
  · rw [contDiff_infty_iff_deriv]
    exact ⟨fun x => (hderiv x).differentiableAt, by rw [hdG]; exact h.contDiff⟩
  · apply HasCompactSupport.intro (isCompact_Icc (a := -R - 1) (b := R + 1))
    intro x hx
    simp only [mem_Icc, not_and_or, not_le] at hx
    rcases hx with hx | hx
    · have hz : G x = ∫ _t in (-R - 1)..x, (0 : ℝ) := by
        refine intervalIntegral.integral_congr fun t ht => ?_
        rw [uIcc_comm, uIcc_of_le (by linarith)] at ht
        refine eq_zero_out hsupp ?_
        simp only [mem_Icc, not_and_or, not_le]
        exact Or.inl (by linarith [ht.2])
      simpa using hz
    · change (∫ t in (-R - 1)..x, g t) = 0
      rw [← integral_eq_intervalIntegral (R := R) hR (fun y hy => eq_zero_out hsupp hy)
        (by linarith) (by linarith)]
      exact h0

/-- The integral of a test function is minus the first moment of its derivative. -/
theorem integral_eq_neg_integral_coord_mul_deriv {g : ℝ → ℝ} (h : IsTestFun g) :
    ∫ x, g x = -∫ x, x * deriv g x := by
  have hd : deriv (fun x => x * g x) = fun x => g x + x * deriv g x := by
    funext x
    have h1 : HasDerivAt (fun x : ℝ => x * g x) (1 * g x + x * deriv g x) x :=
      (hasDerivAt_id x).mul (h.differentiable x).hasDerivAt
    rw [h1.deriv]; ring
  have h0 := integral_deriv_of_test h.coord_mul
  rw [hd] at h0
  rw [integral_add h.integrable h.deriv.coord_mul.integrable] at h0
  linarith

/-! ## 2. The du Bois-Reymond lemmas -/

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]


omit [CompleteSpace F] in
/-- A test function times a locally integrable function is integrable. -/
theorem integrable_test_smul {φ : ℝ → ℝ} (hφ : IsTestFun φ) {r : ℝ → F}
    (hr : LocallyIntegrable r volume) : Integrable (fun x => φ x • r x) volume := by
  refine (integrableOn_iff_integrable_of_support_subset (s := tsupport φ) ?_).1 ?_
  · intro x hx
    simp only [Function.mem_support] at hx
    exact subset_tsupport φ (fun h => hx (by simp [h]))
  · exact (hr.integrableOn_isCompact hφ.hasCompactSupport.isCompact).continuousOn_smul
      hφ.continuous.continuousOn hφ.hasCompactSupport.isCompact

/-- **Du Bois-Reymond.**  A locally integrable function that integrates to zero against the
derivative of every test function is almost everywhere constant. -/
theorem ae_eq_const_of_integral_deriv_smul_eq_zero {r : ℝ → F}
    (hr : LocallyIntegrable r volume)
    (h : ∀ g : ℝ → ℝ, IsTestFun g → ∫ x, deriv g x • r x = 0) :
    ∃ c : F, r =ᵐ[volume] fun _ => c := by
  obtain ⟨ρ, hρ, hρ1⟩ := exists_unitTest
  set c : F := ∫ x, ρ x • r x with hc
  have key : ∀ φ : ℝ → ℝ, IsTestFun φ → ∫ x, φ x • r x = (∫ x, φ x) • c := by
    intro φ hφ
    set I := ∫ x, φ x with hI
    have hIρ : IsTestFun (fun x => I * ρ x) := hρ.const_mul I
    have hψ : IsTestFun (fun x => φ x - I * ρ x) := hφ.sub hIρ
    have hψ0 : ∫ x, (φ x - I * ρ x) = 0 := by
      rw [integral_sub hφ.integrable hIρ.integrable, MeasureTheory.integral_const_mul, hρ1]
      simp [hI]
    obtain ⟨G, hG, hdG⟩ := exists_antideriv hψ hψ0
    have h1 := h G hG
    rw [hdG] at h1
    have hint2 : Integrable (fun x => I • (ρ x • r x)) volume :=
      (integrable_test_smul hρ hr).smul I
    have h2 : ∫ x, ((fun x => φ x - I * ρ x) x) • r x = (∫ x, φ x • r x) - I • c := by
      have he : ∀ x, (φ x - I * ρ x) • r x = φ x • r x - I • (ρ x • r x) := by
        intro x; rw [sub_smul, smul_smul]
      simp_rw [he]
      rw [integral_sub (integrable_test_smul hφ hr) hint2, MeasureTheory.integral_smul]
    rw [h2] at h1
    exact sub_eq_zero.mp h1
  refine ⟨c, ?_⟩
  have hloc : LocallyIntegrable (fun x => r x - c) volume := hr.sub (locallyIntegrable_const c)
  have hz := ae_eq_zero_of_integral_contDiff_smul_eq_zero hloc (fun g hg1 hg2 => ?_)
  · filter_upwards [hz] with x hx
    simpa [sub_eq_zero] using hx
  · have hg : IsTestFun g := ⟨hg1, hg2⟩
    have he : ∀ x, g x • (r x - c) = g x • r x - g x • c := fun x => by rw [smul_sub]
    simp_rw [he]
    rw [integral_sub (integrable_test_smul hg hr) (hg.integrable.smul_const c),
      _root_.integral_smul_const, key g hg]
    module

/-- **Du Bois-Reymond, second order.**  A locally integrable function that integrates to
zero against the second derivative of every test function is almost everywhere affine. -/
theorem ae_eq_affine_of_integral_deriv2_smul_eq_zero {r : ℝ → F}
    (hr : LocallyIntegrable r volume)
    (h : ∀ g : ℝ → ℝ, IsTestFun g → ∫ x, deriv (deriv g) x • r x = 0) :
    ∃ a b : F, r =ᵐ[volume] fun x => x • a + b := by
  obtain ⟨ρ, hρ, hρ1⟩ := exists_unitTest
  set k : F := ∫ x, deriv ρ x • r x with hk
  -- for every test function `ψ`, `∫ ψ' • r = (∫ ψ) • k`
  have key : ∀ ψ : ℝ → ℝ, IsTestFun ψ → ∫ x, deriv ψ x • r x = (∫ x, ψ x) • k := by
    intro ψ hψ
    set I := ∫ x, ψ x with hI
    have hIρ : IsTestFun (fun x => I * ρ x) := hρ.const_mul I
    have hχ : IsTestFun (fun x => ψ x - I * ρ x) := hψ.sub hIρ
    have hχ0 : ∫ x, (ψ x - I * ρ x) = 0 := by
      rw [integral_sub hψ.integrable hIρ.integrable, MeasureTheory.integral_const_mul, hρ1]
      simp [hI]
    obtain ⟨G, hG, hdG⟩ := exists_antideriv hχ hχ0
    have h1 := h G hG
    rw [hdG] at h1
    have hdχ : deriv (fun x => ψ x - I * ρ x) = fun x => deriv ψ x - I * deriv ρ x := by
      funext x
      have h2 : HasDerivAt (fun x => ψ x - I * ρ x)
          (deriv ψ x - I * deriv ρ x) x :=
        ((hψ.differentiable x).hasDerivAt).sub
          (((hρ.differentiable x).hasDerivAt).const_mul I)
      exact h2.deriv
    rw [hdχ] at h1
    have hint2 : Integrable (fun x => I • (deriv ρ x • r x)) volume :=
      (integrable_test_smul hρ.deriv hr).smul I
    have h2 : ∫ x, (deriv ψ x - I * deriv ρ x) • r x
        = (∫ x, deriv ψ x • r x) - I • k := by
      have he : ∀ x, (deriv ψ x - I * deriv ρ x) • r x
          = deriv ψ x • r x - I • (deriv ρ x • r x) := by
        intro x; rw [sub_smul, smul_smul]
      simp_rw [he]
      rw [integral_sub (integrable_test_smul hψ.deriv hr) hint2, MeasureTheory.integral_smul]
    rw [h2] at h1
    exact sub_eq_zero.mp h1
  -- hence `r + x • k` is orthogonal to every derivative, so it is a.e. constant
  set s : ℝ → F := fun x => r x + x • k with hs
  have hsloc : LocallyIntegrable s volume := by
    refine hr.add ?_
    exact (continuous_id.smul continuous_const).locallyIntegrable
  have hzero : ∀ ψ : ℝ → ℝ, IsTestFun ψ → ∫ x, deriv ψ x • s x = 0 := by
    intro ψ hψ
    have he : ∀ x, deriv ψ x • s x = deriv ψ x • r x + (x * deriv ψ x) • k := by
      intro x
      rw [hs]
      simp only [smul_add, smul_smul]
      rw [mul_comm]
    simp_rw [he]
    rw [integral_add (integrable_test_smul hψ.deriv hr)
      ((hψ.deriv.coord_mul.integrable).smul_const k), _root_.integral_smul_const, key ψ hψ,
      integral_eq_neg_integral_coord_mul_deriv hψ]
    module
  obtain ⟨b, hb⟩ := ae_eq_const_of_integral_deriv_smul_eq_zero hsloc hzero
  refine ⟨-k, b, ?_⟩
  filter_upwards [hb] with x hx
  have : r x + x • k = b := hx
  rw [smul_neg, ← this]
  abel

/-! ## 3. Integration by parts against an indefinite integral -/

/-- The primitive of a locally integrable function is absolutely continuous on every
interval containing the base point. -/
theorem absolutelyContinuous_primitive {G : ℝ → ℝ} (hG : LocallyIntegrable G volume)
    {a b c : ℝ} (hc : c ∈ uIcc a b) :
    AbsolutelyContinuousOnInterval (fun x => ∫ t in c..x, G t) a b :=
  IntervalIntegrable.absolutelyContinuousOnInterval_intervalIntegral
    (hG.integrableOn_isCompact isCompact_uIcc).intervalIntegrable hc

/-- A test function is absolutely continuous on every interval. -/
theorem absolutelyContinuous_test {g : ℝ → ℝ} (hg : IsTestFun g) (a b : ℝ) :
    AbsolutelyContinuousOnInterval g a b := by
  obtain ⟨x₀, hx₀⟩ := hg.deriv.continuous.norm.exists_forall_ge_of_hasCompactSupport
    hg.deriv.hasCompactSupport.norm
  refine (LipschitzWith.lipschitzOnWith (K := ⟨‖deriv g x₀‖, norm_nonneg _⟩)
    (lipschitzWith_of_nnnorm_deriv_le hg.differentiable fun x => ?_)).absolutelyContinuousOnInterval
  rw [← NNReal.coe_le_coe]
  simpa using hx₀ x

/-- **Integration by parts against an indefinite integral.**  For a locally integrable `G`
the primitive `x ↦ ∫_c^x G` is absolutely continuous, so it can be integrated by parts
against a test function although it is differentiable only almost everywhere. -/
theorem integral_deriv_mul_indefiniteIntegral {G : ℝ → ℝ}
    (hG : LocallyIntegrable G volume) (c : ℝ) {g : ℝ → ℝ} (hg : IsTestFun g) :
    ∫ x, deriv g x * (∫ t in c..x, G t) = -∫ x, g x * G x := by
  obtain ⟨R, hR, hsupp⟩ := exists_supp hg
  set A : ℝ → ℝ := fun x => ∫ t in c..x, G t with hA
  set a := min (-R - 1) (c - 1) with hadef
  set b := max (R + 1) (c + 1) with hbdef
  have ha : a < -R := lt_of_le_of_lt (min_le_left _ _) (by linarith)
  have hb : R < b := lt_of_lt_of_le (by linarith) (le_max_left _ _)
  have hab : a ≤ b := by linarith
  have hcmem : c ∈ uIcc a b := by
    rw [uIcc_of_le hab]
    exact ⟨le_trans (min_le_right _ _) (by linarith), le_trans (by linarith) (le_max_right _ _)⟩
  have hga : g a = 0 := by
    refine eq_zero_out hsupp ?_
    simp only [mem_Icc, not_and_or, not_le]
    exact Or.inl (by linarith)
  have hgb : g b = 0 := by
    refine eq_zero_out hsupp ?_
    simp only [mem_Icc, not_and_or, not_le]
    exact Or.inr (by linarith)
  have hL : ∫ x, deriv g x * A x = ∫ x in a..b, deriv g x * A x :=
    integral_eq_intervalIntegral hR
      (fun x hx => by rw [deriv_eq_zero_out hsupp hx, zero_mul]) ha hb
  have hRHS : ∫ x, g x * G x = ∫ x in a..b, g x * G x :=
    integral_eq_intervalIntegral hR
      (fun x hx => by rw [eq_zero_out hsupp hx, zero_mul]) ha hb
  have hby := (absolutelyContinuous_primitive hG hcmem).integral_mul_deriv_eq_deriv_mul
    (absolutelyContinuous_test hg a b)
  have hdA : ∫ x in a..b, deriv A x * g x = ∫ x in a..b, G x * g x := by
    refine intervalIntegral.integral_congr_ae ?_
    filter_upwards [LocallyIntegrable.ae_hasDerivAt_integral hG] with x hx _
    rw [(hx c).deriv]
  rw [hdA, hga, hgb] at hby
  rw [hL, hRHS]
  have hcomm : ∫ x in a..b, deriv g x * A x = ∫ x in a..b, A x * deriv g x := by
    simp_rw [mul_comm]
  have hcomm2 : ∫ x in a..b, G x * g x = ∫ x in a..b, g x * G x := by
    simp_rw [mul_comm]
  rw [hcomm, hby, ← hcomm2]
  ring

/-! ## 4. The real regularity theorem -/

/-- The double antiderivative of a locally integrable function. -/
def doubleAntideriv (G : ℝ → ℝ) (x : ℝ) : ℝ := ∫ t in (0 : ℝ)..x, ∫ s in (0 : ℝ)..t, G s

theorem continuous_primitive_of_locallyIntegrable {G : ℝ → ℝ}
    (hG : LocallyIntegrable G volume) (c : ℝ) :
    Continuous fun x => ∫ t in c..x, G t :=
  intervalIntegral.continuous_primitive
    (fun _ _ => (hG.integrableOn_isCompact isCompact_uIcc).intervalIntegrable) c

/-- The double antiderivative is a weak solution of `u'' = G`. -/
theorem integral_deriv2_mul_doubleAntideriv {G : ℝ → ℝ} (hG : LocallyIntegrable G volume)
    {g : ℝ → ℝ} (hg : IsTestFun g) :
    ∫ x, deriv (deriv g) x * doubleAntideriv G x = ∫ x, g x * G x := by
  have hA : LocallyIntegrable (fun t => ∫ s in (0 : ℝ)..t, G s) volume :=
    (continuous_primitive_of_locallyIntegrable hG 0).locallyIntegrable
  rw [show doubleAntideriv G = fun x => ∫ t in (0 : ℝ)..x, (fun t => ∫ s in (0:ℝ)..t, G s) t from
    rfl, integral_deriv_mul_indefiniteIntegral hA 0 hg.deriv,
    integral_deriv_mul_indefiniteIntegral hG 0 hg]
  ring

/-- **Regularity of weak solutions of `u'' = G`, real case.** -/
theorem exists_ae_eq_doubleAntideriv_add_affine {u G : ℝ → ℝ}
    (hu : LocallyIntegrable u volume) (hG : LocallyIntegrable G volume)
    (h : ∀ g : ℝ → ℝ, IsTestFun g → ∫ x, deriv (deriv g) x * u x = ∫ x, g x * G x) :
    ∃ a b : ℝ, u =ᵐ[volume] fun x => doubleAntideriv G x + (a * x + b) := by
  have hB : Continuous (doubleAntideriv G) := by
    have hA : LocallyIntegrable (fun t => ∫ s in (0 : ℝ)..t, G s) volume :=
      (continuous_primitive_of_locallyIntegrable hG 0).locallyIntegrable
    exact continuous_primitive_of_locallyIntegrable hA 0
  set r : ℝ → ℝ := fun x => u x - doubleAntideriv G x with hr
  have hrloc : LocallyIntegrable r volume := hu.sub hB.locallyIntegrable
  have hzero : ∀ g : ℝ → ℝ, IsTestFun g → ∫ x, deriv (deriv g) x • r x = 0 := by
    intro g hg
    have he : ∀ x, deriv (deriv g) x • r x
        = deriv (deriv g) x * u x - deriv (deriv g) x * doubleAntideriv G x := by
      intro x; simp [hr, smul_eq_mul, mul_sub]
    simp_rw [he]
    have hi1 : Integrable (fun x => deriv (deriv g) x * u x) volume := by
      simpa [smul_eq_mul] using integrable_test_smul (F := ℝ) hg.deriv.deriv hu
    have hi2 : Integrable (fun x => deriv (deriv g) x * doubleAntideriv G x) volume := by
      simpa [smul_eq_mul] using
        integrable_test_smul (F := ℝ) hg.deriv.deriv hB.locallyIntegrable
    rw [integral_sub hi1 hi2, h g hg, integral_deriv2_mul_doubleAntideriv hG hg, sub_self]
  obtain ⟨a, b, hab⟩ := ae_eq_affine_of_integral_deriv2_smul_eq_zero hrloc hzero
  refine ⟨a, b, ?_⟩
  filter_upwards [hab] with x hx
  have : u x - doubleAntideriv G x = x • a + b := hx
  simp only [smul_eq_mul] at this
  linarith [this]

/-! ## 5. Calculus for the double antiderivative -/

/-- The double antiderivative only sees the almost-everywhere class of its argument. -/
theorem doubleAntideriv_congr_ae {G H : ℝ → ℝ} (h : G =ᵐ[volume] H) :
    doubleAntideriv G = doubleAntideriv H := by
  have hinner : ∀ t : ℝ, (∫ s in (0 : ℝ)..t, G s) = ∫ s in (0 : ℝ)..t, H s := by
    intro t
    refine intervalIntegral.integral_congr_ae ?_
    filter_upwards [h] with s hs _ using hs
  funext x
  simp only [doubleAntideriv]
  simp_rw [hinner]

/-- The primitive of a continuous function is differentiable, with the expected derivative. -/
theorem hasDerivAt_primitive_of_continuous {H : ℝ → ℝ} (hH : Continuous H) (x : ℝ) :
    HasDerivAt (fun y => ∫ t in (0 : ℝ)..y, H t) (H x) x :=
  (hH.integral_hasStrictDerivAt 0 x).hasDerivAt

/-- The double antiderivative of a continuous function is differentiable, with the primitive
as derivative. -/
theorem hasDerivAt_doubleAntideriv {H : ℝ → ℝ} (hH : Continuous H) (x : ℝ) :
    HasDerivAt (doubleAntideriv H) (∫ t in (0 : ℝ)..x, H t) x :=
  hasDerivAt_primitive_of_continuous
    (continuous_primitive_of_locallyIntegrable hH.locallyIntegrable 0) x

/-- The double antiderivative of a locally integrable function is continuous. -/
theorem continuous_doubleAntideriv {G : ℝ → ℝ} (hG : LocallyIntegrable G volume) :
    Continuous (doubleAntideriv G) :=
  continuous_primitive_of_locallyIntegrable
    (continuous_primitive_of_locallyIntegrable hG 0).locallyIntegrable 0

/-! ## 6. The complex regularity theorem -/

/-- **Regularity of weak solutions of `u'' = c·u`.**  A locally integrable weak solution of
`u'' = c·u` with a *continuous* coefficient `c` agrees almost everywhere with a genuinely
twice differentiable solution. -/
theorem exists_deriv2_of_weak_eq {u : ℝ → ℂ} (hu : LocallyIntegrable u volume)
    {c : ℝ → ℂ} (hc : Continuous c)
    (h : ∀ g : ℝ → ℝ, IsTestFun g →
      ∫ x, ((deriv (deriv g) x : ℝ) : ℂ) * u x = ∫ x, ((g x : ℝ) : ℂ) * (c x * u x)) :
    ∃ W W' : ℝ → ℂ, (∀ x, HasDerivAt W (W' x) x) ∧
      (∀ x, HasDerivAt W' (c x * W x) x) ∧ u =ᵐ[volume] W := by
  -- the inhomogeneity `P = c·u` is locally integrable
  have hPloc : LocallyIntegrable (fun x => c x * u x) volume := by
    rw [MeasureTheory.locallyIntegrable_iff]
    intro k hk
    simpa [smul_eq_mul] using
      (hu.integrableOn_isCompact hk).continuousOn_smul hc.continuousOn hk
  have hre_loc : ∀ {f : ℝ → ℂ}, LocallyIntegrable f volume →
      LocallyIntegrable (fun x => (f x).re) volume := by
    intro f hf x
    obtain ⟨s, hs, hint⟩ := hf x
    exact ⟨s, hs, hint.re⟩
  have him_loc : ∀ {f : ℝ → ℂ}, LocallyIntegrable f volume →
      LocallyIntegrable (fun x => (f x).im) volume := by
    intro f hf x
    obtain ⟨s, hs, hint⟩ := hf x
    exact ⟨s, hs, hint.im⟩
  have hint_u : ∀ g : ℝ → ℝ, IsTestFun g →
      Integrable (fun x => ((g x : ℝ) : ℂ) * u x) volume := by
    intro g hg
    simpa [Complex.real_smul] using integrable_test_smul (F := ℂ) hg hu
  have hint_P : ∀ g : ℝ → ℝ, IsTestFun g →
      Integrable (fun x => ((g x : ℝ) : ℂ) * (c x * u x)) volume := by
    intro g hg
    simpa [Complex.real_smul] using integrable_test_smul (F := ℂ) hg hPloc
  -- real and imaginary parts of the weak equation
  have hEqRe : ∀ g : ℝ → ℝ, IsTestFun g →
      ∫ x, deriv (deriv g) x * (u x).re = ∫ x, g x * (c x * u x).re := by
    intro g hg
    have e1 : (∫ x, ((deriv (deriv g) x : ℝ) : ℂ) * u x).re
        = ∫ x, deriv (deriv g) x * (u x).re := by
      simpa using (Complex.reCLM.integral_comp_comm (hint_u _ hg.deriv.deriv)).symm
    have e2 : (∫ x, ((g x : ℝ) : ℂ) * (c x * u x)).re = ∫ x, g x * (c x * u x).re := by
      simpa using (Complex.reCLM.integral_comp_comm (hint_P _ hg)).symm
    rw [← e1, ← e2, h g hg]
  have hEqIm : ∀ g : ℝ → ℝ, IsTestFun g →
      ∫ x, deriv (deriv g) x * (u x).im = ∫ x, g x * (c x * u x).im := by
    intro g hg
    have e1 : (∫ x, ((deriv (deriv g) x : ℝ) : ℂ) * u x).im
        = ∫ x, deriv (deriv g) x * (u x).im := by
      simpa using (Complex.imCLM.integral_comp_comm (hint_u _ hg.deriv.deriv)).symm
    have e2 : (∫ x, ((g x : ℝ) : ℂ) * (c x * u x)).im = ∫ x, g x * (c x * u x).im := by
      simpa using (Complex.imCLM.integral_comp_comm (hint_P _ hg)).symm
    rw [← e1, ← e2, h g hg]
  obtain ⟨a₁, b₁, h1⟩ :=
    exists_ae_eq_doubleAntideriv_add_affine (hre_loc hu) (hre_loc hPloc) hEqRe
  obtain ⟨a₂, b₂, h2⟩ :=
    exists_ae_eq_doubleAntideriv_add_affine (him_loc hu) (him_loc hPloc) hEqIm
  obtain ⟨W, hWdef⟩ : ∃ W : ℝ → ℂ, W = fun x =>
      ((doubleAntideriv (fun y => (c y * u y).re) x + (a₁ * x + b₁) : ℝ) : ℂ)
        + ((doubleAntideriv (fun y => (c y * u y).im) x + (a₂ * x + b₂) : ℝ) : ℂ) * Complex.I :=
    ⟨_, rfl⟩
  -- `W` is continuous and almost everywhere equal to `u`
  have haffine : ∀ a b : ℝ, Continuous fun x : ℝ => a * x + b := fun a b =>
    (continuous_const.mul continuous_id).add continuous_const
  have hcW : Continuous W := by
    rw [hWdef]
    exact ((Complex.continuous_ofReal.comp
        ((continuous_doubleAntideriv (hre_loc hPloc)).add (haffine a₁ b₁)))).add
      ((Complex.continuous_ofReal.comp
        ((continuous_doubleAntideriv (him_loc hPloc)).add (haffine a₂ b₂))).mul continuous_const)
  have hWae : u =ᵐ[volume] W := by
    filter_upwards [h1, h2] with x hx1 hx2
    have e : W x = ((u x).re : ℂ) + ((u x).im : ℂ) * Complex.I := by
      rw [hWdef, hx1, hx2]
    rw [e, Complex.re_add_im]
  -- replace the inhomogeneity by the *continuous* function `c·W`
  have hPQ : (fun x => c x * u x) =ᵐ[volume] fun x => c x * W x := by
    filter_upwards [hWae] with x hx
    rw [hx]
  have hQcont : Continuous fun x => c x * W x := hc.mul hcW
  -- name the two real components of `c·W`, so that they no longer mention `W` syntactically
  obtain ⟨Qre, hQredef⟩ : ∃ f : ℝ → ℝ, f = fun x => (c x * W x).re := ⟨_, rfl⟩
  obtain ⟨Qim, hQimdef⟩ : ∃ f : ℝ → ℝ, f = fun x => (c x * W x).im := ⟨_, rfl⟩
  have hQre : Continuous Qre := by
    rw [hQredef]; exact Complex.continuous_re.comp hQcont
  have hQim : Continuous Qim := by
    rw [hQimdef]; exact Complex.continuous_im.comp hQcont
  have hsum : ∀ x, ((Qre x : ℝ) : ℂ) + ((Qim x : ℝ) : ℂ) * Complex.I = c x * W x := by
    intro x
    rw [hQredef, hQimdef]
    exact Complex.re_add_im _
  have hDre : doubleAntideriv (fun y => (c y * u y).re) = doubleAntideriv Qre := by
    refine doubleAntideriv_congr_ae ?_
    filter_upwards [hPQ] with x hx
    rw [hQredef, hx]
  have hDim : doubleAntideriv (fun y => (c y * u y).im) = doubleAntideriv Qim := by
    refine doubleAntideriv_congr_ae ?_
    filter_upwards [hPQ] with x hx
    rw [hQimdef, hx]
  rw [hDre, hDim] at hWdef
  refine ⟨W, fun x =>
    (((∫ t in (0 : ℝ)..x, Qre t) + a₁ : ℝ) : ℂ)
      + (((∫ t in (0 : ℝ)..x, Qim t) + a₂ : ℝ) : ℂ) * Complex.I, ?_, ?_, hWae⟩
  · intro x
    have d1 : HasDerivAt (fun y => doubleAntideriv Qre y + (a₁ * y + b₁))
        ((∫ t in (0 : ℝ)..x, Qre t) + a₁) x := by
      refine (hasDerivAt_doubleAntideriv hQre x).add ?_
      simpa using ((hasDerivAt_id x).const_mul a₁).add_const b₁
    have d2 : HasDerivAt (fun y => doubleAntideriv Qim y + (a₂ * y + b₂))
        ((∫ t in (0 : ℝ)..x, Qim t) + a₂) x := by
      refine (hasDerivAt_doubleAntideriv hQim x).add ?_
      simpa using ((hasDerivAt_id x).const_mul a₂).add_const b₂
    rw [hWdef]
    exact d1.ofReal_comp.add (d2.ofReal_comp.mul_const Complex.I)
  · intro x
    have d1 : HasDerivAt (fun y => (∫ t in (0 : ℝ)..y, Qre t) + a₁) (Qre x) x :=
      (hasDerivAt_primitive_of_continuous hQre x).add_const a₁
    have d2 : HasDerivAt (fun y => (∫ t in (0 : ℝ)..y, Qim t) + a₂) (Qim x) x :=
      (hasDerivAt_primitive_of_continuous hQim x).add_const a₂
    have hd := d1.ofReal_comp.add (d2.ofReal_comp.mul_const Complex.I)
    rw [← hsum x]
    exact hd

end

end BookProof.WeakSecondDeriv
