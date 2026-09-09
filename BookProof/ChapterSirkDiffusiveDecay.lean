import Mathlib
import BookProof.ChapterH4

/-!
# Chapter SirkDiffusiveDecay — the laminar (diffusive) decay rate

`CONSOLIDATED_PLAN.md` §12.2 **Gap 2, NS Lagrangian**: "the ν-dependent
constants; **the diffusive decay statement** (the laminar `νk²` decay rate the
numerics measure)".

The NS Lagrangian generator has a positive parabolic part `½ Σ Pᵢ² + ν Σ Qᵢ²`.
What the numerics measure in the laminar regime is the exponential decay of the
parabolic semigroup at the rate given by the coercivity constant of that part —
`νk²` for the mode `k`.  This chapter proves the statement in the form the
formalization can carry: for a *coercive* bounded generator, the parabolic
semigroup decays at exactly the coercivity rate, and the SIRK reduction inherits
the rate exactly.

## Deliverables

* `heatFlow A t = exp (−t • A)` — the parabolic semigroup of a bounded generator,
  with `heatFlow_zero`, `heatFlow_apply_comm`.
* `hasDerivAt_heatFlow_apply` — the semigroup solves the abstract heat equation
  `u'(t) = −A u(t)`.
* `hasDerivAt_heatFlow_normSq` — the energy identity `d/dt ‖u(t)‖² =
  −2 Re⟪u(t), A u(t)⟫`.
* `IsCoercive A μ` — the coercivity `μ‖x‖² ≤ Re⟪x, A x⟫` (for the parabolic part
  of the Lagrangian generator, `μ = νk²`).
* `norm_heatFlow_apply_le` — **headline (the diffusive decay)**: a coercive
  generator has `‖e^{−tA} v‖ ≤ e^{−μt} ‖v‖` for every `t ≥ 0`.
* `norm_heatFlow_le` — the same in operator norm, `‖e^{−tA}‖ ≤ e^{−μt}`.
* `isCoercive_compress` — **the reduced model has the same rate**: the SIRK
  compression `V∗AV` of a coercive generator along an isometry is coercive with
  the *same* constant, so
* `norm_heatFlow_compress_apply_le` — the reduced propagator obeys the same
  laminar decay bound `e^{−μt}` at every reduction order: the decay rate the
  numerics read off the reduced model is not an artefact of the reduction.

## Honest boundary

`μ` is the coercivity constant of the generator as an operator; identifying it
with `νk²` for a *particular* discretisation is the content of the per-mode
symbol computations already in the Navier–Stokes chapters, and the numerical
value of `ν` is an input, not a theorem.  The generator here is bounded (the
regime in which the project's Galerkin/Hashimoto reduction is an operator
statement); the unbounded case is the standing Stone/Trotter–Kato boundary.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterSirkDiffusiveDecay

open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-! ## 1. The parabolic semigroup -/

/-- The parabolic (heat) semigroup `e^{−tA}` of a bounded generator. -/
def heatFlow (A : E →L[ℂ] E) (t : ℝ) : E →L[ℂ] E := exp ((-t) • A)

@[simp] theorem heatFlow_zero (A : E →L[ℂ] E) : heatFlow A 0 = 1 := by
  simp [heatFlow]

/-- The generator commutes with its own semigroup. -/
theorem heatFlow_apply_comm (A : E →L[ℂ] E) (t : ℝ) (v : E) :
    heatFlow A t (A v) = A (heatFlow A t v) := by
  have hcomm : exp ((-t) • A) * A = A * exp ((-t) • A) :=
    (((Commute.refl A).smul_right (-t)).exp_right.eq).symm
  have := congrArg (fun T : E →L[ℂ] E => T v) hcomm
  simpa [heatFlow, ContinuousLinearMap.mul_apply] using this

/-- **The semigroup solves the heat equation** `u'(t) = −A u(t)`. -/
theorem hasDerivAt_heatFlow_apply (A : E →L[ℂ] E) (v : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => heatFlow A s v) (-(A (heatFlow A t v))) t := by
  have h0 := hasDerivAt_exp_smul_const (𝕂 := ℝ) A (-t)
  have hneg : HasDerivAt (fun s : ℝ => -s) (-1 : ℝ) t := (hasDerivAt_id t).neg
  have h : HasDerivAt (fun s : ℝ => exp ((-s) • A)) (-(exp ((-t) • A) * A)) t := by
    simpa [Function.comp_def] using h0.scomp t hneg
  have h2 := ((ContinuousLinearMap.apply ℂ E v).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt t h
  rw [← heatFlow_apply_comm A t v]
  simpa [heatFlow, Function.comp_def, ContinuousLinearMap.mul_apply] using h2

/-- **The energy identity** `d/dt ‖u(t)‖² = −2 Re⟪u(t), A u(t)⟫`. -/
theorem hasDerivAt_heatFlow_normSq (A : E →L[ℂ] E) (v : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => ‖heatFlow A s v‖ ^ 2)
      (-2 * (inner ℂ (heatFlow A t v) (A (heatFlow A t v)) : ℂ).re) t := by
  have hd := hasDerivAt_heatFlow_apply A v t
  have h := hd.inner ℂ hd
  have h2 := Complex.reCLM.hasFDerivAt.comp_hasDerivAt t h
  simp only [Function.comp_def, Complex.reCLM_apply, Complex.add_re, inner_neg_right,
    inner_neg_left, Complex.neg_re] at h2
  have hnorm : ∀ s : ℝ, ((inner ℂ (heatFlow A s v) (heatFlow A s v) : ℂ)).re
      = ‖heatFlow A s v‖ ^ 2 := by
    intro s
    simp [← Complex.ofReal_pow]
  have hcomm : (inner ℂ (A (heatFlow A t v)) (heatFlow A t v) : ℂ).re
      = (inner ℂ (heatFlow A t v) (A (heatFlow A t v)) : ℂ).re := by
    have h3 : (starRingEnd ℂ) (inner ℂ (heatFlow A t v) (A (heatFlow A t v)))
        = inner ℂ (A (heatFlow A t v)) (heatFlow A t v) := inner_conj_symm _ _
    rw [← h3, Complex.conj_re]
  simp only [hnorm, hcomm] at h2
  convert h2 using 1
  ring

/-! ## 2. Coercivity and the decay bound -/

/-- **Coercivity** of a generator with rate `μ`: `μ‖x‖² ≤ Re⟪x, A x⟫`.  For the
parabolic part of the Navier–Stokes Lagrangian generator this is the mode-wise
bound with `μ = νk²`. -/
def IsCoercive (A : E →L[ℂ] E) (mu : ℝ) : Prop :=
  ∀ x : E, mu * ‖x‖ ^ 2 ≤ (inner ℂ x (A x) : ℂ).re

omit [CompleteSpace E] in
/-- **The coercive class is non-degenerate**: a positive generator shifted by `μ` is
coercive with rate `μ` — the shape of the Navier–Stokes Lagrangian parabolic part,
whose lowest mode contributes the rate `ν k²`. -/
theorem isCoercive_add_algebraMap (B : E →L[ℂ] E) (mu : ℝ)
    (hB : ∀ x : E, 0 ≤ (inner ℂ x (B x) : ℂ).re) :
    IsCoercive (B + (algebraMap ℝ (E →L[ℂ] E)) mu) mu := by
  intro x
  have h : (B + (algebraMap ℝ (E →L[ℂ] E)) mu) x = B x + (mu : ℂ) • x := by
    simp [Algebra.algebraMap_eq_smul_one]
  rw [h, inner_add_right, Complex.add_re, inner_smul_right]
  have hx : (((mu : ℂ) * (inner ℂ x x : ℂ))).re = mu * ‖x‖ ^ 2 := by
    simp [inner_self_eq_norm_sq_to_K, ← Complex.ofReal_pow]
  rw [hx]
  linarith [hB x]

/-- **The diffusive decay bound.**  A coercive generator propagates with the
exponential decay of its coercivity rate: `‖e^{−tA} v‖ ≤ e^{−μt} ‖v‖` for `t ≥ 0`.
This is the laminar `νk²` decay the numerics measure. -/
theorem norm_heatFlow_apply_le (A : E →L[ℂ] E) {mu : ℝ} (hA : IsCoercive A mu) (v : E)
    {t : ℝ} (ht : 0 ≤ t) :
    ‖heatFlow A t v‖ ≤ Real.exp (-(mu * t)) * ‖v‖ := by
  -- the Grönwall functional
  set G : ℝ → ℝ := fun s => ‖heatFlow A s v‖ ^ 2 * Real.exp (2 * mu * s) with hG
  have hderiv : ∀ s : ℝ, HasDerivAt G
      ((-2 * (inner ℂ (heatFlow A s v) (A (heatFlow A s v)) : ℂ).re
        + 2 * mu * ‖heatFlow A s v‖ ^ 2) * Real.exp (2 * mu * s)) s := by
    intro s
    have h1 := hasDerivAt_heatFlow_normSq A v s
    have h2 : HasDerivAt (fun r : ℝ => Real.exp (2 * mu * r))
        (2 * mu * Real.exp (2 * mu * s)) s := by
      have := (((hasDerivAt_id s).const_mul (2 * mu)).exp)
      simpa [mul_comm, mul_left_comm, mul_assoc] using this
    have := h1.mul h2
    convert this using 1
    ring
  have hnonpos : ∀ s : ℝ, deriv G s ≤ 0 := by
    intro s
    rw [(hderiv s).deriv]
    have hco := hA (heatFlow A s v)
    have hexp : 0 < Real.exp (2 * mu * s) := Real.exp_pos _
    have : -2 * (inner ℂ (heatFlow A s v) (A (heatFlow A s v)) : ℂ).re
        + 2 * mu * ‖heatFlow A s v‖ ^ 2 ≤ 0 := by linarith
    exact mul_nonpos_of_nonpos_of_nonneg this hexp.le
  have hdiff : Differentiable ℝ G := fun s => (hderiv s).differentiableAt
  have hanti : Antitone G := antitone_of_deriv_nonpos hdiff hnonpos
  have hle : G t ≤ G 0 := hanti ht
  have hG0 : G 0 = ‖v‖ ^ 2 := by simp [hG]
  rw [hG0] at hle
  -- undo the exponential weight
  have hexp : (0 : ℝ) < Real.exp (2 * mu * t) := Real.exp_pos _
  have hsq : ‖heatFlow A t v‖ ^ 2 ≤ (Real.exp (-(mu * t)) * ‖v‖) ^ 2 := by
    have h1 : ‖heatFlow A t v‖ ^ 2 ≤ ‖v‖ ^ 2 / Real.exp (2 * mu * t) := by
      rw [le_div_iff₀ hexp]
      simpa [hG] using hle
    have h2 : (Real.exp (-(mu * t)) * ‖v‖) ^ 2 = ‖v‖ ^ 2 / Real.exp (2 * mu * t) := by
      rw [mul_pow, sq (Real.exp (-(mu * t))), ← Real.exp_add, div_eq_mul_inv,
        ← Real.exp_neg]
      ring_nf
    rw [h2]
    exact h1
  have hnn : (0 : ℝ) ≤ Real.exp (-(mu * t)) * ‖v‖ :=
    mul_nonneg (Real.exp_pos _).le (norm_nonneg _)
  nlinarith [norm_nonneg (heatFlow A t v)]

/-- The decay bound in operator norm: `‖e^{−tA}‖ ≤ e^{−μt}`. -/
theorem norm_heatFlow_le (A : E →L[ℂ] E) {mu : ℝ} (hA : IsCoercive A mu) {t : ℝ} (ht : 0 ≤ t) :
    ‖heatFlow A t‖ ≤ Real.exp (-(mu * t)) :=
  ContinuousLinearMap.opNorm_le_bound _ (Real.exp_pos _).le
    fun v => norm_heatFlow_apply_le A hA v ht

/-! ## 3. The reduced model has the same rate -/

/-- An isometric embedding preserves norms. -/
theorem norm_embedding (V : F →L[ℂ] E)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) (x : F) : ‖V x‖ = ‖x‖ := by
  have h := congrArg (fun T : F →L[ℂ] F => T x) hVV
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply,
    ContinuousLinearMap.coe_id', id_eq] at h
  have hin : (inner ℂ (V x) (V x) : ℂ) = inner ℂ x x := by
    rw [← ContinuousLinearMap.adjoint_inner_left, h]
  have := congrArg Complex.re hin
  simp only [inner_self_eq_norm_sq_to_K] at this
  have hsq : ‖V x‖ ^ 2 = ‖x‖ ^ 2 := by
    simpa [← Complex.ofReal_pow] using this
  calc ‖V x‖ = Real.sqrt (‖V x‖ ^ 2) := (Real.sqrt_sq (norm_nonneg _)).symm
    _ = Real.sqrt (‖x‖ ^ 2) := by rw [hsq]
    _ = ‖x‖ := Real.sqrt_sq (norm_nonneg _)

/-- **The SIRK reduction preserves the decay rate.**  The compression `V∗AV` of a
coercive generator along an isometry is coercive with the *same* constant. -/
theorem isCoercive_compress (V : F →L[ℂ] E) (A : E →L[ℂ] E) {mu : ℝ}
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) (hA : IsCoercive A mu) :
    IsCoercive (compress V A) mu := by
  intro x
  have hinner : (inner ℂ x (compress V A x) : ℂ) = inner ℂ (V x) (A (V x)) := by
    simp [compress, ContinuousLinearMap.adjoint_inner_right]
  rw [hinner, ← norm_embedding V hVV x]
  exact hA (V x)

/-- **The reduced propagator obeys the same laminar decay bound** at every
reduction order. -/
theorem norm_heatFlow_compress_apply_le (V : F →L[ℂ] E) (A : E →L[ℂ] E) {mu : ℝ}
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) (hA : IsCoercive A mu) (x : F)
    {t : ℝ} (ht : 0 ≤ t) :
    ‖heatFlow (compress V A) t x‖ ≤ Real.exp (-(mu * t)) * ‖x‖ :=
  norm_heatFlow_apply_le _ (isCoercive_compress V A hVV hA) x ht

end BookProof.ChapterSirkDiffusiveDecay
