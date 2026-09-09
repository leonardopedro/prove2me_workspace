import Mathlib
import BookProof.ChapterWallDeficiencyObstruction

/-!
# An explicit smooth real potential whose Schrödinger operator is *not* essentially
# self-adjoint

`BookProof/ChapterScalaronWallEsa.lean` proves that `−d²/dx² + V` is essentially self-adjoint
on the compactly supported smooth core of `L²(ℝ)` for **every** smooth `V ≥ 0`, with no growth
hypothesis.  `CONSOLIDATED_PLAN.md`'s QG-2 sign warning is that the *opposite* sign class is
genuinely different: a potential unbounded below can put the operator in the Weyl limit-circle
regime, where both deficiency indices are positive and essential self-adjointness fails.  The
plan's Case B (the densitized conformal direction) is exactly of that kind, and the plan
records it as **false** — but that was an informal appeal to the classical `−d²/dx² − x⁴`
example.

This module removes the appeal by exhibiting a concrete potential and a concrete deficiency
vector, so the failure is a Lean theorem.

## The construction

Instead of starting from a potential and solving the ODE, we start from the solution.  Write
`W = e^{p + iq}` with `p, q` real; then

`W''/W = (p'' + p'² − q'²) + i(q'' + 2p'q')`,

so `W` solves `W'' = (V − i)W` for the *real* potential `V = p'' + p'² − q'²` as soon as
`q'' + 2p'q' = −1`, and `W ∈ L²` as soon as `e^{2p}` is integrable (the phase `q` is
irrelevant to the modulus).  Choosing

`q'(x) = −(1 + x²)/2`,  hence  `p'(x) = (1 − x)/(1 + x²)`,  `p(x) = arctan x − ½log(1 + x²)`,

makes the imaginary equation an identity, and `e^{2p(x)} = e^{2 arctan x}/(1 + x²) ≤ e^{π}/(1 + x²)`
is integrable.  The resulting potential

`V(x) = (2x² − 4x)/(1 + x²)² − (1 + x²)²/4`

is smooth, real, and behaves like `−x⁴/4` at infinity — the classical limit-circle profile.

## What is proved

* `lcSol_isL2Ode` — the explicit `W` is a square-integrable classical solution of
  `W'' = (lcV − i)W`;
* `lcSol_ne_zero` — it never vanishes;
* `lcV_not_deficiencyTrivialAt_I` — hence the deficiency space of `−d²/dx² + lcV` at `i` is
  nontrivial;
* **`lcV_not_essentiallySelfAdjoint`** — so `−d²/dx² + lcV` is **not** essentially
  self-adjoint on the compactly supported smooth core;
* `exists_smooth_potential_not_essentiallySelfAdjoint` — the existence statement: there is a
  smooth real potential on the line whose Schrödinger operator fails to be essentially
  self-adjoint on that core.  Combined with `wallHam_essentiallySelfAdjoint`, this shows the
  non-negativity hypothesis there cannot simply be dropped.
-/

namespace BookProof.LimitCircleExample

open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

/-! ## 1. The real ingredients -/

/-- The log-modulus `p(x) = arctan x − ½ log(1 + x²)` of the solution. -/
def lcP : ℝ → ℝ := fun x => Real.arctan x - Real.log (1 + x ^ 2) / 2

/-- `p'(x) = (1 − x)/(1 + x²)`. -/
def lcP' : ℝ → ℝ := fun x => (1 - x) / (1 + x ^ 2)

/-- `p''(x) = (x² − 2x − 1)/(1 + x²)²`. -/
def lcP'' : ℝ → ℝ := fun x => (x ^ 2 - 2 * x - 1) / (1 + x ^ 2) ^ 2

/-- The phase `q(x) = −(x + x³/3)/2`. -/
def lcQ : ℝ → ℝ := fun x => -(x + x ^ 3 / 3) / 2

/-- `q'(x) = −(1 + x²)/2`. -/
def lcQ' : ℝ → ℝ := fun x => -(1 + x ^ 2) / 2

/-- **The potential** `V(x) = (2x² − 4x)/(1 + x²)² − (1 + x²)²/4`: smooth, real, and
asymptotically `−x⁴/4`. -/
def lcV : ℝ → ℝ := fun x => (2 * x ^ 2 - 4 * x) / (1 + x ^ 2) ^ 2 - (1 + x ^ 2) ^ 2 / 4

lemma one_add_sq_pos (x : ℝ) : (0 : ℝ) < 1 + x ^ 2 := by positivity

lemma hasDerivAt_lcP (x : ℝ) : HasDerivAt lcP (lcP' x) x := by
  have h1 : HasDerivAt Real.arctan (1 / (1 + x ^ 2)) x := by
    simpa using Real.hasDerivAt_arctan x
  have h2 : HasDerivAt (fun y : ℝ => 1 + y ^ 2) (2 * x) x := by
    simpa using (hasDerivAt_pow 2 x).const_add 1
  have h3 : HasDerivAt (fun y : ℝ => Real.log (1 + y ^ 2)) (2 * x / (1 + x ^ 2)) x :=
    h2.log (ne_of_gt (one_add_sq_pos x))
  have h4 := h1.sub (h3.div_const 2)
  have heq : 1 / (1 + x ^ 2) - (2 * x / (1 + x ^ 2)) / 2 = lcP' x := by
    unfold lcP'
    have := (one_add_sq_pos x).ne'
    field_simp
  rw [← heq]
  exact h4

lemma hasDerivAt_lcP' (x : ℝ) : HasDerivAt lcP' (lcP'' x) x := by
  have hn : HasDerivAt (fun y : ℝ => 1 - y) (-1) x := by
    simpa using (hasDerivAt_id x).const_sub 1
  have hd : HasDerivAt (fun y : ℝ => 1 + y ^ 2) (2 * x) x := by
    simpa using (hasDerivAt_pow 2 x).const_add 1
  have h := hn.div hd (ne_of_gt (one_add_sq_pos x))
  have heq : ((-1) * (1 + x ^ 2) - (1 - x) * (2 * x)) / (1 + x ^ 2) ^ 2 = lcP'' x := by
    unfold lcP''
    have := (one_add_sq_pos x).ne'
    field_simp
    ring
  rw [← heq]
  exact h

lemma hasDerivAt_lcQ (x : ℝ) : HasDerivAt lcQ (lcQ' x) x := by
  have h : HasDerivAt (fun y : ℝ => -(y + y ^ 3 / 3) / 2) (-(1 + 3 * x ^ 2 / 3) / 2) x := by
    simpa using (((hasDerivAt_id x).add ((hasDerivAt_pow 3 x).div_const 3)).neg.div_const 2)
  have heq : -(1 + 3 * x ^ 2 / 3) / 2 = lcQ' x := by unfold lcQ'; ring
  rw [← heq]
  exact h

lemma hasDerivAt_lcQ' (x : ℝ) : HasDerivAt lcQ' (-x) x := by
  have h : HasDerivAt (fun y : ℝ => -(1 + y ^ 2) / 2) (-(2 * x) / 2) x := by
    simpa using ((((hasDerivAt_pow 2 x).const_add 1).neg).div_const 2)
  have heq : -(2 * x) / 2 = -x := by ring
  rw [← heq]
  exact h

/-- `V` is smooth: it is a rational function with nonvanishing denominator. -/
lemma contDiff_lcV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) lcV := by
  have hden : ∀ x : ℝ, (1 + x ^ 2) ^ 2 ≠ 0 := fun x => by positivity
  have h1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
      fun x : ℝ => (2 * x ^ 2 - 4 * x) / (1 + x ^ 2) ^ 2 :=
    ContDiff.div (by fun_prop) (by fun_prop) hden
  have h2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun x : ℝ => (1 + x ^ 2) ^ 2 / 4 := by fun_prop
  exact h1.sub h2

/-! ## 2. The solution -/

/-- **The deficiency vector** `W = e^{p + iq}`. -/
def lcSol : ℝ → ℂ := fun x => Complex.exp (((lcP x : ℝ) : ℂ) + Complex.I * ((lcQ x : ℝ) : ℂ))

/-- Its logarithmic derivative `p' + iq'`. -/
def lcLog' : ℝ → ℂ := fun x => ((lcP' x : ℝ) : ℂ) + Complex.I * ((lcQ' x : ℝ) : ℂ)

lemma lcSol_ne_zero (x : ℝ) : lcSol x ≠ 0 := Complex.exp_ne_zero _

lemma hasDerivAt_lcLogFun (x : ℝ) :
    HasDerivAt (fun y : ℝ => ((lcP y : ℝ) : ℂ) + Complex.I * ((lcQ y : ℝ) : ℂ))
      (lcLog' x) x :=
  ((hasDerivAt_lcP x).ofReal_comp).add (((hasDerivAt_lcQ x).ofReal_comp).const_mul Complex.I)

lemma hasDerivAt_lcSol (x : ℝ) : HasDerivAt lcSol (lcLog' x * lcSol x) x := by
  have h := (hasDerivAt_lcLogFun x).cexp
  simpa [lcSol, mul_comm] using h

/-- The algebraic heart: `(p'' + i(−x)) + (p' + iq')² = V − i`. -/
lemma lcLog_ode (x : ℝ) :
    (((lcP'' x : ℝ) : ℂ) + Complex.I * ((-x : ℝ) : ℂ)) + lcLog' x ^ 2
      = ((lcV x : ℝ) : ℂ) - Complex.I := by
  have hne : (1 + x ^ 2 : ℝ) ≠ 0 := by positivity
  have hre : lcP'' x + lcP' x ^ 2 - lcQ' x ^ 2 = lcV x := by
    unfold lcP'' lcP' lcQ' lcV
    field_simp
    ring
  have him : -x + 2 * lcP' x * lcQ' x = -1 := by
    unfold lcP' lcQ'
    field_simp
    ring
  have h1 : ((lcP'' x + lcP' x ^ 2 - lcQ' x ^ 2 : ℝ) : ℂ) = ((lcV x : ℝ) : ℂ) := by rw [hre]
  have h2 : ((-x + 2 * lcP' x * lcQ' x : ℝ) : ℂ) = ((-1 : ℝ) : ℂ) := by rw [him]
  unfold lcLog'
  push_cast at h1 h2 ⊢
  linear_combination h1 + Complex.I * h2 + ((lcQ' x : ℂ)) ^ 2 * Complex.I_sq

lemma hasDerivAt_lcLog' (x : ℝ) :
    HasDerivAt lcLog' (((lcP'' x : ℝ) : ℂ) + Complex.I * ((-x : ℝ) : ℂ)) x :=
  ((hasDerivAt_lcP' x).ofReal_comp).add (((hasDerivAt_lcQ' x).ofReal_comp).const_mul Complex.I)

lemma hasDerivAt_lcSol' (x : ℝ) :
    HasDerivAt (fun y => lcLog' y * lcSol y)
      ((((lcV x : ℝ) : ℂ) - Complex.I) * lcSol x) x := by
  have h := (hasDerivAt_lcLog' x).mul (hasDerivAt_lcSol x)
  have hval : (((lcP'' x : ℝ) : ℂ) + Complex.I * ((-x : ℝ) : ℂ)) * lcSol x
      + lcLog' x * (lcLog' x * lcSol x)
      = (((lcV x : ℝ) : ℂ) - Complex.I) * lcSol x := by
    have := lcLog_ode x
    linear_combination lcSol x * this
  rw [← hval]
  exact h

/-! ## 3. Square integrability -/

lemma norm_lcSol (x : ℝ) : ‖lcSol x‖ = Real.exp (lcP x) := by
  rw [lcSol, Complex.norm_exp]
  congr 1
  simp

lemma lcSol_sq_le (x : ℝ) : ‖lcSol x‖ ^ 2 ≤ Real.exp π * (1 + x ^ 2)⁻¹ := by
  have hpos : (0 : ℝ) < 1 + x ^ 2 := one_add_sq_pos x
  rw [norm_lcSol, ← Real.exp_nat_mul]
  have hstep : (2 : ℕ) * lcP x = 2 * Real.arctan x - Real.log (1 + x ^ 2) := by
    unfold lcP; push_cast; ring
  rw [hstep, Real.exp_sub, Real.exp_log hpos, div_eq_mul_inv]
  have h2 : Real.exp (2 * Real.arctan x) ≤ Real.exp π := by
    apply Real.exp_le_exp.2
    nlinarith [Real.arctan_lt_pi_div_two x]
  exact mul_le_mul_of_nonneg_right h2 (by positivity)

lemma continuous_lcSol : Continuous lcSol :=
  continuous_iff_continuousAt.2 fun x => (hasDerivAt_lcSol x).continuousAt

lemma memLp_lcSol : MemLp lcSol 2 (volume : Measure ℝ) := by
  refine (memLp_two_iff_integrable_sq_norm
    continuous_lcSol.aestronglyMeasurable).2 ?_
  have hg : Integrable (fun x : ℝ => Real.exp π * (1 + x ^ 2)⁻¹) volume :=
    integrable_inv_one_add_sq.const_mul _
  refine Integrable.mono' hg ((continuous_lcSol.norm.pow 2).aestronglyMeasurable) ?_
  filter_upwards with x
  rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
  exact lcSol_sq_le x

/-! ## 4. The conclusion -/

/-- **The explicit square-integrable classical solution at `z = i`.** -/
theorem lcSol_isL2Ode : IsL2Ode lcV Complex.I lcSol :=
  ⟨fun x => lcLog' x * lcSol x, hasDerivAt_lcSol, hasDerivAt_lcSol', memLp_lcSol⟩

/-- **The deficiency space of `−d²/dx² + lcV` at `i` is nontrivial.** -/
theorem lcV_not_deficiencyTrivialAt_I :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam lcV contDiff_lcV) Complex.I :=
  not_deficiencyTrivialAt_of_l2_solution _ _ Complex.I lcSol_isL2Ode ⟨0, lcSol_ne_zero 0⟩

/-- **The deficiency space at `−i` is nontrivial too**: conjugating the explicit solution gives
one at `conj i = −i`, so *both* deficiency indices of `−d²/dx² + lcV` are positive. -/
theorem lcV_not_deficiencyTrivialAt_negI :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam lcV contDiff_lcV) (-Complex.I) := by
  have h := lcV_not_deficiencyTrivialAt_I
  rw [deficiencyTrivialAt_conj_iff lcV contDiff_lcV Complex.I] at h
  simpa using h

/-- **`−d²/dx² + lcV` is not essentially self-adjoint** on the compactly supported smooth core
of `L²(ℝ)`. -/
theorem lcV_not_essentiallySelfAdjoint :
    ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam lcV contDiff_lcV) :=
  not_essentiallySelfAdjointOn_of_l2_solution _ _ lcSol_isL2Ode ⟨0, lcSol_ne_zero 0⟩

/-- **There is a smooth real potential on the line whose Schrödinger operator is not
essentially self-adjoint on the compactly supported smooth core.**  Together with
`wallHam_essentiallySelfAdjoint` (which needs only `V ≥ 0`), this shows the non-negativity
hypothesis there is not removable: the sign of the potential, not its growth, is what
matters. -/
theorem exists_smooth_potential_not_essentiallySelfAdjoint :
    ∃ (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V),
      ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) :=
  ⟨lcV, contDiff_lcV, lcV_not_essentiallySelfAdjoint⟩

end

/-! ## Audit -/

section Audit

#print axioms lcSol_isL2Ode
#print axioms lcV_not_deficiencyTrivialAt_I
#print axioms lcV_not_deficiencyTrivialAt_negI
#print axioms lcV_not_essentiallySelfAdjoint
#print axioms exists_smooth_potential_not_essentiallySelfAdjoint

end Audit

end BookProof.LimitCircleExample
