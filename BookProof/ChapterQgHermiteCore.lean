import Mathlib
import BookProof.ChapterHermiteFunctions
import BookProof.ChapterHermiteProductCore
import BookProof.ChapterStarobinskyPotential

/-!
# The Gauss–polynomial (Hermite) core: the one-particle Hamiltonian is well defined on it

Plan item **§10.6.1, target 1** of `CONSOLIDATED_PLAN.md`: *well-definedness of the
gauge-fixed `R + αR²` one-particle Hamiltonian on the Gauss–polynomial core*.

The scalaron potential `V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²` grows **exponentially** as
`φ → −∞`, so it is not of temperate growth and the Schwartz-core multiplication theorem does
not apply to it.  The Gauss–polynomial core `p(x)e^{−x²/4}` — the basis in which the SIRK
numerics actually work — is nevertheless a legitimate domain for it, because its Gaussian
tail **dominates every exponential**.

## What is proved

**1. Gaussian dominance of exponentials.**  `exp_abs_le_const_mul_exp_sq`: for every `c ≥ 0`
and every `x`, `e^{c|x|} ≤ e^{2c²} e^{x²/8}`; hence `exp_abs_mul_gaussH_le`
`e^{c|x|}e^{−x²/4} ≤ e^{2c²}e^{−x²/8}`, and `tendsto_exp_abs_mul_gaussH_cocompact` — the
product tends to `0` at infinity.

**2. The exponential growth class.**  `ExpBounded f` says `|f x| ≤ C e^{c|x|}` for some
constants.  It contains every polynomial (`expBounded_poly`), is closed under sums and
scalar multiples, and contains the scalaron potential (`expBounded_starobinskyV`) — for
which no temperate bound exists.

**3. Multiplication by such a potential maps the core into `L²`.**
`memLp_gaussPoly` (the core lies in `L²`), `memLp_mul_gaussPoly_of_expBounded` (an
exp-bounded continuous potential times a core element is in `L²`), and the instances
`memLp_starobinskyV_mul_gaussPoly` and `memLp_scalaronFull1D_mul_gaussPoly` for the scalaron
potential and for the full one-variable potential `V₃ + V` (conformal-mode parabola plus
scalaron).

**4. The core is invariant under the kinetic term.**  `hasDerivAt_gaussPoly` shows the
derivative of a Gauss polynomial is the Gauss polynomial of `p' − x p / 2`
(`gaussPolyDeriv`), so `deriv_gaussPoly` and `deriv2_gaussPoly` stay in the core, and
`memLp_hamiltonian_gaussPoly` concludes: **`H ψ = −ψ'' + Wψ` lands in `L²` for every core
element `ψ`**, for every continuous exp-bounded potential `W`, in particular for the
scalaron one (`memLp_scalaronHamiltonian_gaussPoly`).

**6. Symmetry on the core.**  `gint_gaussPolyDeriv_antisymm` and
`gint_gaussPolyDeriv_two_symm` are the integration-by-parts identities at polynomial level
(the boundary terms vanish because of the Gaussian weight), and `integral_kinetic_symm` /
`integral_hamiltonian_symm` conclude that `−d²/dx² + W` is **symmetric** on the core for
every continuous exp-bounded `W` (`integral_scalaronHamiltonian_symm` for the scalaron).
This is the symmetric-operator half of the essential-self-adjointness question; the
deficiency half is not proved here (for the potential term alone it is proved, for
exponentially growing potentials too, in `BookProof.ChapterScalaronHermiteEsa`).

**7. Arbitrary dimension.**  `ExpBounded` is stated for any normed space, and
`memLp_mul_pgFun_of_expBounded` transports item 3 to the project's product Gauss–polynomial
core `pgFun` of `L²(ℝᵈ)` (`BookProof.HermiteProductCore`): multiplication by a continuous,
exponentially bounded potential maps that core into `L²(ℝᵈ)`.  `ExpBounded.comp_coord` and
`exists_exp_bound_mvPolyEval` are the two ingredients, and
`memLp_scalaronSectorPotential_mul_pgFun` is the instance for the **reduced two-variable
sector** `(R_c, φ)` with the potential `V₃(R_c) + V(φ)`.

This answers, in the Hermite basis, the domain question that §10.3 flags for the raw
operator.  It does **not** by itself give essential self-adjointness (targets 2–4 of
§10.6.1); those remain open.
-/

namespace BookProof.QgHermiteCore

open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

/-! ## 1. The Gaussian tail dominates every exponential -/

/-- **Gaussian dominance**: for `c ≥ 0`, `e^{c|x|} ≤ e^{2c²} e^{x²/8}` for every real `x`.
The Gaussian tail of the Hermite core therefore beats every exponential potential. -/
theorem exp_abs_le_const_mul_exp_sq (c x : ℝ) :
    Real.exp (c * |x|) ≤ Real.exp (2 * c ^ 2) * Real.exp (x ^ 2 / 8) := by
  rw [← Real.exp_add]
  refine Real.exp_le_exp.mpr ?_
  nlinarith [sq_nonneg (|x| - 4 * c), abs_nonneg x, sq_abs x]

/-- The exponential is swallowed by the half-Gaussian weight of the core, leaving a
Gaussian: `e^{c|x|}e^{−x²/4} ≤ e^{2c²}e^{−x²/8}`. -/
theorem exp_abs_mul_gaussH_le (c x : ℝ) :
    Real.exp (c * |x|) * gaussH x ≤ Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) := by
  have h := exp_abs_le_const_mul_exp_sq c x
  have hg : (0 : ℝ) < gaussH x := gaussH_pos x
  calc Real.exp (c * |x|) * gaussH x
      ≤ (Real.exp (2 * c ^ 2) * Real.exp (x ^ 2 / 8)) * gaussH x := by
        exact mul_le_mul_of_nonneg_right h hg.le
    _ = Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) := by
        simp only [gaussH, ← Real.exp_add]
        ring_nf

/-- **The Gaussian tail wins at infinity**: `e^{c|x|}e^{−x²/4} → 0`. -/
theorem tendsto_exp_abs_mul_gaussH_atTop (c : ℝ) :
    Tendsto (fun x : ℝ => Real.exp (c * |x|) * gaussH x) atTop (𝓝 0) := by
  have h1 : Tendsto (fun x : ℝ => -x ^ 2 / 8) atTop atBot := by
    have hsq : Tendsto (fun x : ℝ => x ^ 2) atTop atTop := tendsto_pow_atTop (by norm_num)
    have : Tendsto (fun x : ℝ => -x ^ 2) atTop atBot := tendsto_neg_atTop_atBot.comp hsq
    simpa using this.atBot_div_const (by norm_num : (0:ℝ) < 8)
  have hlim : Tendsto (fun x : ℝ => Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) atTop
      (𝓝 0) := by
    simpa using (Real.tendsto_exp_atBot.comp h1).const_mul (Real.exp (2 * c ^ 2))
  refine squeeze_zero (fun x => ?_) (fun x => exp_abs_mul_gaussH_le c x) hlim
  have := gaussH_pos x
  positivity

/-! ## 2. The exponential growth class -/

section ExpBoundedGeneral

variable {E : Type*} [NormedAddCommGroup E]

/-- `ExpBounded f`: `f` is dominated by some exponential, `|f x| ≤ C e^{c‖x‖}`.  This is the
growth class that the Gauss–polynomial core can absorb; it strictly contains the polynomials
and it contains the scalaron potential, which is *not* of temperate growth. -/
def ExpBounded (f : E → ℝ) : Prop :=
  ∃ C c : ℝ, 0 ≤ c ∧ ∀ x, |f x| ≤ C * Real.exp (c * ‖x‖)

theorem ExpBounded.nonneg_const {f : E → ℝ} {C c : ℝ}
    (h : ∀ x, |f x| ≤ C * Real.exp (c * ‖x‖)) : 0 ≤ C := by
  have h0 := h 0
  rw [norm_zero, mul_zero, Real.exp_zero, mul_one] at h0
  exact (abs_nonneg _).trans h0

theorem ExpBounded.add {f g : E → ℝ} (hf : ExpBounded f) (hg : ExpBounded g) :
    ExpBounded (fun x => f x + g x) := by
  obtain ⟨C1, c1, hc1, h1⟩ := hf
  obtain ⟨C2, c2, _, h2⟩ := hg
  have hC1 : 0 ≤ C1 := ExpBounded.nonneg_const h1
  have hC2 : 0 ≤ C2 := ExpBounded.nonneg_const h2
  refine ⟨C1 + C2, max c1 c2, le_trans hc1 (le_max_left _ _), fun x => ?_⟩
  have e1 : C1 * Real.exp (c1 * ‖x‖) ≤ C1 * Real.exp (max c1 c2 * ‖x‖) := by
    gcongr
    · exact le_max_left _ _
  have e2 : C2 * Real.exp (c2 * ‖x‖) ≤ C2 * Real.exp (max c1 c2 * ‖x‖) := by
    gcongr
    · exact le_max_right _ _
  calc |f x + g x| ≤ |f x| + |g x| := abs_add_le _ _
    _ ≤ C1 * Real.exp (c1 * ‖x‖) + C2 * Real.exp (c2 * ‖x‖) := add_le_add (h1 x) (h2 x)
    _ ≤ (C1 + C2) * Real.exp (max c1 c2 * ‖x‖) := by linarith

theorem ExpBounded.const_mul {f : E → ℝ} (hf : ExpBounded f) (a : ℝ) :
    ExpBounded (fun x => a * f x) := by
  obtain ⟨C, c, hc, h⟩ := hf
  refine ⟨|a| * C, c, hc, fun x => ?_⟩
  rw [abs_mul, mul_assoc]
  exact mul_le_mul_of_nonneg_left (h x) (abs_nonneg a)

/-- The class is closed under products: the rates add. -/
theorem ExpBounded.mul {f g : E → ℝ} (hf : ExpBounded f) (hg : ExpBounded g) :
    ExpBounded (fun x => f x * g x) := by
  obtain ⟨C1, c1, hc1, h1⟩ := hf
  obtain ⟨C2, c2, hc2, h2⟩ := hg
  have hC1 : 0 ≤ C1 := ExpBounded.nonneg_const h1
  refine ⟨C1 * C2, c1 + c2, by linarith, fun x => ?_⟩
  have hexp : Real.exp (c1 * ‖x‖) * Real.exp (c2 * ‖x‖) = Real.exp ((c1 + c2) * ‖x‖) := by
    rw [← Real.exp_add]
    congr 1
    ring
  calc |f x * g x| = |f x| * |g x| := abs_mul _ _
    _ ≤ (C1 * Real.exp (c1 * ‖x‖)) * (C2 * Real.exp (c2 * ‖x‖)) := by
        refine mul_le_mul (h1 x) (h2 x) (abs_nonneg _) (by positivity)
    _ = C1 * C2 * (Real.exp (c1 * ‖x‖) * Real.exp (c2 * ‖x‖)) := by ring
    _ = C1 * C2 * Real.exp ((c1 + c2) * ‖x‖) := by rw [hexp]

end ExpBoundedGeneral

/-- Every monomial is exponentially bounded (with rate `1`). -/
theorem expBounded_pow (k : ℕ) : ExpBounded (fun x : ℝ => x ^ k) := by
  refine ⟨(k.factorial : ℝ), 1, zero_le_one, fun x => ?_⟩
  rw [Real.norm_eq_abs]
  have hfac : (0 : ℝ) < (k.factorial : ℝ) := by positivity
  have h := Real.pow_div_factorial_le_exp |x| (abs_nonneg x) k
  rw [div_le_iff₀ hfac] at h
  rw [abs_pow, one_mul]
  linarith [h]

/-- Every polynomial is exponentially bounded. -/
theorem expBounded_poly (p : Polynomial ℝ) : ExpBounded (fun x => p.eval x) := by
  induction p using Polynomial.induction_on' with
  | add p q hp hq => simpa [Polynomial.eval_add] using hp.add hq
  | monomial k a =>
      simpa [Polynomial.eval_monomial] using (expBounded_pow k).const_mul a

/-- The scalaron potential is continuous. -/
theorem continuous_starobinskyV (M alpha : ℝ) : Continuous (starobinskyV M alpha) := by
  unfold starobinskyV
  fun_prop

/-- The scalaron potential is exponentially bounded (with rate `2√(2/3)/M`), even though it
has no temperate bound. -/
theorem expBounded_starobinskyV (M alpha : ℝ) (hM : 0 < M) :
    ExpBounded (starobinskyV M alpha) := by
  have hs : (0 : ℝ) ≤ Real.sqrt (2 / 3) := Real.sqrt_nonneg _
  refine ⟨4 * |M ^ 4 / (16 * alpha)|, 2 * (Real.sqrt (2 / 3) / M), by positivity, fun x => ?_⟩
  rw [Real.norm_eq_abs]
  have habsu : |-(Real.sqrt (2 / 3)) * x / M| = Real.sqrt (2 / 3) / M * |x| := by
    rw [abs_div, abs_mul, abs_neg, abs_of_pos hM, abs_of_nonneg hs]
    ring
  have hexp_le : Real.exp (-(Real.sqrt (2 / 3)) * x / M)
      ≤ Real.exp (Real.sqrt (2 / 3) / M * |x|) :=
    Real.exp_le_exp.mpr (by rw [← habsu]; exact le_abs_self _)
  have hone : (1 : ℝ) ≤ Real.exp (Real.sqrt (2 / 3) / M * |x|) :=
    Real.one_le_exp (by positivity)
  have hpos : 0 < Real.exp (-(Real.sqrt (2 / 3)) * x / M) := Real.exp_pos _
  have habs : |1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)|
      ≤ 2 * Real.exp (Real.sqrt (2 / 3) / M * |x|) := by
    rw [abs_le]
    constructor <;> linarith
  have hexp2 : (Real.exp (Real.sqrt (2 / 3) / M * |x|)) ^ 2
      = Real.exp (2 * (Real.sqrt (2 / 3) / M) * |x|) := by
    rw [sq, ← Real.exp_add]
    congr 1
    ring
  have hsq : (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)) ^ 2
      ≤ 4 * Real.exp (2 * (Real.sqrt (2 / 3) / M) * |x|) := by
    nlinarith [mul_self_le_mul_self
        (abs_nonneg (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M))) habs,
      sq_abs (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)), hexp2]
  have hV : |starobinskyV M alpha x|
      = |M ^ 4 / (16 * alpha)| * (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)) ^ 2 := by
    rw [starobinskyV, abs_mul]
    congr 1
    exact abs_of_nonneg (sq_nonneg _)
  rw [hV]
  have hK : (0 : ℝ) ≤ |M ^ 4 / (16 * alpha)| := abs_nonneg _
  calc |M ^ 4 / (16 * alpha)| * (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)) ^ 2
      ≤ |M ^ 4 / (16 * alpha)| * (4 * Real.exp (2 * (Real.sqrt (2 / 3) / M) * |x|)) :=
        mul_le_mul_of_nonneg_left hsq hK
    _ = 4 * |M ^ 4 / (16 * alpha)| * Real.exp (2 * (Real.sqrt (2 / 3) / M) * |x|) := by ring

/-! ## 3. The Gauss–polynomial core, and multiplication by such a potential -/

/-- A **Gauss polynomial** `p(x)e^{−x²/4}`: the generic element of the Hermite core. -/
noncomputable def gaussPoly (p : Polynomial ℝ) (x : ℝ) : ℝ := p.eval x * gaussH x

theorem continuous_gaussPoly (p : Polynomial ℝ) : Continuous (gaussPoly p) :=
  p.continuous_aeval.mul continuous_gaussH

/-- The core lies in `L²`. -/
theorem memLp_gaussPoly (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((gaussPoly p x : ℝ) : ℂ)) 2 (volume : Measure ℝ) :=
  memLp_poly_mul_gaussH p

/-- An auxiliary `L²` majorant: `|p(x)|e^{−x²/8}` is square integrable. -/
theorem memLp_abs_poly_mul_exp_neg_eighth (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((|p.eval x| * Real.exp (-x ^ 2 / 8) : ℝ) : ℂ)) 2
      (volume : Measure ℝ) := by
  have hmeas : AEStronglyMeasurable
      (fun x : ℝ => ((|p.eval x| * Real.exp (-x ^ 2 / 8) : ℝ) : ℂ)) (volume : Measure ℝ) := by
    refine Continuous.aestronglyMeasurable ?_
    refine Complex.continuous_ofReal.comp ?_
    exact (p.continuous_aeval.abs).mul (by fun_prop)
  rw [memLp_two_iff_integrable_sq_norm hmeas]
  refine (integrable_poly_mul_gaussH (p * p)).congr (Filter.Eventually.of_forall fun x => ?_)
  have hexp : Real.exp (-x ^ 2 / 8) ^ 2 = Real.exp (-x ^ 2 / 4) := by
    rw [sq, ← Real.exp_add]
    congr 1
    ring
  simp only [Polynomial.eval_mul, Complex.norm_real, Real.norm_eq_abs, gaussH]
  rw [abs_of_nonneg (by positivity : (0:ℝ) ≤ |p.eval x| * Real.exp (-x ^ 2 / 8)), mul_pow,
    sq_abs, hexp]
  ring

/-- **Multiplication by an exponentially bounded potential maps the core into `L²`.** -/
theorem memLp_mul_gaussPoly_of_expBounded {W : ℝ → ℝ} (hW : Continuous W)
    (hWb : ExpBounded W) (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((W x * gaussPoly p x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by
  obtain ⟨C, c, -, hbound0⟩ := hWb
  have hC : 0 ≤ C := ExpBounded.nonneg_const hbound0
  have hbound : ∀ y : ℝ, |W y| ≤ C * Real.exp (c * |y|) := by
    simpa [Real.norm_eq_abs] using hbound0
  set K : ℝ := C * Real.exp (2 * c ^ 2) with hK
  have hKnn : 0 ≤ K := by positivity
  have hg : MemLp (fun x : ℝ => ((K : ℂ) * ((|p.eval x| * Real.exp (-x ^ 2 / 8) : ℝ) : ℂ))) 2
      (volume : Measure ℝ) := (memLp_abs_poly_mul_exp_neg_eighth p).const_mul _
  refine hg.of_le ?_ (Filter.Eventually.of_forall fun x => ?_)
  · refine Continuous.aestronglyMeasurable ?_
    exact Complex.continuous_ofReal.comp (hW.mul (continuous_gaussPoly p))
  · have hgH : 0 < gaussH x := gaussH_pos x
    have h1 : |W x * gaussPoly p x| ≤ (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x) := by
      rw [gaussPoly, abs_mul, abs_mul, abs_of_pos hgH]
      have := hbound x
      have h2 : (0:ℝ) ≤ |p.eval x| * gaussH x := by positivity
      calc |W x| * (|p.eval x| * gaussH x)
          ≤ (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x) :=
            mul_le_mul_of_nonneg_right this h2
        _ = (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x) := rfl
    have h3 : Real.exp (c * |x|) * gaussH x ≤ Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) :=
      exp_abs_mul_gaussH_le c x
    have h4 : (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x)
        ≤ K * (|p.eval x| * Real.exp (-x ^ 2 / 8)) := by
      have hp : (0:ℝ) ≤ |p.eval x| := abs_nonneg _
      have hstep : C * |p.eval x| * (Real.exp (c * |x|) * gaussH x)
          ≤ C * |p.eval x| * (Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) :=
        mul_le_mul_of_nonneg_left h3 (by positivity)
      calc (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x)
          = C * |p.eval x| * (Real.exp (c * |x|) * gaussH x) := by ring
        _ ≤ C * |p.eval x| * (Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) := hstep
        _ = K * (|p.eval x| * Real.exp (-x ^ 2 / 8)) := by rw [hK]; ring
    have hnormf : ‖((W x * gaussPoly p x : ℝ) : ℂ)‖ = |W x * gaussPoly p x| := by
      simp [Complex.norm_real]
    have hnormg : ‖((K : ℂ) * ((|p.eval x| * Real.exp (-x ^ 2 / 8) : ℝ) : ℂ))‖
        = K * (|p.eval x| * Real.exp (-x ^ 2 / 8)) := by
      rw [norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs,
        abs_of_nonneg hKnn,
        abs_of_nonneg (by positivity : (0:ℝ) ≤ |p.eval x| * Real.exp (-x ^ 2 / 8))]
    rw [hnormf, hnormg]
    linarith

/-- The scalaron potential times a core element is square integrable. -/
theorem memLp_starobinskyV_mul_gaussPoly (M alpha : ℝ) (hM : 0 < M) (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((starobinskyV M alpha x * gaussPoly p x : ℝ) : ℂ)) 2
      (volume : Measure ℝ) :=
  memLp_mul_gaussPoly_of_expBounded
    (continuous_starobinskyV M alpha)
    (expBounded_starobinskyV M alpha hM) p

/-- The **full one-variable potential** of the gauge-fixed `R + αR²` Hamiltonian — the
conformal-mode parabola `V₃` plus the scalaron potential — also maps the core into `L²`. -/
theorem memLp_scalaronFull1D_mul_gaussPoly (M alpha : ℝ) (hM : 0 < M) (V3 : Polynomial ℝ)
    (p : Polynomial ℝ) :
    MemLp (fun x : ℝ =>
        (((V3.eval x + starobinskyV M alpha x) * gaussPoly p x : ℝ) : ℂ)) 2
      (volume : Measure ℝ) :=
  memLp_mul_gaussPoly_of_expBounded
    (V3.continuous_aeval.add (continuous_starobinskyV M alpha))
    ((expBounded_poly V3).add (expBounded_starobinskyV M alpha hM)) p

/-! ## 4. The core is invariant under differentiation -/

/-- The polynomial of the derivative of a Gauss polynomial: `(p e^{−x²/4})' =
(p' − x p / 2) e^{−x²/4}`. -/
noncomputable def gaussPolyDeriv (p : Polynomial ℝ) : Polynomial ℝ :=
  Polynomial.derivative p - Polynomial.C (1 / 2) * Polynomial.X * p

theorem hasDerivAt_gaussPoly (p : Polynomial ℝ) (x : ℝ) :
    HasDerivAt (gaussPoly p) (gaussPoly (gaussPolyDeriv p) x) x := by
  have hp : HasDerivAt (fun y : ℝ => p.eval y) ((Polynomial.derivative p).eval x) x :=
    p.hasDerivAt x
  have hg := hasDerivAt_gaussH x
  refine (hp.mul hg).congr_deriv ?_
  simp only [gaussPoly, gaussPolyDeriv, Polynomial.eval_sub, Polynomial.eval_mul,
    Polynomial.eval_C, Polynomial.eval_X]
  ring

theorem deriv_gaussPoly (p : Polynomial ℝ) :
    deriv (gaussPoly p) = gaussPoly (gaussPolyDeriv p) := by
  funext x
  exact (hasDerivAt_gaussPoly p x).deriv

/-- The second derivative of a core element is again a core element. -/
theorem deriv2_gaussPoly (p : Polynomial ℝ) :
    deriv (deriv (gaussPoly p)) = gaussPoly (gaussPolyDeriv (gaussPolyDeriv p)) := by
  rw [deriv_gaussPoly, deriv_gaussPoly]

/-- **The one-particle Hamiltonian is well defined on the Gauss–polynomial core**: for every
continuous, exponentially bounded potential `W` and every core element `ψ = p e^{−x²/4}`,
the function `−ψ'' + Wψ` is again in `L²`. -/
theorem memLp_hamiltonian_gaussPoly {W : ℝ → ℝ} (hW : Continuous W) (hWb : ExpBounded W)
    (p : Polynomial ℝ) :
    MemLp (fun x : ℝ =>
        ((-deriv (deriv (gaussPoly p)) x + W x * gaussPoly p x : ℝ) : ℂ)) 2
      (volume : Measure ℝ) := by
  have h1 : MemLp (fun x : ℝ =>
      ((-gaussPoly (gaussPolyDeriv (gaussPolyDeriv p)) x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by
    have hneg := (memLp_gaussPoly (gaussPolyDeriv (gaussPolyDeriv p))).neg
    refine (memLp_congr_ae (Filter.Eventually.of_forall fun x => ?_)).mp hneg
    simp only [Pi.neg_apply, Complex.ofReal_neg]
  have h2 := memLp_mul_gaussPoly_of_expBounded hW hWb p
  have hsum := h1.add h2
  refine (memLp_congr_ae (Filter.Eventually.of_forall fun x => ?_)).mp hsum
  rw [deriv2_gaussPoly]
  simp only [Pi.add_apply]
  push_cast
  ring

/-- The scalaron instance: `−ψ'' + V(φ)ψ ∈ L²` for every Gauss polynomial `ψ`. -/
theorem memLp_scalaronHamiltonian_gaussPoly (M alpha : ℝ) (hM : 0 < M) (p : Polynomial ℝ) :
    MemLp (fun x : ℝ =>
        ((-deriv (deriv (gaussPoly p)) x + starobinskyV M alpha x * gaussPoly p x : ℝ) : ℂ)) 2
      (volume : Measure ℝ) :=
  memLp_hamiltonian_gaussPoly
    (continuous_starobinskyV M alpha)
    (expBounded_starobinskyV M alpha hM) p

/-! ## 6. Symmetry of the Hamiltonian on the core -/

/-- The `L²` pairing of two core elements is the Gaussian-weighted integral of the product
of their polynomials. -/
theorem integral_gaussPoly_mul (p q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly p x * gaussPoly q x = gint (p * q) := by
  rw [gint]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  have h := gaussH_sq x
  simp only [gaussPoly, Polynomial.eval_mul]
  rw [← h]
  ring

theorem integrable_gaussPoly_mul (p q : Polynomial ℝ) :
    Integrable (fun x : ℝ => gaussPoly p x * gaussPoly q x) := by
  refine (integrable_poly_mul_gaussW (p * q)).congr (Filter.Eventually.of_forall fun x => ?_)
  have h := gaussH_sq x
  simp only [gaussPoly, Polynomial.eval_mul]
  rw [← h]
  ring

/-- **Differentiation is antisymmetric on the core**, at the level of the polynomials: the
boundary terms of the integration by parts vanish because of the Gaussian weight. -/
theorem gint_gaussPolyDeriv_antisymm (p q : Polynomial ℝ) :
    gint (gaussPolyDeriv p * q) = - gint (p * gaussPolyDeriv q) := by
  have hL : gaussPolyDeriv p * q
      = Polynomial.derivative p * q - Polynomial.C (1 / 2) * (Polynomial.X * (p * q)) := by
    unfold gaussPolyDeriv
    ring
  have hR : p * gaussPolyDeriv q
      = p * Polynomial.derivative q - Polynomial.C (1 / 2) * (Polynomial.X * (p * q)) := by
    unfold gaussPolyDeriv
    ring
  have hibp := gint_ibp p q
  have hexp : p * (Polynomial.X * q - Polynomial.derivative q)
      = Polynomial.X * (p * q) - p * Polynomial.derivative q := by ring
  rw [hexp, gint_sub] at hibp
  rw [hL, hR, gint_sub, gint_sub, gint_C_mul]
  linarith

/-- Hence the second derivative is symmetric on the core. -/
theorem gint_gaussPolyDeriv_two_symm (p q : Polynomial ℝ) :
    gint (gaussPolyDeriv (gaussPolyDeriv p) * q)
      = gint (p * gaussPolyDeriv (gaussPolyDeriv q)) := by
  have h1 := gint_gaussPolyDeriv_antisymm (gaussPolyDeriv p) q
  have h2 := gint_gaussPolyDeriv_antisymm p (gaussPolyDeriv q)
  linarith

/-- **The kinetic term is symmetric on the Gauss–polynomial core.** -/
theorem integral_kinetic_symm (p q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly p x * (-deriv (deriv (gaussPoly q)) x)
      = ∫ x : ℝ, (-deriv (deriv (gaussPoly p)) x) * gaussPoly q x := by
  rw [deriv2_gaussPoly, deriv2_gaussPoly]
  have hL : ∫ x : ℝ, gaussPoly p x * (-gaussPoly (gaussPolyDeriv (gaussPolyDeriv q)) x)
      = -gint (p * gaussPolyDeriv (gaussPolyDeriv q)) := by
    rw [← integral_gaussPoly_mul, ← integral_neg]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  have hR : ∫ x : ℝ, (-gaussPoly (gaussPolyDeriv (gaussPolyDeriv p)) x) * gaussPoly q x
      = -gint (gaussPolyDeriv (gaussPolyDeriv p) * q) := by
    rw [← integral_gaussPoly_mul, ← integral_neg]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  rw [hL, hR, gint_gaussPolyDeriv_two_symm]

/-- The potential term pairs two core elements integrably. -/
theorem integrable_potential_gaussPoly_mul {W : ℝ → ℝ} (hW : Continuous W)
    (hWb : ExpBounded W) (p q : Polynomial ℝ) :
    Integrable (fun x : ℝ => W x * (gaussPoly p x * gaussPoly q x)) := by
  obtain ⟨C, c, -, hb0⟩ := hWb
  have hC : 0 ≤ C := ExpBounded.nonneg_const hb0
  have hb : ∀ y : ℝ, |W y| ≤ C * Real.exp (c * |y|) := by
    simpa [Real.norm_eq_abs] using hb0
  set K : ℝ := C * Real.exp (2 * c ^ 2) with hK
  have hmaj : Integrable (fun x : ℝ => K * |(p * q).eval x * gaussH x|) :=
    ((integrable_poly_mul_gaussH (p * q)).abs).const_mul K
  refine hmaj.mono' ((hW.mul ((continuous_gaussPoly p).mul
    (continuous_gaussPoly q))).aestronglyMeasurable) (Filter.Eventually.of_forall fun x => ?_)
  have hgH : 0 < gaussH x := gaussH_pos x
  have hstep : Real.exp (c * |x|) * gaussH x ≤ Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) :=
    exp_abs_mul_gaussH_le c x
  have he8 : Real.exp (-x ^ 2 / 8) ≤ 1 := by
    rw [Real.exp_le_one_iff]
    nlinarith [sq_nonneg x]
  have hlhs : ‖W x * (gaussPoly p x * gaussPoly q x)‖
      = |W x| * (|(p * q).eval x| * (gaussH x * gaussH x)) := by
    simp only [gaussPoly, Real.norm_eq_abs, Polynomial.eval_mul, abs_mul, abs_of_pos hgH]
    ring
  have hrhs : K * |(p * q).eval x * gaussH x| = K * (|(p * q).eval x| * gaussH x) := by
    rw [abs_mul, abs_of_pos hgH]
  rw [hlhs, hrhs]
  have hnn : (0:ℝ) ≤ |(p * q).eval x| * gaussH x := by positivity
  have h1 : |W x| * (|(p * q).eval x| * (gaussH x * gaussH x))
      ≤ (C * Real.exp (c * |x|)) * (|(p * q).eval x| * (gaussH x * gaussH x)) := by
    have hnn2 : (0:ℝ) ≤ |(p * q).eval x| * (gaussH x * gaussH x) := by positivity
    exact mul_le_mul_of_nonneg_right (hb x) hnn2
  have h2 : (C * Real.exp (c * |x|)) * (|(p * q).eval x| * (gaussH x * gaussH x))
      = C * (Real.exp (c * |x|) * gaussH x) * (|(p * q).eval x| * gaussH x) := by ring
  have h3 : C * (Real.exp (c * |x|) * gaussH x) * (|(p * q).eval x| * gaussH x)
      ≤ C * (Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) * (|(p * q).eval x| * gaussH x) :=
    mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hstep hC) hnn
  have h5 : Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) ≤ Real.exp (2 * c ^ 2) := by
    nlinarith [Real.exp_pos (2 * c ^ 2), he8]
  have h4 : C * (Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) * (|(p * q).eval x| * gaussH x)
      ≤ K * (|(p * q).eval x| * gaussH x) :=
    mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left h5 hC) hnn
  linarith

/-- **The one-particle Hamiltonian is symmetric on the Gauss–polynomial core**: for every
continuous, exponentially bounded potential `W` and all core elements,
`⟪ψ, Hφ⟫ = ⟪Hψ, φ⟫`.  With item 4 (`H` maps the core into `L²`) and the density of the core
this is the symmetric-operator half of the essential self-adjointness question; the
deficiency half is not proved here. -/
theorem integral_hamiltonian_symm {W : ℝ → ℝ} (hW : Continuous W) (hWb : ExpBounded W)
    (p q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly p x * (-deriv (deriv (gaussPoly q)) x + W x * gaussPoly q x)
      = ∫ x : ℝ, (-deriv (deriv (gaussPoly p)) x + W x * gaussPoly p x) * gaussPoly q x := by
  have hk1 : Integrable (fun x : ℝ => gaussPoly p x * (-deriv (deriv (gaussPoly q)) x)) := by
    rw [deriv2_gaussPoly]
    refine (integrable_gaussPoly_mul p (gaussPolyDeriv (gaussPolyDeriv q))).neg.congr
      (Filter.Eventually.of_forall fun x => ?_)
    simp only [Pi.neg_apply]
    ring
  have hk2 : Integrable (fun x : ℝ => (-deriv (deriv (gaussPoly p)) x) * gaussPoly q x) := by
    rw [deriv2_gaussPoly]
    refine (integrable_gaussPoly_mul (gaussPolyDeriv (gaussPolyDeriv p)) q).neg.congr
      (Filter.Eventually.of_forall fun x => ?_)
    simp only [Pi.neg_apply]
    ring
  have hv1 : Integrable (fun x : ℝ => gaussPoly p x * (W x * gaussPoly q x)) :=
    (integrable_potential_gaussPoly_mul hW hWb p q).congr
      (Filter.Eventually.of_forall fun x => by ring)
  have hv2 : Integrable (fun x : ℝ => (W x * gaussPoly p x) * gaussPoly q x) :=
    (integrable_potential_gaussPoly_mul hW hWb p q).congr
      (Filter.Eventually.of_forall fun x => by ring)
  have e1 : ∫ x : ℝ, gaussPoly p x * (-deriv (deriv (gaussPoly q)) x + W x * gaussPoly q x)
      = (∫ x : ℝ, gaussPoly p x * (-deriv (deriv (gaussPoly q)) x))
        + ∫ x : ℝ, gaussPoly p x * (W x * gaussPoly q x) := by
    rw [← integral_add hk1 hv1]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  have e2 : ∫ x : ℝ, (-deriv (deriv (gaussPoly p)) x + W x * gaussPoly p x) * gaussPoly q x
      = (∫ x : ℝ, (-deriv (deriv (gaussPoly p)) x) * gaussPoly q x)
        + ∫ x : ℝ, (W x * gaussPoly p x) * gaussPoly q x := by
    rw [← integral_add hk2 hv2]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  have e3 : ∫ x : ℝ, gaussPoly p x * (W x * gaussPoly q x)
      = ∫ x : ℝ, (W x * gaussPoly p x) * gaussPoly q x := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  rw [e1, e2, e3, integral_kinetic_symm]

/-- The scalaron instance of the symmetry. -/
theorem integral_scalaronHamiltonian_symm (M alpha : ℝ) (hM : 0 < M) (p q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly p x
        * (-deriv (deriv (gaussPoly q)) x + starobinskyV M alpha x * gaussPoly q x)
      = ∫ x : ℝ, (-deriv (deriv (gaussPoly p)) x + starobinskyV M alpha x * gaussPoly p x)
        * gaussPoly q x :=
  integral_hamiltonian_symm (continuous_starobinskyV M alpha)
    (expBounded_starobinskyV M alpha hM) p q

/-! ## 7. Arbitrary dimension: the product Gauss–polynomial core of `L²(ℝᵈ)` -/

section MultiDim

open BookProof.HermiteProductCore

variable {d : ℕ}

/-- An exponentially bounded function of a single coordinate is exponentially bounded on
`ℝᵈ` — this is where `0 ≤ c` is used, through `|xᵢ| ≤ ‖x‖`. -/
theorem ExpBounded.comp_coord {f : ℝ → ℝ} (hf : ExpBounded f) (i : Fin d) :
    ExpBounded (fun x : Vd d => f (x i)) := by
  obtain ⟨C, c, hc, h⟩ := hf
  have hC : 0 ≤ C := ExpBounded.nonneg_const h
  refine ⟨C, c, hc, fun x => ?_⟩
  have hle : ‖x i‖ ≤ ‖x‖ := PiLp.norm_apply_le x i
  calc |f (x i)| ≤ C * Real.exp (c * ‖x i‖) := h (x i)
    _ ≤ C * Real.exp (c * ‖x‖) := by gcongr

/-- Every polynomial on `ℝᵈ` is dominated by an exponential of the norm. -/
theorem exists_exp_bound_mvPolyEval (p : MvPolynomial (Fin d) ℂ) :
    ∃ C c : ℝ, 0 ≤ C ∧ 0 ≤ c ∧ ∀ x : Vd d,
      ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ ≤ C * Real.exp (c * ‖x‖) := by
  induction p using MvPolynomial.induction_on with
  | C a =>
      refine ⟨‖a‖, 0, norm_nonneg a, le_rfl, fun x => ?_⟩
      simp
  | add p q hp hq =>
      obtain ⟨C1, c1, hC1, hc1, h1⟩ := hp
      obtain ⟨C2, c2, hC2, _, h2⟩ := hq
      refine ⟨C1 + C2, max c1 c2, by linarith, le_trans hc1 (le_max_left _ _), fun x => ?_⟩
      have e1 : C1 * Real.exp (c1 * ‖x‖) ≤ C1 * Real.exp (max c1 c2 * ‖x‖) := by
        gcongr
        exact le_max_left _ _
      have e2 : C2 * Real.exp (c2 * ‖x‖) ≤ C2 * Real.exp (max c1 c2 * ‖x‖) := by
        gcongr
        exact le_max_right _ _
      calc ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (p + q)‖
          ≤ ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖
            + ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q‖ := by
            rw [map_add]
            exact norm_add_le _ _
        _ ≤ C1 * Real.exp (c1 * ‖x‖) + C2 * Real.exp (c2 * ‖x‖) := add_le_add (h1 x) (h2 x)
        _ ≤ (C1 + C2) * Real.exp (max c1 c2 * ‖x‖) := by linarith
  | mul_X p i hp =>
      obtain ⟨C, c, hC, hc, h⟩ := hp
      refine ⟨C, c + 1, hC, by linarith, fun x => ?_⟩
      have hxi : ‖(((x i : ℝ)) : ℂ)‖ ≤ ‖x‖ := by
        rw [Complex.norm_real]
        exact PiLp.norm_apply_le x i
      have hnorm : ‖x‖ ≤ Real.exp ‖x‖ := by
        have := Real.add_one_le_exp ‖x‖
        linarith
      calc ‖MvPolynomial.eval (fun j => ((x j : ℝ) : ℂ)) (p * MvPolynomial.X i)‖
          = ‖MvPolynomial.eval (fun j => ((x j : ℝ) : ℂ)) p‖ * ‖(((x i : ℝ)) : ℂ)‖ := by
            rw [map_mul, MvPolynomial.eval_X, norm_mul]
        _ ≤ (C * Real.exp (c * ‖x‖)) * Real.exp ‖x‖ :=
            mul_le_mul (h x) (hxi.trans hnorm) (norm_nonneg _) (by positivity)
        _ = C * Real.exp ((c + 1) * ‖x‖) := by
            rw [mul_assoc, ← Real.exp_add]
            congr 1
            ring

/-- **Multiplication by an exponentially bounded potential maps the product Gauss–polynomial
core of `L²(ℝᵈ)` into `L²(ℝᵈ)`** — the `d`-dimensional form of the well-definedness
statement, covering the reduced `(R_c, φ)` sector (`d = 2`) as well as the one-variable
scalaron sector. -/
theorem memLp_mul_pgFun_of_expBounded {W : Vd d → ℝ} (hW : Continuous W) (hWb : ExpBounded W)
    (p : MvPolynomial (Fin d) ℂ) :
    MemLp (fun x : Vd d => ((W x : ℝ) : ℂ) * pgFun p x) 2 (volume : Measure (Vd d)) := by
  obtain ⟨CW, cW, hcW, hW1⟩ := hWb
  have hCW : 0 ≤ CW := ExpBounded.nonneg_const hW1
  obtain ⟨Cp, cp, hCp, hcp, hp1⟩ := exists_exp_bound_mvPolyEval p
  have hmaj : MemLp (fun x : Vd d => ((CW * Cp : ℝ) : ℂ)
      * ((Real.exp ((cW + cp) * ‖x‖) * gaussD x : ℝ) : ℂ)) 2 (volume : Measure (Vd d)) :=
    (memLp_two_exp_norm_mul_gaussD (cW + cp)).const_mul _
  refine hmaj.of_le ?_ (Filter.Eventually.of_forall fun x => ?_)
  · exact ((Complex.continuous_ofReal.comp hW).mul (continuous_pgFun p)).aestronglyMeasurable
  · have hg : 0 < gaussD x := gaussD_pos x
    have hexp : Real.exp (cW * ‖x‖) * Real.exp (cp * ‖x‖) = Real.exp ((cW + cp) * ‖x‖) := by
      rw [← Real.exp_add]
      congr 1
      ring
    have hlhs : ‖((W x : ℝ) : ℂ) * pgFun p x‖
        = |W x| * (‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ * gaussD x) := by
      rw [pgFun, norm_mul, norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
        Real.norm_eq_abs, abs_of_pos hg]
    have hrhs : ‖((CW * Cp : ℝ) : ℂ) * ((Real.exp ((cW + cp) * ‖x‖) * gaussD x : ℝ) : ℂ)‖
        = CW * Cp * (Real.exp ((cW + cp) * ‖x‖) * gaussD x) := by
      rw [norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs,
        abs_of_nonneg (by positivity : (0:ℝ) ≤ CW * Cp),
        abs_of_nonneg (by positivity : (0:ℝ) ≤ Real.exp ((cW + cp) * ‖x‖) * gaussD x)]
    rw [hlhs, hrhs]
    calc |W x| * (‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ * gaussD x)
        ≤ (CW * Real.exp (cW * ‖x‖)) * ((Cp * Real.exp (cp * ‖x‖)) * gaussD x) := by
          have h2 : ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ * gaussD x
              ≤ (Cp * Real.exp (cp * ‖x‖)) * gaussD x :=
            mul_le_mul_of_nonneg_right (hp1 x) hg.le
          exact mul_le_mul (hW1 x) h2 (by positivity) (by positivity)
      _ = CW * Cp * ((Real.exp (cW * ‖x‖) * Real.exp (cp * ‖x‖)) * gaussD x) := by ring
      _ = CW * Cp * (Real.exp ((cW + cp) * ‖x‖) * gaussD x) := by rw [hexp]

/-! ### The reduced `(R_c, φ)` sector -/

/-- The full potential of the reduced two-variable sector of the gauge-fixed `R + αR²`
Hamiltonian: the conformal-mode parabola `V₃` in the first coordinate plus the scalaron
potential in the second. -/
noncomputable def scalaronSectorPotential (M alpha : ℝ) (V3 : Polynomial ℝ) (x : Vd 2) : ℝ :=
  V3.eval (x 0) + starobinskyV M alpha (x 1)

theorem continuous_scalaronSectorPotential (M alpha : ℝ) (V3 : Polynomial ℝ) :
    Continuous (scalaronSectorPotential M alpha V3) := by
  unfold scalaronSectorPotential
  exact (V3.continuous_aeval.comp (by fun_prop)).add
    ((continuous_starobinskyV M alpha).comp (by fun_prop))

theorem expBounded_scalaronSectorPotential (M alpha : ℝ) (hM : 0 < M) (V3 : Polynomial ℝ) :
    ExpBounded (scalaronSectorPotential M alpha V3) :=
  ((expBounded_poly V3).comp_coord 0).add ((expBounded_starobinskyV M alpha hM).comp_coord 1)

/-- **The two-variable sector**: the full potential `V₃(R_c) + V(φ)` maps the product
Gauss–polynomial core of `L²(ℝ²)` into `L²(ℝ²)`. -/
theorem memLp_scalaronSectorPotential_mul_pgFun (M alpha : ℝ) (hM : 0 < M) (V3 : Polynomial ℝ)
    (p : MvPolynomial (Fin 2) ℂ) :
    MemLp (fun x : Vd 2 => ((scalaronSectorPotential M alpha V3 x : ℝ) : ℂ) * pgFun p x) 2
      (volume : Measure (Vd 2)) :=
  memLp_mul_pgFun_of_expBounded (continuous_scalaronSectorPotential M alpha V3)
    (expBounded_scalaronSectorPotential M alpha hM V3) p

end MultiDim

end BookProof.QgHermiteCore
