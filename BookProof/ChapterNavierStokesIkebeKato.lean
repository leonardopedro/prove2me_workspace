import Mathlib
import BookProof.ChapterFarisLavine

/-!
# The Ikebe–Kato input in the momentum representation

This module supplies the *analytic* input that the Faris–Lavine route to
essential self-adjointness of the Navier–Stokes Hamiltonian needs, and which was
previously carried as a hypothesis: a comparison operator `N` which

* is self-adjoint on a natural maximal domain,
* is positive (indeed `N ≥ I` for the Navier–Stokes symbol),
* has `N + 1` surjective, and
* admits the finite-mode states (the momentum-representation stand-in for
  `C_c^∞`) as an operator core in the graph norm.

In the momentum representation the one-particle comparison operator
`n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I` is multiplication by the classical symbol
`σ(k) = ∑ᵢ pᵢ(k)² + ∑ᵢ qᵢ(k)² + 1`
(`BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_eq`).  This is the
momentum-space form of the Ikebe–Kato theorem for `−Δ + V` with `V ≥ 0`: the
operator is essentially self-adjoint on the compactly supported core, and
self-adjoint on its maximal domain.

## Contents

* `maxDom c` and `diagMax c` — multiplication by the real symbol `c` on its
  *maximal* domain in `ℓ²(ι)`, i.e. all states whose image is again square
  summable.
* `diagMax_symmetricOn`, `diagMax_hasSum_quadForm`, `diagMax_quadForm_nonneg`,
  `diagMax_quadForm_ge_norm_sq` — symmetry and positivity of the quadratic form.
* `diagMax_add_one_surjective` — `N + 1` maps the maximal domain **onto** `ℓ²(ι)`
  for a non-negative symbol; this is the one consequence of self-adjointness of
  `N` that the Faris–Lavine argument uses.
* `exists_finiteModes_graph_approx` — the finite-mode states are a **core**: every
  state of the maximal domain is approximated in the graph norm of `N` by finite
  truncations.
* `diagMax_essentiallySelfAdjointOn` — `N` is essentially self-adjoint on its
  maximal domain, and `ikebeKato_momentum` — **essentially self-adjoint already on
  the finite-mode core**.  This is the Ikebe–Kato-type statement, proved here, not
  assumed.
* `essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds` — the payoff: *any*
  symmetric operator `H` on the maximal domain of a non-negative symbol which is
  relatively bounded by `N` and whose form commutator with `N` is dominated by `N`
  is essentially self-adjoint on the finite-mode core.  The Faris–Lavine criterion
  is **not** a hypothesis here: it is the theorem
  `BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`, proved in
  this project.
* `nsComparison_*` — the specialisation to the Navier–Stokes comparison symbol
  `∑ᵢ pᵢ² + ∑ᵢ qᵢ² + 1`, together with `nsComparison_restrict_eq` identifying the
  restriction of `diagMax` to the finite-mode core with the operator
  `ComparisonData.comparison` of `BookProof.ChapterNavierStokesFarisLavineLift`.
* `ns_hamiltonian_essentiallySelfAdjointOn_core` — the assembled one-particle
  statement: the Navier–Stokes Hamiltonian of the fiber momentum representation
  is essentially self-adjoint on the finite-mode core as soon as it satisfies the
  two Faris–Lavine inequalities relative to `n`.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace IkebeKato

open LpNat FarisLavine

variable {ι : Type*}

/-- The Hilbert space `ℓ²(ι)` of the momentum representation. -/
abbrev L2I (ι : Type*) := lp (fun _ : ι => ℂ) 2

/-! ## Square summability helpers -/

theorem summable_normSq (f : L2I ι) : Summable fun k => ‖(f : ι → ℂ) k‖ ^ 2 := by
  have h := lp.hasSum_norm (p := 2) (E := fun _ : ι => ℂ) (by norm_num) f
  have h2 : ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) := by norm_num
  rw [h2] at h
  simpa [Real.rpow_natCast] using h.summable

/-- Domination: a function pointwise dominated by an `ℓ²` state is itself `ℓ²`. -/
theorem memLpTwo_of_le (f : L2I ι) {g : ι → ℂ} (h : ∀ k, ‖g k‖ ≤ ‖(f : ι → ℂ) k‖) :
    Memℓp g 2 :=
  memLpTwo_of_summable_normSq
    (Summable.of_nonneg_of_le (fun k => sq_nonneg _)
      (fun k => by nlinarith [norm_nonneg (g k), norm_nonneg ((f : ι → ℂ) k), h k])
      (summable_normSq f))

/-- A finitely supported function lies in `ℓ²`. -/
theorem memLpTwo_of_finite_support {g : ι → ℂ} (h : (Function.support g).Finite) :
    Memℓp g 2 := by
  classical
  refine memLpTwo_of_summable_normSq (summable_of_ne_finset_zero (s := h.toFinset) ?_)
  intro k hk
  have : g k = 0 := by
    by_contra hne
    exact hk (h.mem_toFinset.mpr hne)
  simp [this]

/-! ## The maximal domain of a multiplication operator -/

/-- **The maximal domain** of multiplication by the real symbol `c` in `ℓ²(ι)`:
the states whose product with the symbol is again square summable.  In the
momentum representation of a Schrödinger operator this is the natural (Sobolev)
domain of `−Δ + V`. -/
def maxDom (c : ι → ℝ) : Submodule ℂ (L2I ι) where
  carrier := {f : L2I ι | Memℓp (fun k => (c k : ℂ) * (f : ι → ℂ) k) 2}
  add_mem' := by
    intro f g hf hg
    have hfun : (fun k => (c k : ℂ) * ((f + g : L2I ι) : ι → ℂ) k)
        = (fun k => (c k : ℂ) * (f : ι → ℂ) k) + fun k => (c k : ℂ) * (g : ι → ℂ) k := by
      funext k
      simp only [lp.coeFn_add, Pi.add_apply]
      ring
    simp only [Set.mem_setOf_eq, hfun]
    exact hf.add hg
  zero_mem' := by
    have hfun : (fun k => (c k : ℂ) * ((0 : L2I ι) : ι → ℂ) k) = fun _ => (0 : ℂ) := by
      funext k
      simp
    simp only [Set.mem_setOf_eq, hfun]
    exact zero_memℓp
  smul_mem' := by
    intro a f hf
    have hfun : (fun k => (c k : ℂ) * ((a • f : L2I ι) : ι → ℂ) k)
        = a • fun k => (c k : ℂ) * (f : ι → ℂ) k := by
      funext k
      simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul]
      ring
    simp only [Set.mem_setOf_eq, hfun]
    exact hf.const_smul a

theorem mem_maxDom {c : ι → ℝ} {f : L2I ι} :
    f ∈ maxDom c ↔ Memℓp (fun k => (c k : ℂ) * (f : ι → ℂ) k) 2 := Iff.rfl

/-- **The comparison operator on its maximal domain**: multiplication by `c`. -/
noncomputable def diagMax (c : ι → ℝ) : maxDom c →ₗ[ℂ] L2I ι where
  toFun f := ⟨fun k => (c k : ℂ) * ((f : L2I ι) : ι → ℂ) k, f.2⟩
  map_add' f g := by
    refine lp.ext (funext fun k => ?_)
    simp only [lp.coeFn_add, Pi.add_apply, Submodule.coe_add]
    ring
  map_smul' a f := by
    refine lp.ext (funext fun k => ?_)
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply, Submodule.coe_smul]
    ring

@[simp] theorem diagMax_coe (c : ι → ℝ) (f : maxDom c) (k : ι) :
    ((diagMax c f : L2I ι) : ι → ℂ) k = (c k : ℂ) * ((f : L2I ι) : ι → ℂ) k := rfl

/-! ## Symmetry and positivity -/

/-- Multiplication by a *real* symbol is symmetric on its maximal domain. -/
theorem diagMax_symmetricOn (c : ι → ℝ) : SymmetricOn (maxDom c) (diagMax c) := by
  intro x y
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun k => ?_
  simp only [RCLike.inner_apply, diagMax_coe, map_mul, Complex.conj_ofReal]
  ring

/-- The quadratic form of the comparison operator is `∑ₖ c(k) |xₖ|²`. -/
theorem diagMax_hasSum_quadForm (c : ι → ℝ) (x : maxDom c) :
    HasSum (fun k => c k * ‖((x : L2I ι) : ι → ℂ) k‖ ^ 2) (quadForm (diagMax c) x) := by
  have h := Complex.hasSum_re (lp.hasSum_inner (𝕜 := ℂ) ((x : L2I ι)) (diagMax c x))
  refine h.congr_fun fun k => ?_
  have hcc : (starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) k) * ((x : L2I ι) : ι → ℂ) k
      = ((‖((x : L2I ι) : ι → ℂ) k‖ ^ 2 : ℝ) : ℂ) := by
    rw [Complex.conj_mul']
    norm_cast
  have hz : (inner ℂ (((x : L2I ι) : ι → ℂ) k) (((diagMax c x : L2I ι) : ι → ℂ) k) : ℂ)
      = ((c k * ‖((x : L2I ι) : ι → ℂ) k‖ ^ 2 : ℝ) : ℂ) := by
    have hstep : (inner ℂ (((x : L2I ι) : ι → ℂ) k) (((diagMax c x : L2I ι) : ι → ℂ) k) : ℂ)
        = (c k : ℂ) * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) k) * ((x : L2I ι) : ι → ℂ) k) := by
      simp only [RCLike.inner_apply, diagMax_coe]
      ring
    rw [hstep, hcc, ← Complex.ofReal_mul]
  rw [hz, Complex.ofReal_re]

/-- A non-negative symbol gives a non-negative comparison operator. -/
theorem diagMax_quadForm_nonneg (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) (x : maxDom c) :
    0 ≤ quadForm (diagMax c) x := by
  refine (diagMax_hasSum_quadForm c x).nonneg fun k => ?_
  exact mul_nonneg (hc k) (sq_nonneg _)

/-- A symbol `≥ 1` gives `N ≥ I`, the positivity Faris–Lavine asks of the
comparison operator. -/
theorem diagMax_quadForm_ge_norm_sq (c : ι → ℝ) (hc : ∀ k, 1 ≤ c k) (x : maxDom c) :
    ‖(x : L2I ι)‖ ^ 2 ≤ quadForm (diagMax c) x := by
  have hnorm := lp.hasSum_norm (p := 2) (E := fun _ : ι => ℂ) (by norm_num) ((x : L2I ι))
  have h2 : ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) := by norm_num
  rw [h2] at hnorm
  simp only [Real.rpow_natCast] at hnorm
  refine hasSum_le (fun k => ?_) hnorm (diagMax_hasSum_quadForm c x)
  nlinarith [sq_nonneg ‖((x : L2I ι) : ι → ℂ) k‖, hc k]

/-! ## Surjectivity of `N + 1` -/

/-- **`N + 1` maps the maximal domain onto the whole space.**  This is the single
consequence of the self-adjointness of the comparison operator that the
Faris–Lavine argument uses; for a non-negative symbol it is elementary, because
`(c + 1)⁻¹` is a contraction. -/
theorem diagMax_add_one_surjective (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) (f : L2I ι) :
    ∃ x : maxDom c, (diagMax c x : L2I ι) + (x : L2I ι) = f := by
  have hpos : ∀ k, (1 : ℝ) ≤ c k + 1 := fun k => by linarith [hc k]
  have hne : ∀ k, ((c k : ℂ) + 1) ≠ 0 := by
    intro k h
    have : (c k : ℝ) + 1 = 0 := by
      have := congrArg Complex.re h
      simpa using this
    linarith [hc k]
  set g : ι → ℂ := fun k => ((f : ι → ℂ) k) / ((c k : ℂ) + 1) with hg
  have hgle : ∀ k, ‖g k‖ ≤ ‖(f : ι → ℂ) k‖ := by
    intro k
    have hnorm : ‖((c k : ℂ) + 1)‖ = c k + 1 := by
      have hre : ((c k : ℂ) + 1) = ((c k + 1 : ℝ) : ℂ) := by push_cast; ring
      rw [hre, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by linarith [hc k])]
    rw [hg]
    simp only [norm_div, hnorm]
    rw [div_le_iff₀ (by linarith [hpos k])]
    nlinarith [norm_nonneg ((f : ι → ℂ) k), hc k]
  have hgmem : Memℓp g 2 := memLpTwo_of_le f hgle
  have hcgle : ∀ k, ‖(c k : ℂ) * g k‖ ≤ ‖(f : ι → ℂ) k‖ := by
    intro k
    have hnm : ‖(c k : ℂ) * g k‖ = c k * ‖g k‖ := by
      rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (hc k)]
    rw [hnm]
    have hle := hgle k
    have hnn : 0 ≤ ‖g k‖ := norm_nonneg _
    have hcg : ‖g k‖ * (c k + 1) ≤ ‖(f : ι → ℂ) k‖ * 1 := by
      have hgk : ‖g k‖ * (c k + 1) ≤ ‖(f : ι → ℂ) k‖ := by
        have hnorm : ‖((c k : ℂ) + 1)‖ = c k + 1 := by
          have hre : ((c k : ℂ) + 1) = ((c k + 1 : ℝ) : ℂ) := by push_cast; ring
          rw [hre, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by linarith [hc k])]
        rw [hg]
        simp only [norm_div, hnorm]
        rw [div_mul_cancel₀]
        linarith [hpos k]
      linarith
    nlinarith [hle, hnn, hc k]
  refine ⟨⟨⟨g, hgmem⟩, memLpTwo_of_le f hcgle⟩, ?_⟩
  refine lp.ext (funext fun k => ?_)
  simp only [lp.coeFn_add, Pi.add_apply, diagMax_coe]
  change (c k : ℂ) * g k + g k = (f : ι → ℂ) k
  have : (c k : ℂ) * g k + g k = ((c k : ℂ) + 1) * g k := by ring
  rw [this, hg]
  simp only
  rw [mul_comm, div_mul_cancel₀ _ (hne k)]

/-! ## The finite-mode core -/

/-- Finitely supported states lie in every maximal domain. -/
theorem finiteModes_le_maxDom (c : ι → ℝ) : lpFiniteModes ι ≤ maxDom c := by
  intro f hf
  refine memLpTwo_of_finite_support (Set.Finite.subset (mem_lpFiniteModes.mp hf) ?_)
  intro k hk
  simp only [Function.mem_support] at hk ⊢
  intro h0
  exact hk (by rw [h0, mul_zero])

/-- Coordinates of a finite sum of basis states. -/
theorem coe_sum_single [DecidableEq ι] (S : Finset ι) (u : ι → ℂ) (k : ι) :
    ((∑ i ∈ S, lp.single 2 i (u i) : L2I ι) : ι → ℂ) k = if k ∈ S then u k else 0 := by
  classical
  induction S using Finset.induction with
  | empty => simp
  | insert a S ha ih =>
      rw [Finset.sum_insert ha]
      simp only [lp.coeFn_add, Pi.add_apply, lp.single_apply, Pi.single_apply, ih]
      by_cases hka : k = a
      · subst hka
        simp [ha]
      · simp [hka, Finset.mem_insert]

/-- Truncations lie in the finite-mode domain. -/
theorem sum_single_mem_finiteModes [DecidableEq ι] (S : Finset ι) (u : ι → ℂ) :
    (∑ i ∈ S, lp.single 2 i (u i) : L2I ι) ∈ lpFiniteModes ι :=
  Submodule.sum_mem _ fun i _ => lpSingle_mem_lpFiniteModes i (u i)

/-- **The finite-mode states are a core for the comparison operator.**  Every
state of the maximal domain is approximated, simultaneously in the norm and in
the graph norm of `N`, by its finite truncations: the momentum-representation
form of "`C_c^∞` is a core". -/
theorem exists_finiteModes_graph_approx (c : ι → ℝ) (x : maxDom c) (ε : ℝ) (hε : 0 < ε) :
    ∃ y : maxDom c, (y : L2I ι) ∈ lpFiniteModes ι ∧
      ‖(y : L2I ι) - (x : L2I ι)‖ < ε ∧ ‖diagMax c y - diagMax c x‖ < ε := by
  classical
  set u : ι → ℂ := fun k => ((x : L2I ι) : ι → ℂ) k with hu
  set v : ι → ℂ := fun k => ((diagMax c x : L2I ι) : ι → ℂ) k with hv
  have hxsum : HasSum (fun i => lp.single 2 i (u i)) ((x : L2I ι)) :=
    lp.hasSum_single (by norm_num) _
  have hvsum : HasSum (fun i => lp.single 2 i (v i)) ((diagMax c x : L2I ι)) :=
    lp.hasSum_single (by norm_num) _
  have hx1 : ∀ᶠ S : Finset ι in Filter.atTop,
      ‖(∑ i ∈ S, lp.single 2 i (u i) : L2I ι) - (x : L2I ι)‖ < ε := by
    have hmet := Metric.tendsto_atTop.mp hxsum
    obtain ⟨S₀, hS₀⟩ := hmet ε hε
    filter_upwards [Filter.eventually_ge_atTop S₀] with S hS
    have := hS₀ S hS
    rwa [dist_eq_norm] at this
  have hx2 : ∀ᶠ S : Finset ι in Filter.atTop,
      ‖(∑ i ∈ S, lp.single 2 i (v i) : L2I ι) - (diagMax c x : L2I ι)‖ < ε := by
    have hmet := Metric.tendsto_atTop.mp hvsum
    obtain ⟨S₀, hS₀⟩ := hmet ε hε
    filter_upwards [Filter.eventually_ge_atTop S₀] with S hS
    have := hS₀ S hS
    rwa [dist_eq_norm] at this
  obtain ⟨S, hS1, hS2⟩ := (hx1.and hx2).exists
  refine ⟨⟨(∑ i ∈ S, lp.single 2 i (u i) : L2I ι),
    finiteModes_le_maxDom c (sum_single_mem_finiteModes S u)⟩,
    sum_single_mem_finiteModes S u, hS1, ?_⟩
  have hdiag : (diagMax c ⟨(∑ i ∈ S, lp.single 2 i (u i) : L2I ι),
      finiteModes_le_maxDom c (sum_single_mem_finiteModes S u)⟩ : L2I ι)
      = (∑ i ∈ S, lp.single 2 i (v i) : L2I ι) := by
    refine lp.ext (funext fun k => ?_)
    rw [diagMax_coe, coe_sum_single, coe_sum_single]
    by_cases hk : k ∈ S
    · simp [hk, hv, hu]
    · simp [hk]
  rw [hdiag]
  exact hS2

/-! ## Essential self-adjointness: the Ikebe–Kato input, proved -/

/-- The commutator form of the comparison operator with itself vanishes. -/
theorem commForm_self (c : ι → ℝ) (x : maxDom c) : commForm (diagMax c) (diagMax c) x = 0 := by
  rw [commForm_eq]
  have him : (inner ℂ (diagMax c x) (diagMax c x) : ℂ).im = 0 := by
    simpa using inner_self_im (𝕜 := ℂ) ((diagMax c x))
  rw [him]
  ring

/-- **The comparison operator is essentially self-adjoint on its maximal
domain.**  (For a non-negative symbol; the argument is Faris–Lavine with `N = H`
and vanishing commutator.) -/
theorem diagMax_essentiallySelfAdjointOn (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) :
    EssentiallySelfAdjointOn (maxDom c) (diagMax c) :=
  essentiallySelfAdjointOn_of_farisLavine (diagMax c) (diagMax c) 0
    (diagMax_symmetricOn c) (diagMax_symmetricOn c) le_rfl (diagMax_quadForm_nonneg c hc)
    (diagMax_add_one_surjective c hc)
    (fun x => by rw [commForm_self]; simp)

/-- **The Ikebe–Kato statement in the momentum representation.**  For a
non-negative symbol — in the Navier–Stokes fiber, `σ = ∑ᵢ pᵢ² + ∑ᵢ Vᵢ² + 1`, the
momentum-space symbol of `−Δ + V² + 1` — multiplication by `σ` is essentially
self-adjoint already on the finite-mode core, the momentum-representation
stand-in for `C_c^∞`. -/
theorem ikebeKato_momentum (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((diagMax c).comp (Submodule.inclusion (finiteModes_le_maxDom c))) := by
  refine essentiallySelfAdjointOn_core_of_farisLavine (finiteModes_le_maxDom c)
    (diagMax c) (diagMax c) 1 0 0 (diagMax_symmetricOn c) (diagMax_symmetricOn c) le_rfl
    (diagMax_quadForm_nonneg c hc) (diagMax_add_one_surjective c hc)
    (fun x => by rw [commForm_self]; simp)
    (fun x => by simp) ?_
  intro x ε hε
  obtain ⟨y, hy1, hy2, hy3⟩ := exists_finiteModes_graph_approx c x ε hε
  exact ⟨y, hy1, hy2, hy3⟩

/-! ## The payoff: essential self-adjointness of the Hamiltonian -/

/-- **Essential self-adjointness from the two Faris–Lavine inequalities, with no
further hypothesis.**  Let `N` be multiplication by a non-negative symbol on its
maximal domain in `ℓ²(ι)` — the comparison operator of the momentum
representation — and let `H` be *any* symmetric operator on that domain with

* the relative bound `‖H x‖² ≤ a‖N x‖² + b‖x‖²`, and
* the commutator form bound `± i[H, N] ≤ c N`.

Then `H` is essentially self-adjoint on the finite-mode core.  Neither the
Faris–Lavine criterion nor the Ikebe–Kato theorem is assumed: the first is
`BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`, the second
is the package `diagMax_quadForm_nonneg` + `diagMax_add_one_surjective` +
`exists_finiteModes_graph_approx` proved above. -/
theorem essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds
    (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) (H : maxDom c →ₗ[ℂ] L2I ι) (a b cst : ℝ)
    (hH : SymmetricOn (maxDom c) H) (hcst : 0 ≤ cst)
    (hrel : ∀ x : maxDom c, ‖H x‖ ^ 2 ≤ a * ‖diagMax c x‖ ^ 2 + b * ‖(x : L2I ι)‖ ^ 2)
    (hcomm : ∀ x : maxDom c, |commForm H (diagMax c) x| ≤ cst * quadForm (diagMax c) x) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom c))) := by
  refine essentiallySelfAdjointOn_core_of_farisLavine (finiteModes_le_maxDom c)
    H (diagMax c) a b cst hH (diagMax_symmetricOn c) hcst (diagMax_quadForm_nonneg c hc)
    (diagMax_add_one_surjective c hc) hcomm hrel ?_
  intro x ε hε
  obtain ⟨y, hy1, hy2, hy3⟩ := exists_finiteModes_graph_approx c x ε hε
  exact ⟨y, hy1, hy2, hy3⟩

end IkebeKato

end BookProof.NavierStokesFlow
