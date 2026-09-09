import Mathlib
import BookProof.ChapterFarisLavine
import BookProof.ChapterNavierStokesLagrangianEsa

/-!
# Quantum gravity: the densitized tetrad variables and the flat principal part

Source: `book.tex`, chapter *"Quantum Gravity"*, §*"Classical Hamiltonian"* /
§*"Quantum Hamiltonian"* (~8138–8310), and the plan item recorded in
`CONSOLIDATED_PLAN.md` §10 (Parts A–D of the suggested
`PLAN_LEAN_SPECIALIST_QG_FLOW.md`).

The manuscript's 3D gauge-fixed gravity Hamiltonian carries the **singular**
kinetic terms

  `H = (1/16 e) S^{ab} S_{ab} − (1/24 e) P² + …`,

whose `1/e` denominator (`e = det e_i^a`, the tetrad determinant) blows up where
the tetrad degenerates.  The route the manuscript suggests is the canonical
change of variables to **densitized tetrads**

  `y = √e`,  `ẽ_i^a = √e · e_i^a`,

after which the principal part of the kinetic operator is a *flat*
d'Alembertian with the constant coefficients `(1/16, −1/24)`.

## What is proved here (Parts A–D, all `sorry`-free and `axiom`-free)

**Part A — the change of variables.**

* `densY`, `densY_sq`, `hasDerivAt_densY`, `deriv_densY` — the new coordinate
  `y = √e` and its derivative;
* `inv_eq_four_mul_deriv_densY_sq` — the **absorption identity**
  `1/e = 4 (∂y/∂e)²`: the singular denominator is a *square of a derivative of
  the new coordinate*, hence absorbed into the field derivatives.  (The plan's
  prose writes `1/e = (∂y/∂e)²`; the honest identity carries the factor `4`,
  because `∂√e/∂e = 1/(2√e)`.)
* `kinetic_absorption`, `conformal_absorption` — the two singular kinetic terms
  in densitized form: `(1/16e)S² = (1/16)(S/y)²` and `(1/24e)P² = (1/24)(P/y)²`,
  i.e. the coefficients become **constants** once the fields are densitized;
* `densTetrad`, `densTetrad_det`, `densTetrad_recover` — the densitized tetrad
  `ẽ = √e · e`, its determinant and the inverse map where `e > 0`;
* `tendsto_inv_det_atTop` versus `tendsto_densY_zero` — the honest statement of
  what the change of variables buys: `1/e → ∞` at a degenerate tetrad, while
  the new coordinate `y = √e` extends continuously by `0`.

**Part B — the flat principal part.**

* `qgSymbol` — the principal symbol `(1/16)Σξ_a² − (1/24)ξ_y²`;
  `qgSymbol_homogeneous` (it is a quadratic form),
  `qgSymbol_eq_metric_form` (it is the form of the constant metric `qgMetric`);
* `qgMetric_det_ne_zero` — the field-space metric is non-degenerate, and
  `qgSymbol_pos` / `qgSymbol_neg` / `qgSymbol_indefinite` — it is **indefinite**:
  the operator is hyperbolic (a d'Alembertian), *not* elliptic.  This is exactly
  why the elliptic Sears/Kato–Rellich route of the Navier–Stokes chapters does
  not apply and Strichartz's hyperbolic theorem is the named input;
* `christoffel_eq_zero_of_const`, `qgMetric_christoffel_zero` — for a **constant**
  field-space metric every Christoffel symbol vanishes; this is the precise form
  of the plan's remark that the densitized coordinates are flat, so the point
  transformation produces no connection ("quantum potential") corrections;
* `qgFullSymbol`, `qgFullSymbol_scaling` — the operator-order decomposition
  (2nd + 1st + 0th) as the scaling law of the full symbol.

**Part C — a realization on which the analytic hypotheses are *proved*.**  In
the Hermite (oscillator) basis the fiber operator is multiplication by the mode
symbol `λ_k = (1/16)a_k² − (1/24)b_k² + V_k`, and for that realization

* `qgModeHamiltonian_essentiallySelfAdjoint` — the operator is essentially
  self-adjoint on its maximal domain in `ℓ²(ℕ)`,
* `qgModeHamiltonian_deficiencyTrivialAt` — the deficiency space of the adjoint
  is trivial at **every** non-real `z` (the conclusion Strichartz's finite-speed
  argument is supposed to deliver in the continuum), and
* `qgModeHamiltonian_not_bounded` — the operator really is unbounded, so the
  statement is not a bounded-operator triviality.

**Part D — Strichartz as a *named hypothesis*, never an axiom.**

* `strichartz_esa_of_finiteSpeed` — the deduction step: the finite-speed /
  unique-continuation input `ker(H* − z) = 0` for `Im z ≠ 0` (P. R. Chernoff,
  *Essential self-adjointness of powers of generators of hyperbolic equations*,
  J. Funct. Anal. **12** (1973) 401–414; the earlier "Strichartz, 13 82–93"
  was a misattribution) yields essential self-adjointness;
* `strichartz_finiteSpeed_satisfiable` — the hypothesis is **not vacuous**: the
  discretized realization of Part C satisfies it;
* `qg_esa_of_farisLavine` — the alternative route, through the *proved*
  Faris–Lavine criterion of `BookProof.ChapterFarisLavine`;
* `densitized_hasZeroDeficiencyOn_transfer` — the transfer step of
  `CONSOLIDATED_PLAN.md` §10.3: once the change of variables is made unitary by
  the Jacobian half-density factor, essential self-adjointness of the flat
  (densitized) operator gives it for the physical one.

## Scope (unchanged honesty discipline)

Nothing here claims essential self-adjointness of the **continuum** gravity
operator on `L²(ℝ⁸⁴ × ℤ₂¹⁹)`, nor global existence, nor any unitary-evolution
statement for it.  The continuum conclusion needs the Strichartz input for the
flat d'Alembertian with a polynomial potential, which enters *only* as the
explicit hypothesis of `strichartz_esa_of_finiteSpeed`.
-/

namespace BookProof.QuantumGravityDensitized

open Filter Topology BookProof.FarisLavine

/-! ## Part A — the densitized change of variables -/

/-- The densitized conformal coordinate `y = √e`, `e = det e_i^a`. -/
noncomputable def densY (e : ℝ) : ℝ := Real.sqrt e

@[simp] theorem densY_zero : densY 0 = 0 := Real.sqrt_zero

theorem densY_nonneg (e : ℝ) : 0 ≤ densY e := Real.sqrt_nonneg e

theorem densY_pos {e : ℝ} (he : 0 < e) : 0 < densY e := Real.sqrt_pos.mpr he

/-- `y² = e`: the change of variables is invertible on nondegenerate tetrads. -/
theorem densY_sq {e : ℝ} (he : 0 ≤ e) : densY e ^ 2 = e := Real.sq_sqrt he

theorem continuous_densY : Continuous densY := Real.continuous_sqrt

theorem hasDerivAt_densY {e : ℝ} (he : e ≠ 0) :
    HasDerivAt densY (1 / (2 * Real.sqrt e)) e :=
  Real.hasDerivAt_sqrt he

theorem deriv_densY {e : ℝ} (he : e ≠ 0) : deriv densY e = 1 / (2 * Real.sqrt e) :=
  (hasDerivAt_densY he).deriv

/-- **The absorption identity.**  The singular factor `1/e` of the gravity
kinetic terms is `4` times the *square of the derivative of the new coordinate*,
so it is absorbed into the field derivatives by the densitized change of
variables. -/
theorem inv_eq_four_mul_deriv_densY_sq {e : ℝ} (he : 0 < e) :
    1 / e = 4 * (deriv densY e) ^ 2 := by
  rw [deriv_densY (ne_of_gt he)]
  have hs : Real.sqrt e ^ 2 = e := Real.sq_sqrt he.le
  have hpos : 0 < Real.sqrt e := Real.sqrt_pos.mpr he
  field_simp
  nlinarith [hs]

/-- The singular kinetic term in densitized form: with `S̃ = S / y` the
coefficient `1/(16 e)` becomes the **constant** `1/16`. -/
theorem kinetic_absorption (e s : ℝ) (he : 0 < e) :
    1 / (16 * e) * s ^ 2 = 1 / 16 * (s / densY e) ^ 2 := by
  have hs : densY e ^ 2 = e := Real.sq_sqrt he.le
  have hpos : 0 < densY e := densY_pos he
  field_simp
  nlinarith [hs]

/-- The singular conformal term in densitized form: with `P̃ = P / y` the
coefficient `1/(24 e)` becomes the **constant** `1/24`. -/
theorem conformal_absorption (e p : ℝ) (he : 0 < e) :
    1 / (24 * e) * p ^ 2 = 1 / 24 * (p / densY e) ^ 2 := by
  have hs : densY e ^ 2 = e := Real.sq_sqrt he.le
  have hpos : 0 < densY e := densY_pos he
  field_simp
  nlinarith [hs]

/-- The **densitized tetrad** `ẽ_i^a = √e · e_i^a`. -/
noncomputable def densTetrad (E : Matrix (Fin 3) (Fin 3) ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  Real.sqrt E.det • E

theorem densTetrad_det (E : Matrix (Fin 3) (Fin 3) ℝ) :
    (densTetrad E).det = Real.sqrt E.det ^ 3 * E.det := by
  simp [densTetrad]

/-- On a nondegenerate tetrad the densitized variables recover the original
ones: the change of variables is a bijection of `{e > 0}`. -/
theorem densTetrad_recover {E : Matrix (Fin 3) (Fin 3) ℝ} (h : 0 < E.det) :
    (Real.sqrt E.det)⁻¹ • densTetrad E = E := by
  rw [densTetrad, smul_smul, inv_mul_cancel₀ (ne_of_gt (Real.sqrt_pos.mpr h)), one_smul]

/-- **The singularity is real**: the coefficient `1/e` of the raw kinetic term
diverges as the tetrad degenerates. -/
theorem tendsto_inv_det_atTop : Tendsto (fun e : ℝ => 1 / e) (𝓝[>] (0 : ℝ)) atTop := by
  simpa using tendsto_inv_nhdsGT_zero

/-- **…and the new coordinate is regular there**: `y = √e` extends continuously
by `y = 0`.  This is the sense in which the change of variables is load-bearing
rather than cosmetic. -/
theorem tendsto_densY_zero : Tendsto densY (𝓝[>] (0 : ℝ)) (𝓝 0) :=
  (continuous_densY.tendsto' 0 0 Real.sqrt_zero).mono_left nhdsWithin_le_nhds

/-! ## Part B — the flat principal part -/

/-- The **principal symbol** of the transformed kinetic operator,
`(1/16) Σ_a ξ_a² − (1/24) ξ_y²`: a flat d'Alembertian in the densitized
variables. -/
noncomputable def qgSymbol {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) : ℝ :=
  1 / 16 * ∑ a, (xi a) ^ 2 - 1 / 24 * xiY ^ 2

/-- The principal symbol is a quadratic form (homogeneous of degree 2). -/
theorem qgSymbol_homogeneous {n : ℕ} (c : ℝ) (xi : Fin n → ℝ) (xiY : ℝ) :
    qgSymbol (fun a => c * xi a) (c * xiY) = c ^ 2 * qgSymbol xi xiY := by
  simp only [qgSymbol, mul_pow, ← Finset.mul_sum]
  ring

/-- The **flat field-space metric** of the densitized variables:
`diag(1/16, …, 1/16, −1/24)`. -/
noncomputable def qgMetric (n : ℕ) : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ :=
  Matrix.diagonal fun i => if i = Fin.last n then -(1 / 24) else 1 / 16

theorem qgMetric_det (n : ℕ) :
    (qgMetric n).det = ∏ i, (if i = Fin.last n then -(1 / 24) else 1 / 16 : ℝ) :=
  Matrix.det_diagonal

/-- The field-space metric is **non-degenerate**. -/
theorem qgMetric_det_ne_zero (n : ℕ) : (qgMetric n).det ≠ 0 := by
  rw [qgMetric_det]
  refine Finset.prod_ne_zero_iff.mpr fun i _ => ?_
  by_cases h : i = Fin.last n <;> simp [h]

/-- The momenta assembled into one covector `(ξ_a, ξ_y)` of field space. -/
def qgMomenta {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) : Fin (n + 1) → ℝ := Fin.snoc xi xiY

@[simp] theorem qgMomenta_castSucc {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) (a : Fin n) :
    qgMomenta xi xiY a.castSucc = xi a := by
  simp [qgMomenta]

@[simp] theorem qgMomenta_last {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) :
    qgMomenta xi xiY (Fin.last n) = xiY := by
  simp [qgMomenta]

/-- The principal symbol is the quadratic form of the constant metric
`qgMetric`, the momenta being assembled as `(ξ_a, ξ_y)`. -/
theorem qgSymbol_eq_metric_form {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) :
    qgSymbol xi xiY
      = ∑ i, ∑ j, qgMetric n i j * qgMomenta xi xiY i * qgMomenta xi xiY j := by
  have hdiag : ∀ i j : Fin (n + 1), qgMetric n i j
      = if i = j then (if i = Fin.last n then -(1 / 24) else 1 / 16 : ℝ) else 0 := by
    intro i j
    by_cases h : i = j <;> simp [qgMetric, h]
  have hinner : ∀ i : Fin (n + 1),
      (∑ j, qgMetric n i j * qgMomenta xi xiY i * qgMomenta xi xiY j)
        = (if i = Fin.last n then -(1 / 24) else 1 / 16 : ℝ)
          * (qgMomenta xi xiY i * qgMomenta xi xiY i) := by
    intro i
    rw [Finset.sum_eq_single i]
    · simp [hdiag i i, mul_assoc]
    · intro j _ hj
      simp [hdiag i j, Ne.symm hj]
    · intro h; exact absurd (Finset.mem_univ i) h
  rw [Finset.sum_congr rfl fun i _ => hinner i]
  rw [Fin.sum_univ_castSucc]
  have hcast : ∀ a : Fin n,
      (if (a.castSucc : Fin (n + 1)) = Fin.last n then -(1 / 24) else 1 / 16 : ℝ)
        * (qgMomenta xi xiY (a.castSucc) * qgMomenta xi xiY (a.castSucc))
        = 1 / 16 * (xi a * xi a) := by
    intro a
    simp [Fin.castSucc_lt_last a |>.ne]
  rw [Finset.sum_congr rfl fun a _ => hcast a]
  simp only [qgMomenta_last, ← Finset.mul_sum]
  simp [qgSymbol, sq]
  ring

/-- The symbol is **positive** in the purely spatial directions … -/
theorem qgSymbol_pos : 0 < qgSymbol (n := 1) (fun _ => 1) 0 := by norm_num [qgSymbol]

/-- … and **negative** in the conformal direction. -/
theorem qgSymbol_neg : qgSymbol (n := 1) (fun _ => 0) 1 < 0 := by norm_num [qgSymbol]

/-- **The principal part is hyperbolic, not elliptic**: the symbol takes both
signs.  This is the structural reason the elliptic (Sears / Kato–Rellich) route
used for the Navier–Stokes generator does not apply here, and Strichartz's
hyperbolic theorem is the named analytic input. -/
theorem qgSymbol_indefinite :
    (∃ (xi : Fin 1 → ℝ) (xiY : ℝ), 0 < qgSymbol xi xiY) ∧
      (∃ (xi : Fin 1 → ℝ) (xiY : ℝ), qgSymbol xi xiY < 0) :=
  ⟨⟨fun _ => 1, 0, qgSymbol_pos⟩, ⟨fun _ => 0, 1, qgSymbol_neg⟩⟩

/-- The directional derivative of a field-space metric coefficient. -/
noncomputable def metricDeriv {m : ℕ} (g : EuclideanSpace ℝ (Fin m) → Matrix (Fin m) (Fin m) ℝ)
    (q : EuclideanSpace ℝ (Fin m)) (i k l : Fin m) : ℝ :=
  fderiv ℝ (fun p => g p k l) q (EuclideanSpace.single i 1)

/-- The Christoffel symbols of a field-space metric `g` with inverse `ginv`. -/
noncomputable def christoffel {m : ℕ} (g ginv : EuclideanSpace ℝ (Fin m) → Matrix (Fin m) (Fin m) ℝ)
    (q : EuclideanSpace ℝ (Fin m)) (k i j : Fin m) : ℝ :=
  1 / 2 * ∑ l, ginv q k l *
    (metricDeriv g q i l j + metricDeriv g q j l i - metricDeriv g q l i j)

/-- **A constant field-space metric is flat**: all Christoffel symbols vanish.
This is why the densitized point transformation produces no connection
("quantum potential") corrections — the transformed operator is exactly
`H₀ + H₁ − Ṽ`. -/
theorem christoffel_eq_zero_of_const {m : ℕ} (g0 : Matrix (Fin m) (Fin m) ℝ)
    (ginv : EuclideanSpace ℝ (Fin m) → Matrix (Fin m) (Fin m) ℝ)
    (q : EuclideanSpace ℝ (Fin m)) (k i j : Fin m) :
    christoffel (fun _ => g0) ginv q k i j = 0 := by
  simp [christoffel, metricDeriv]

/-- The densitized gravity metric in particular is flat. -/
theorem qgMetric_christoffel_zero {n : ℕ}
    (ginv : EuclideanSpace ℝ (Fin (n + 1)) → Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ)
    (q : EuclideanSpace ℝ (Fin (n + 1))) (k i j : Fin (n + 1)) :
    christoffel (fun _ => qgMetric n) ginv q k i j = 0 :=
  christoffel_eq_zero_of_const _ ginv q k i j

/-- The **full symbol** of the transformed Hamiltonian: principal part (order 2)
plus a first-order part `b·ξ` plus the potential `−Ṽ`. -/
noncomputable def qgFullSymbol {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ)
    (b : Fin n → ℝ) (bY : ℝ) (V : ℝ) : ℝ :=
  qgSymbol xi xiY + ((∑ a, b a * xi a) + bY * xiY) - V

/-- **The operator-order decomposition**, in the form that identifies the three
orders: rescaling the momenta by `c` multiplies the second-order part by `c²`,
the first-order part by `c`, and leaves the potential alone. -/
theorem qgFullSymbol_scaling {n : ℕ} (c : ℝ) (xi : Fin n → ℝ) (xiY : ℝ)
    (b : Fin n → ℝ) (bY : ℝ) (V : ℝ) :
    qgFullSymbol (fun a => c * xi a) (c * xiY) b bY V
      = c ^ 2 * qgSymbol xi xiY + c * ((∑ a, b a * xi a) + bY * xiY) - V := by
  simp only [qgFullSymbol, qgSymbol_homogeneous]
  have hsum : ∑ a, b a * (c * xi a) = c * ∑ a, b a * xi a := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => by ring
  rw [hsum]
  ring

/-! ## Part C — the Hermite-basis realization, where the hypotheses are proved -/

/-- The **mode symbol** of the transformed gravity Hamiltonian in the Hermite
(oscillator) basis: `λ_k = (1/16) a_k² − (1/24) b_k² + V_k`, the hyperbolic
principal part plus the potential, mode by mode. -/
noncomputable def qgModeSymbol (a b V : ℕ → ℝ) (k : ℕ) : ℝ :=
  1 / 16 * (a k) ^ 2 - 1 / 24 * (b k) ^ 2 + V k

/-- The gravity fiber operator in the Hermite basis: multiplication by the mode
symbol on its maximal domain in `ℓ²(ℕ)`. -/
noncomputable def qgModeHamiltonian (a b V : ℕ → ℝ) :
    mulSymbolDomain (qgModeSymbol a b V) →ₗ[ℂ] L2Nat :=
  mulHamiltonian (qgModeSymbol a b V)

/-- **The discretized gravity Hamiltonian is essentially self-adjoint** on its
maximal domain, by the *proved* Faris–Lavine criterion of
`BookProof.ChapterFarisLavine`. -/
theorem qgModeHamiltonian_essentiallySelfAdjoint (a b V : ℕ → ℝ) :
    EssentiallySelfAdjointOn (mulSymbolDomain (qgModeSymbol a b V)) (qgModeHamiltonian a b V) :=
  mulHamiltonian_essentiallySelfAdjoint _

/-- The value of the operator on a basis state. -/
theorem mulHamiltonian_mulBasis (lam : ℕ → ℝ) (n : ℕ) :
    (mulHamiltonian lam (mulBasis lam n) : L2Nat) = lp.single 2 n ((lam n : ℂ)) := by
  ext m
  by_cases hmn : m = n
  · subst hmn
    simp [mulHamiltonian, mulSymbolOp, mulBasis, mulSymbolFun, lp.single_apply]
  · simp [mulHamiltonian, mulSymbolOp, mulBasis, mulSymbolFun, lp.single_apply,
      Pi.single_eq_of_ne hmn]

/-- **The deficiency space of the adjoint is trivial at every non-real `z`** for
multiplication by a real symbol.  This is precisely the conclusion that
Strichartz's finite-speed argument is supposed to deliver for the continuum
d'Alembertian; here it is *proved* for the discretized (Hermite-basis)
realization. -/
theorem mulHamiltonian_deficiencyTrivialAt (lam : ℕ → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (mulSymbolDomain lam) (mulHamiltonian lam) z := by
  intro w hw
  have hcoe : ∀ n : ℕ, ((w : L2Nat) : ℕ → ℂ) n = 0 := by
    intro n
    have h := hw (mulBasis lam n)
    rw [mulHamiltonian_mulBasis lam n] at h
    have hL : (inner ℂ (lp.single 2 n ((lam n : ℂ))) w : ℂ)
        = ((lam n : ℂ)) * ((w : L2Nat) : ℕ → ℂ) n := by
      rw [lp.inner_single_left]
      simp [mul_comm]
    have hR : (inner ℂ ((mulBasis lam n : L2Nat)) w : ℂ) = ((w : L2Nat) : ℕ → ℂ) n := by
      change (inner ℂ (lp.single 2 n (1 : ℂ)) w : ℂ) = _
      rw [lp.inner_single_left]
      simp
    rw [hL, hR] at h
    have hne : ((lam n : ℂ)) - z ≠ 0 := by
      intro hc
      have : z = ((lam n : ℝ) : ℂ) := by linear_combination -hc
      rw [this] at hz
      simp at hz
    have : (((lam n : ℂ)) - z) * ((w : L2Nat) : ℕ → ℂ) n = 0 := by linear_combination h
    exact (mul_eq_zero.mp this).resolve_left hne
  exact lp.ext (funext hcoe)

/-- The gravity mode Hamiltonian has trivial deficiency at every non-real `z`. -/
theorem qgModeHamiltonian_deficiencyTrivialAt (a b V : ℕ → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (mulSymbolDomain (qgModeSymbol a b V)) (qgModeHamiltonian a b V) z :=
  mulHamiltonian_deficiencyTrivialAt _ hz

/-- **The realization is genuinely unbounded** — the statement above is not a
bounded-operator triviality.  Witness: the purely spatial modes `a_k = k`,
`b = V = 0`, whose symbol `k²/16` is unbounded. -/
theorem qgModeHamiltonian_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : mulSymbolDomain (qgModeSymbol (fun k => (k : ℝ)) 0 0),
      ‖qgModeHamiltonian (fun k => (k : ℝ)) 0 0 f‖ ≤ C * ‖(f : L2Nat)‖ := by
  refine mulHamiltonian_not_bounded _ fun C => ?_
  obtain ⟨k, hk⟩ := exists_nat_gt (|C| * 16 + 16)
  refine ⟨k, ?_⟩
  have hk0 : (0 : ℝ) ≤ (k : ℝ) := Nat.cast_nonneg k
  have hC : C ≤ |C| := le_abs_self C
  have habs : |qgModeSymbol (fun k => (k : ℝ)) 0 0 k| = 1 / 16 * (k : ℝ) ^ 2 := by
    have : qgModeSymbol (fun k => (k : ℝ)) 0 0 k = 1 / 16 * (k : ℝ) ^ 2 := by
      simp [qgModeSymbol]
    rw [this, abs_of_nonneg (by positivity)]
  rw [habs]
  nlinarith [abs_nonneg C]

/-! ## Part D — Strichartz as a named hypothesis, and the transfer step -/

section Strichartz

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The Strichartz step, as a named hypothesis.**  For a symmetric operator on
a domain `D`, the *finite-speed / unique-continuation* input — the deficiency
space of the adjoint is trivial at every non-real `z`, which is what R. S.
Chernoff, *Essential self-adjointness of powers of generators of hyperbolic
equations*, J. Funct. Anal. **12** (1973) 401–414 provides for a flat
d'Alembertian with a smooth polynomial potential — gives essential
self-adjointness.

The flat d'Alembertian conclusion is now **proved** in
`BookProof.ChapterStrichartzWave` (`wave_essentiallySelfAdjoint`: `□ + κ` on the
Schwartz core of `L²(ℝ^{1+n})`), as is the **bounded-below polynomial potential**
`W x = ‖x‖^(2k)` as a pure potential (`polynomialPotential_essentiallySelfAdjoint`),
and `□ + W` for bounded/truncated `W`.  The present statement keeps the
deficiency-triviality premise explicit to make the deduction transparent; the
full `□ + W` for the *untruncated* bounded-below `W` is **sign-sensitive** (a
bounded-below `W` drives the fibre `−Δ_x − W` into the limit-circle regime where
ESA **fails**, e.g. `−d²/dx² − x⁴` has deficiency `(2,2)`) and is the remaining
research boundary.  The analytic input is a
**hypothesis**, never an `axiom`: nothing here asserts it for the continuum
gravity operator.  It is satisfiable, see
`strichartz_finiteSpeed_satisfiable`. -/
theorem strichartz_esa_of_finiteSpeed {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (finiteSpeed : ∀ z : ℂ, z.im ≠ 0 → DeficiencyTrivialAt D H z) :
    EssentiallySelfAdjointOn D H :=
  ⟨finiteSpeed Complex.I (by simp), finiteSpeed (-Complex.I) (by simp)⟩

end Strichartz

/-- **The Strichartz hypothesis is not vacuous**: the discretized gravity
Hamiltonian of Part C satisfies it, and therefore is essentially self-adjoint by
the route of `strichartz_esa_of_finiteSpeed`. -/
theorem strichartz_finiteSpeed_satisfiable (a b V : ℕ → ℝ) :
    EssentiallySelfAdjointOn (mulSymbolDomain (qgModeSymbol a b V)) (qgModeHamiltonian a b V) :=
  strichartz_esa_of_finiteSpeed _ fun _ hz => qgModeHamiltonian_deficiencyTrivialAt a b V hz

section FarisLavineRoute

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **The alternative route for the gravity operator: Faris–Lavine.**  With a
positive comparison operator `N` (the book's auxiliary operator `H₀² + 1`) for
which `N + 1` is onto and whose commutator form with `H` is dominated by `N`,
the *proved* Faris–Lavine criterion of `BookProof.ChapterFarisLavine` gives
essential self-adjointness.  Only the two inequalities are left to verify for
the continuum operator — that is the recorded research boundary. -/
theorem qg_esa_of_farisLavine {D : Submodule ℂ F} (H N : D →ₗ[ℂ] F) (c : ℝ)
    (hH : SymmetricOn D H) (hN : SymmetricOn D N) (hc : 0 ≤ c)
    (hNpos : ∀ x : D, 0 ≤ quadForm N x)
    (hNsurj : ∀ f : F, ∃ x : D, N x + (x : F) = f)
    (hcomm : ∀ x : D, |commForm H N x| ≤ c * quadForm N x) :
    EssentiallySelfAdjointOn D H :=
  essentiallySelfAdjointOn_of_farisLavine H N c hH hN hc hNpos hNsurj hcomm

end FarisLavineRoute

section Transfer

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LagrangianEsa

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

/-- **The transfer step of `CONSOLIDATED_PLAN.md` §10.3.**  The raw point map
`e ↦ (y, ẽ)` is *not* a Hilbert-space unitary; with the Jacobian half-density
factor `|J|^{−1/2}` it becomes one (`W` below).  Given such a unitary carrying
the physical domain onto the densitized domain and intertwining the two
Hamiltonians, essential self-adjointness of the **flat** (densitized) operator
transfers to the physical one.

Only the transfer is proved here; the hypothesis that the densitized operator is
essentially self-adjoint is exactly the Strichartz input of Part D. -/
theorem densitized_hasZeroDeficiencyOn_transfer (W : F ≃ₗᵢ[ℂ] G) {D : Submodule ℂ F}
    {D' : Submodule ℂ G} {H : D →ₗ[ℂ] D} {H' : D' →ₗ[ℂ] D'}
    (hmap : ∀ x : D, W (x : F) ∈ D') (hsurj : ∀ y : D', ∃ x : D, W (x : F) = (y : G))
    (hint : ∀ x : D, (H' ⟨W (x : F), hmap x⟩ : G) = W ((H x : F)))
    (hflat : HasZeroDeficiencyOn D' H') : HasZeroDeficiencyOn D H :=
  hasZeroDeficiencyOn_of_linearIsometryEquiv W hmap hsurj hint hflat

end Transfer

end BookProof.QuantumGravityDensitized
