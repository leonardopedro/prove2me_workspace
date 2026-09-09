import Mathlib
import BookProof.ChapterWallDeficiencyObstruction

/-!
# The wrong-sign conformal fiber: an explicit exponential-wall potential whose Schrödinger
# operator is *not* essentially self-adjoint

`CONSOLIDATED_PLAN.md`'s QG-2 "Case B" is the densitized **conformal** direction of the 3D
gauge-fixed gravity Hamiltonian.  There the densitized kinetic term enters with the *wrong*
sign, `(1/24) ∂²_y`, while the `R²` (Starobinsky) potential is a non-negative **exponential
wall** — growing like `e^{−2ay}` as `y → −∞` and flattening to a plateau as `y → +∞`.
Multiplying that fiber operator by the positive constant `24` and flipping the overall sign
turns it into a standard Schrödinger operator

`−24·((1/24) d²/dy² + U(y) + c₀) = −d²/dy² − 24·(U(y) + c₀)`,

i.e. `−d²/dy² + V` with `V = −24(U + c₀)` — a potential that is *unbounded below*
exponentially at `−∞` and constant at `+∞`.  The plan records (and its 2026-08-29f (v2)
analysis argues) that this is the Weyl **limit-circle** situation at the wall, so that
essential self-adjointness on the compactly supported smooth core **fails**.

`BookProof/ChapterLimitCircleExample.lean` already made the failure a theorem for *some*
smooth real potential (asymptotically `−x⁴/4`).  This module does it for a potential of
exactly the **conformal-fiber profile**: an explicit non-negative exponential wall `cfWall`
with a plateau at `+∞`, whose sign-flipped, rescaled potential `cfV = −24(cfWall + 1/32)`
carries an explicit square-integrable classical solution at `z = i`.

## The construction

As in the previous module, the problem is run backwards.  For `W = e^{p + iq}` with `p, q`
real,

`W''/W = (p'' + p'² − q'²) + i(q'' + 2p'q')`,

so `W` solves `W'' = (V − i)W` for the *real* potential `V = p'' + p'² − q'²` exactly when
`q'' + 2p'q' = −1`, and `W ∈ L²` exactly when `e^{2p}` is integrable.  Writing `q' = f`, the
imaginary equation forces `p' = −(1 + f')/(2f)`.  Choosing the **exponential** phase
derivative

`f(y) = q'(y) = 1 + e^{−y}`

gives `p'(y) = −(1/2)·tanh(y/2)`, i.e. `p(y) = −log cosh(y/2)`, so
`‖W(y)‖² = 1/cosh²(y/2) ≤ 4/(1 + y²)` is integrable, and

`V(y) = p'' + p'² − q'² = 1/4 − 1/(2 cosh²(y/2)) − (1 + e^{−y})²`,

which is `≤ 1/4 − e^{−2y}` everywhere (an exponential well at `−∞`) and tends to `−3/4` at
`+∞` (the plateau).  Its wall form `cfWall = −V/24 − 1/32` is non-negative, grows at least
like `e^{−y}/12` at `−∞`, and tends to `0` at `+∞`.

## What is proved

* `cfSol_isL2Ode` — the explicit `W` is a square-integrable classical solution of
  `W'' = (cfV − i)W`;
* `cfV_not_deficiencyTrivialAt_I`, `cfV_not_deficiencyTrivialAt_negI` — *both* deficiency
  spaces of `−d²/dy² + cfV` are nontrivial (deficiency indices `≥ (1,1)`);
* **`cfV_not_essentiallySelfAdjoint`** — `−d²/dy² + cfV` is not essentially self-adjoint on
  the compactly supported smooth core of `L²(ℝ)`;
* `cfWall_nonneg`, `cfWall_ge_exp`, `cfWall_tendsto_atBot`, `cfWall_tendsto_atTop`,
  `cfV_eq_wall` — the wall form: a *non-negative* potential with the exponential-wall /
  plateau profile of the Starobinsky conformal fiber, related to `cfV` by the sign flip and
  rescaling above;
* `exists_wall_potential_wrongSign_not_essentiallySelfAdjoint` — the packaged statement.

## Honest boundary

This settles the *shape* claim of QG-2 Case B: with the conformal direction's wrong-sign
kinetic term, a non-negative exponential wall does **not** restore essential self-adjointness
— the sign of the kinetic term, not the wall, decides.  It does **not** compute the
deficiency indices of the densitized conformal operator of the manuscript itself (whose wall
is the specific Starobinsky `K(1 − e^{−aφ})²`), and it makes no claim about the full quantum
gravity operator.  The relation to the wrong-sign fiber is recorded at the level of the
potential (`cfV_eq_wall`); the operator in the Lean statements is always the standard
`wallHam`, `−d²/dy² + V`.
-/

namespace BookProof.ConformalFiberDeficiency

open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

/-! ## 1. The real ingredients -/

/-- The log-modulus `p(y) = −log cosh(y/2)` of the solution. -/
def cfP : ℝ → ℝ := fun y => -Real.log (Real.cosh (y / 2))

/-- `p'(y) = −sinh(y/2)/(2 cosh(y/2)) = −½ tanh(y/2)`. -/
def cfP' : ℝ → ℝ := fun y => -(Real.sinh (y / 2) / (2 * Real.cosh (y / 2)))

/-- `p''(y) = −1/(4 cosh²(y/2))`. -/
def cfP'' : ℝ → ℝ := fun y => -(1 / (4 * Real.cosh (y / 2) ^ 2))

/-- The phase `q(y) = y − e^{−y}`. -/
def cfQ : ℝ → ℝ := fun y => y - Real.exp (-y)

/-- `q'(y) = 1 + e^{−y}` — the exponential phase derivative that produces the wall. -/
def cfQ' : ℝ → ℝ := fun y => 1 + Real.exp (-y)

/-- **The potential** `V(y) = 1/4 − 1/(2 cosh²(y/2)) − (1 + e^{−y})²`: smooth, real,
exponentially unbounded below at `−∞` and constant (`= −3/4`) at `+∞` — the sign-flipped
conformal-fiber profile. -/
def cfV : ℝ → ℝ := fun y =>
  1 / 4 - 1 / (2 * Real.cosh (y / 2) ^ 2) - (1 + Real.exp (-y)) ^ 2

lemma cosh_half_ne_zero (y : ℝ) : Real.cosh (y / 2) ≠ 0 := (Real.cosh_pos _).ne'

lemma hasDerivAt_cfP (y : ℝ) : HasDerivAt cfP (cfP' y) y := by
  have hc : HasDerivAt (fun t : ℝ => Real.cosh (t / 2)) (Real.sinh (y / 2) * (1 / 2)) y := by
    simpa using (Real.hasDerivAt_cosh (y / 2)).comp y ((hasDerivAt_id y).div_const 2)
  have hlog := (hc.log (cosh_half_ne_zero y)).neg
  convert hlog using 1
  unfold cfP'
  have hcne : Real.cosh (y / 2) ≠ 0 := cosh_half_ne_zero y
  field_simp

lemma hasDerivAt_cfP' (y : ℝ) : HasDerivAt cfP' (cfP'' y) y := by
  have hs : HasDerivAt (fun t : ℝ => Real.sinh (t / 2)) (Real.cosh (y / 2) * (1 / 2)) y := by
    simpa using (Real.hasDerivAt_sinh (y / 2)).comp y ((hasDerivAt_id y).div_const 2)
  have hc : HasDerivAt (fun t : ℝ => 2 * Real.cosh (t / 2))
      (2 * (Real.sinh (y / 2) * (1 / 2))) y := by
    simpa using
      ((Real.hasDerivAt_cosh (y / 2)).comp y ((hasDerivAt_id y).div_const 2)).const_mul 2
  have hcne : (2 : ℝ) * Real.cosh (y / 2) ≠ 0 := by
    have := Real.cosh_pos (y / 2); positivity
  have h := (hs.div hc hcne).neg
  convert h using 1
  unfold cfP''
  have hc0 : Real.cosh (y / 2) ≠ 0 := cosh_half_ne_zero y
  have hid : Real.sinh (y / 2) ^ 2 = Real.cosh (y / 2) ^ 2 - 1 := by
    have := Real.cosh_sq (y / 2); linarith
  field_simp
  nlinarith [hid, Real.cosh_pos (y / 2)]

lemma hasDerivAt_cfQ (y : ℝ) : HasDerivAt cfQ (cfQ' y) y := by
  have h : HasDerivAt (fun t : ℝ => t - Real.exp (-t)) (1 - -Real.exp (-y)) y := by
    simpa using (hasDerivAt_id y).sub ((hasDerivAt_neg y).exp)
  have heq : 1 - -Real.exp (-y) = cfQ' y := by unfold cfQ'; ring
  rw [← heq]
  exact h

lemma hasDerivAt_cfQ' (y : ℝ) : HasDerivAt cfQ' (-Real.exp (-y)) y := by
  unfold cfQ'
  simpa using ((hasDerivAt_neg y).exp).const_add (1 : ℝ)

/-- `V` is smooth: `cosh` never vanishes. -/
lemma contDiff_cfV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) cfV := by
  have hden : ∀ y : ℝ, 2 * Real.cosh (y / 2) ^ 2 ≠ 0 := by
    intro y
    have := Real.cosh_pos (y / 2)
    positivity
  have hcosh : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun y : ℝ => 2 * Real.cosh (y / 2) ^ 2 := by
    fun_prop
  have h1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
      fun y : ℝ => 1 / (2 * Real.cosh (y / 2) ^ 2) :=
    ContDiff.div contDiff_const hcosh hden
  have h2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun y : ℝ => (1 + Real.exp (-y)) ^ 2 := by
    fun_prop
  exact (contDiff_const.sub h1).sub h2

/-! ## 2. The two algebraic identities -/

/-- The half-angle identity `sinh(y/2)·(1 + e^{−y}) = cosh(y/2)·(1 − e^{−y})`, i.e.
`tanh(y/2) = (1 − e^{−y})/(1 + e^{−y})`. -/
lemma cf_sinh_cosh (y : ℝ) :
    Real.sinh (y / 2) * (1 + Real.exp (-y)) = Real.cosh (y / 2) * (1 - Real.exp (-y)) := by
  rw [Real.sinh_eq, Real.cosh_eq]
  have hA : Real.exp (-(y / 2)) = (Real.exp (y / 2))⁻¹ := Real.exp_neg _
  have hy : Real.exp (-y) = (Real.exp (y / 2))⁻¹ ^ 2 := by
    rw [← Real.exp_neg, ← Real.exp_nat_mul]; ring_nf
  have hpos : Real.exp (y / 2) ≠ 0 := (Real.exp_pos _).ne'
  rw [hA, hy]
  field_simp

/-- The real part of the Riccati equation: `p'' + p'² − q'² = V`. -/
lemma cf_real_part (y : ℝ) : cfP'' y + cfP' y ^ 2 - cfQ' y ^ 2 = cfV y := by
  have hc0 : Real.cosh (y / 2) ≠ 0 := cosh_half_ne_zero y
  have hid : Real.sinh (y / 2) ^ 2 = Real.cosh (y / 2) ^ 2 - 1 := by
    have := Real.cosh_sq (y / 2); linarith
  unfold cfP'' cfP' cfQ' cfV
  field_simp
  nlinarith [hid]

/-- The imaginary part of the Riccati equation: `q'' + 2p'q' = −1`. -/
lemma cf_imag_part (y : ℝ) : -Real.exp (-y) + 2 * cfP' y * cfQ' y = -1 := by
  have hc0 : Real.cosh (y / 2) ≠ 0 := cosh_half_ne_zero y
  have h := cf_sinh_cosh y
  unfold cfP' cfQ'
  field_simp
  linarith [h]

/-! ## 3. The solution -/

/-- **The deficiency vector** `W = e^{p + iq}`. -/
def cfSol : ℝ → ℂ := fun y =>
  Complex.exp (((cfP y : ℝ) : ℂ) + Complex.I * ((cfQ y : ℝ) : ℂ))

/-- Its logarithmic derivative `p' + iq'`. -/
def cfLog' : ℝ → ℂ := fun y => ((cfP' y : ℝ) : ℂ) + Complex.I * ((cfQ' y : ℝ) : ℂ)

lemma cfSol_ne_zero (y : ℝ) : cfSol y ≠ 0 := Complex.exp_ne_zero _

lemma hasDerivAt_cfLogFun (y : ℝ) :
    HasDerivAt (fun t : ℝ => ((cfP t : ℝ) : ℂ) + Complex.I * ((cfQ t : ℝ) : ℂ))
      (cfLog' y) y :=
  ((hasDerivAt_cfP y).ofReal_comp).add (((hasDerivAt_cfQ y).ofReal_comp).const_mul Complex.I)

lemma hasDerivAt_cfSol (y : ℝ) : HasDerivAt cfSol (cfLog' y * cfSol y) y := by
  have h := (hasDerivAt_cfLogFun y).cexp
  simpa [cfSol, mul_comm] using h

/-- The algebraic heart: `(p'' + i(−e^{−y})) + (p' + iq')² = V − i`. -/
lemma cfLog_ode (y : ℝ) :
    (((cfP'' y : ℝ) : ℂ) + Complex.I * ((-Real.exp (-y) : ℝ) : ℂ)) + cfLog' y ^ 2
      = ((cfV y : ℝ) : ℂ) - Complex.I := by
  have h1 : ((cfP'' y + cfP' y ^ 2 - cfQ' y ^ 2 : ℝ) : ℂ) = ((cfV y : ℝ) : ℂ) := by
    rw [cf_real_part y]
  have h2 : ((-Real.exp (-y) + 2 * cfP' y * cfQ' y : ℝ) : ℂ) = ((-1 : ℝ) : ℂ) := by
    rw [cf_imag_part y]
  unfold cfLog'
  push_cast at h1 h2 ⊢
  linear_combination h1 + Complex.I * h2 + ((cfQ' y : ℂ)) ^ 2 * Complex.I_sq

lemma hasDerivAt_cfLog' (y : ℝ) :
    HasDerivAt cfLog' (((cfP'' y : ℝ) : ℂ) + Complex.I * ((-Real.exp (-y) : ℝ) : ℂ)) y :=
  ((hasDerivAt_cfP' y).ofReal_comp).add
    (((hasDerivAt_cfQ' y).ofReal_comp).const_mul Complex.I)

lemma hasDerivAt_cfSol' (y : ℝ) :
    HasDerivAt (fun t => cfLog' t * cfSol t)
      ((((cfV y : ℝ) : ℂ) - Complex.I) * cfSol y) y := by
  have h := (hasDerivAt_cfLog' y).mul (hasDerivAt_cfSol y)
  have hval : (((cfP'' y : ℝ) : ℂ) + Complex.I * ((-Real.exp (-y) : ℝ) : ℂ)) * cfSol y
      + cfLog' y * (cfLog' y * cfSol y)
      = (((cfV y : ℝ) : ℂ) - Complex.I) * cfSol y := by
    have hode := cfLog_ode y
    linear_combination cfSol y * hode
  rw [← hval]
  exact h

/-! ## 4. Square integrability -/

lemma norm_cfSol (y : ℝ) : ‖cfSol y‖ = 1 / Real.cosh (y / 2) := by
  rw [cfSol, Complex.norm_exp]
  have h : (((cfP y : ℝ) : ℂ) + Complex.I * ((cfQ y : ℝ) : ℂ)).re = cfP y := by simp
  rw [h, cfP, Real.exp_neg, Real.exp_log (Real.cosh_pos _)]
  ring

lemma sq_le_sinh_sq (t : ℝ) : t ^ 2 ≤ Real.sinh t ^ 2 := by
  rcases le_total 0 t with ht | ht
  · have h := Real.self_le_sinh_iff.mpr ht
    nlinarith
  · have h : -t ≤ Real.sinh (-t) := Real.self_le_sinh_iff.mpr (by linarith)
    rw [Real.sinh_neg] at h
    nlinarith

lemma cfSol_sq_le (y : ℝ) : ‖cfSol y‖ ^ 2 ≤ 4 * (1 + y ^ 2)⁻¹ := by
  have hid : Real.cosh (y / 2) ^ 2 = Real.sinh (y / 2) ^ 2 + 1 := Real.cosh_sq _
  have hs := sq_le_sinh_sq (y / 2)
  have hpos : (0 : ℝ) < 1 + y ^ 2 := by positivity
  have hrw : (4 : ℝ) * (1 + y ^ 2)⁻¹ = 4 / (1 + y ^ 2) := by
    rw [inv_eq_one_div]; ring
  rw [norm_cfSol, div_pow, one_pow, hrw, div_le_div_iff₀ (by positivity) hpos]
  nlinarith

lemma continuous_cfSol : Continuous cfSol :=
  continuous_iff_continuousAt.2 fun y => (hasDerivAt_cfSol y).continuousAt

lemma memLp_cfSol : MemLp cfSol 2 (volume : Measure ℝ) := by
  refine (memLp_two_iff_integrable_sq_norm continuous_cfSol.aestronglyMeasurable).2 ?_
  have hg : Integrable (fun x : ℝ => 4 * (1 + x ^ 2)⁻¹) volume :=
    integrable_inv_one_add_sq.const_mul _
  refine Integrable.mono' hg ((continuous_cfSol.norm.pow 2).aestronglyMeasurable) ?_
  filter_upwards with x
  rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
  exact cfSol_sq_le x

/-! ## 5. The failure of essential self-adjointness -/

/-- **The explicit square-integrable classical solution at `z = i`.** -/
theorem cfSol_isL2Ode : IsL2Ode cfV Complex.I cfSol :=
  ⟨fun y => cfLog' y * cfSol y, hasDerivAt_cfSol, hasDerivAt_cfSol', memLp_cfSol⟩

/-- **The deficiency space of `−d²/dy² + cfV` at `i` is nontrivial.** -/
theorem cfV_not_deficiencyTrivialAt_I :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam cfV contDiff_cfV) Complex.I :=
  not_deficiencyTrivialAt_of_l2_solution _ _ Complex.I cfSol_isL2Ode ⟨0, cfSol_ne_zero 0⟩

/-- **The deficiency space at `−i` is nontrivial too**, so both deficiency indices of
`−d²/dy² + cfV` are positive. -/
theorem cfV_not_deficiencyTrivialAt_negI :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam cfV contDiff_cfV) (-Complex.I) := by
  have h := cfV_not_deficiencyTrivialAt_I
  rw [deficiencyTrivialAt_conj_iff cfV contDiff_cfV Complex.I] at h
  simpa using h

/-- **`−d²/dy² + cfV` is not essentially self-adjoint** on the compactly supported smooth
core of `L²(ℝ)`. -/
theorem cfV_not_essentiallySelfAdjoint :
    ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam cfV contDiff_cfV) :=
  not_essentiallySelfAdjointOn_of_l2_solution _ _ cfSol_isL2Ode ⟨0, cfSol_ne_zero 0⟩

/-! ## 6. The wall form: the conformal-fiber profile -/

/-- **The wall potential** `U = −V/24 − 1/32`: the non-negative exponential wall whose
wrong-sign fiber operator `(1/24) d²/dy² + U + 1/32` is `−1/24` times `−d²/dy² + cfV`. -/
def cfWall : ℝ → ℝ := fun y => -(cfV y) / 24 - 1 / 32

/-- The wall in manifestly non-negative form. -/
lemma cfWall_eq (y : ℝ) :
    cfWall y = 1 / (48 * Real.cosh (y / 2) ^ 2) + ((1 + Real.exp (-y)) ^ 2 - 1) / 24 := by
  have hc0 : Real.cosh (y / 2) ≠ 0 := cosh_half_ne_zero y
  unfold cfWall cfV
  field_simp
  ring

/-- **The wall is non-negative** — the Starobinsky sign. -/
lemma cfWall_nonneg (y : ℝ) : 0 ≤ cfWall y := by
  have hc : 0 < Real.cosh (y / 2) := Real.cosh_pos _
  have he : 0 < Real.exp (-y) := Real.exp_pos _
  rw [cfWall_eq]
  have h1 : 0 < 1 / (48 * Real.cosh (y / 2) ^ 2) := by positivity
  have h2 : 0 ≤ ((1 + Real.exp (-y)) ^ 2 - 1) / 24 := by nlinarith
  linarith

/-- **The wall grows at least like `e^{−y}/12`** — exponential at `−∞`. -/
lemma cfWall_ge_exp (y : ℝ) : Real.exp (-y) / 12 ≤ cfWall y := by
  have hc : 0 < Real.cosh (y / 2) := Real.cosh_pos _
  have he : 0 < Real.exp (-y) := Real.exp_pos _
  rw [cfWall_eq]
  have h1 : 0 < 1 / (48 * Real.cosh (y / 2) ^ 2) := by positivity
  have h2 : Real.exp (-y) / 12 ≤ ((1 + Real.exp (-y)) ^ 2 - 1) / 24 := by nlinarith
  linarith

/-- **The sign flip and rescaling**: `cfV = −24·(cfWall + 1/32)`, i.e. `−d²/dy² + cfV` is
`−24` times the wrong-sign conformal fiber `(1/24) d²/dy² + cfWall + 1/32`. -/
lemma cfV_eq_wall (y : ℝ) : cfV y = -24 * (cfWall y + 1 / 32) := by
  unfold cfWall; ring

/-! ## 7. The asymptotic profile -/

/-- `V(y) ≤ 1/4 − e^{−2y}`: an exponential well at `−∞`. -/
lemma cfV_le (y : ℝ) : cfV y ≤ 1 / 4 - Real.exp (-(2 * y)) := by
  have hc : 0 < Real.cosh (y / 2) := Real.cosh_pos _
  have he : 0 < Real.exp (-y) := Real.exp_pos _
  have hsq : Real.exp (-(2 * y)) = Real.exp (-y) * Real.exp (-y) := by
    rw [← Real.exp_add]; ring_nf
  have h1 : 0 < 1 / (2 * Real.cosh (y / 2) ^ 2) := by positivity
  unfold cfV
  rw [hsq]
  nlinarith

lemma tendsto_exp_neg_two_atBot :
    Tendsto (fun y : ℝ => Real.exp (-(2 * y))) atBot atTop := by
  have h1 : Tendsto (fun y : ℝ => 2 * y) atBot atBot :=
    Filter.Tendsto.const_mul_atBot two_pos tendsto_id
  have h2 : Tendsto (fun y : ℝ => -(2 * y)) atBot atTop := tendsto_neg_atBot_atTop.comp h1
  exact Real.tendsto_exp_atTop.comp h2

/-- **The potential is exponentially unbounded below at `−∞`** — the limit-circle end. -/
theorem cfV_tendsto_atBot : Tendsto cfV atBot atBot := by
  refine tendsto_atBot_mono cfV_le ?_
  have h := tendsto_neg_atTop_atBot.comp tendsto_exp_neg_two_atBot
  have h2 := tendsto_atBot_add_const_left atBot (1 / 4 : ℝ) h
  simpa [Function.comp, sub_eq_add_neg] using h2

lemma cfSech_le (t : ℝ) : 1 / (2 * Real.cosh (t / 2) ^ 2) ≤ 2 * Real.exp (-t) := by
  have hct : 0 < Real.cosh (t / 2) := Real.cosh_pos _
  have h1 : Real.exp (t / 2) / 2 ≤ Real.cosh (t / 2) := by
    rw [Real.cosh_eq]
    have := Real.exp_pos (-(t / 2))
    linarith
  have hexp : Real.exp (t / 2) * Real.exp (t / 2) = Real.exp t := by
    rw [← Real.exp_add]; ring_nf
  have hrw : 2 * Real.exp (-t) = 2 / Real.exp t := by
    rw [Real.exp_neg]; ring
  rw [hrw, div_le_div_iff₀ (by positivity) (Real.exp_pos t)]
  nlinarith [Real.exp_pos (t / 2)]

lemma tendsto_cfSech_atTop :
    Tendsto (fun y : ℝ => 1 / (2 * Real.cosh (y / 2) ^ 2)) atTop (𝓝 0) :=
  squeeze_zero (fun t => by have := Real.cosh_pos (t / 2); positivity) cfSech_le
    (by simpa using Real.tendsto_exp_neg_atTop_nhds_zero.const_mul (2 : ℝ))

/-- **The potential flattens to the plateau `−3/4` at `+∞`** — the limit-point end. -/
theorem cfV_tendsto_atTop : Tendsto cfV atTop (𝓝 (-(3 / 4))) := by
  have h0 : Tendsto (fun y : ℝ => 1 + Real.exp (-y)) atTop (𝓝 (1 + 0)) :=
    (tendsto_const_nhds (x := (1 : ℝ))).add Real.tendsto_exp_neg_atTop_nhds_zero
  have hB : Tendsto (fun y : ℝ => (1 + Real.exp (-y)) ^ 2) atTop (𝓝 1) := by
    simpa using h0.pow 2
  have h := ((tendsto_const_nhds (x := (1 / 4 : ℝ))).sub tendsto_cfSech_atTop).sub hB
  have hval : (1 / 4 : ℝ) - 0 - 1 = -(3 / 4) := by norm_num
  rw [hval] at h
  exact h

/-- **The wall is exponentially large at `−∞`.** -/
theorem cfWall_tendsto_atBot : Tendsto cfWall atBot atTop := by
  refine tendsto_atTop_mono cfWall_ge_exp ?_
  have h1 : Tendsto (fun y : ℝ => Real.exp (-y)) atBot atTop :=
    Real.tendsto_exp_atTop.comp tendsto_neg_atBot_atTop
  simpa [div_eq_inv_mul] using h1.atTop_div_const (by norm_num : (0 : ℝ) < 12)

/-- **The wall flattens to `0` at `+∞`.** -/
theorem cfWall_tendsto_atTop : Tendsto cfWall atTop (𝓝 0) := by
  have h := cfV_tendsto_atTop
  have h2 : Tendsto (fun y => -(cfV y) / 24 - 1 / 32) atTop (𝓝 (-(-(3 / 4)) / 24 - 1 / 32)) :=
    ((h.neg).div_const 24).sub_const _
  have hval : -(-(3 / 4 : ℝ)) / 24 - 1 / 32 = 0 := by norm_num
  rw [hval] at h2
  exact h2

/-! ## 8. The packaged statement -/

/-- **QG-2 Case B, in the shape the plan states it.**  There is a *non-negative* potential
`U` with the conformal-fiber profile — exponentially large at `−∞`, tending to `0` at `+∞` —
such that the associated wrong-sign Schrödinger operator, in its rescaled standard form
`−d²/dy² + V` with `V = −24(U + 1/32)`, is **not** essentially self-adjoint on the compactly
supported smooth core.  So the wall does not restore essential self-adjointness once the
kinetic term carries the conformal (wrong) sign. -/
theorem exists_wall_potential_wrongSign_not_essentiallySelfAdjoint :
    ∃ (U V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V),
      (∀ y, 0 ≤ U y) ∧ Tendsto U atBot atTop ∧ Tendsto U atTop (𝓝 0) ∧
        (∀ y, V y = -24 * (U y + 1 / 32)) ∧
        ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) :=
  ⟨cfWall, cfV, contDiff_cfV, cfWall_nonneg, cfWall_tendsto_atBot, cfWall_tendsto_atTop,
    cfV_eq_wall, cfV_not_essentiallySelfAdjoint⟩

end

/-! ## Audit -/

section Audit

#print axioms cfSol_isL2Ode
#print axioms cfV_not_deficiencyTrivialAt_I
#print axioms cfV_not_deficiencyTrivialAt_negI
#print axioms cfV_not_essentiallySelfAdjoint
#print axioms cfV_tendsto_atBot
#print axioms cfV_tendsto_atTop
#print axioms cfWall_tendsto_atBot
#print axioms cfWall_tendsto_atTop
#print axioms exists_wall_potential_wrongSign_not_essentiallySelfAdjoint

end Audit

end BookProof.ConformalFiberDeficiency
