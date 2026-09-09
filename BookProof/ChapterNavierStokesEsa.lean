import Mathlib
import BookProof.ChapterNavierStokesFlow
import BookProof.ChapterNavierStokesCauchy
import BookProof.ChapterContinuityUnitaryInfinite

/-!
# Essential self-adjointness from a complete flow, on a genuinely dense domain

Companion to `BookProof.ChapterNavierStokesFlow` and
`BookProof.ChapterNavierStokesCauchy`.

Those modules prove that the truncated Navier–Stokes Hamiltonian is Hermitian,
that its flow `U(t) = e^{i t H_N}` is a one-parameter unitary group defined for
every real time, and that the associated Cauchy problem has exactly one global
solution.  Essential self-adjointness (`HasZeroDeficiencyOn`) was, however, only
established there for the **full** domain `D = ⊤`, where symmetry alone suffices.

The analytic content of the notion lives on a *proper* dense domain, and this
module supplies it:

* `eq_zero_of_hasDerivAt_smul_of_bounded` — a bounded solution of `g' = ± g` on
  the real line vanishes at the origin (the elementary ODE step);
* `hasZeroDeficiencyOn_of_completeUnitaryFlow` — **the headline.** If a symmetric
  operator `H` on a dense domain `D` generates a norm-preserving flow `U` which
  is defined for *every* real time and leaves `D` invariant, then the deficiency
  spaces of `H∗` vanish, i.e. `H` is essentially self-adjoint.  This is the
  precise form of the statement that the plan's scoping section appeals to when
  it says that *the deficiency argument requires the flow to be complete*
  (Nelson's criterion): completeness of the flow is exactly the hypothesis, and
  a finite-time blow-up destroys it;
* `nsHamiltonian_hasZeroDeficiencyOn_of_flow` — the truncated Navier–Stokes
  generator, re-derived along that route from the completeness of its own flow
  rather than from finite-dimensional symmetry;
* `hasZeroDeficiencyOn_of_bounded_symmetric` — a bounded symmetric operator is
  essentially self-adjoint on **every** dense invariant domain, and
  `continuityHamiltonian_hasZeroDeficiencyOn_finiteModes`, its application to the
  infinite-dimensional `ℓ²(ℤ)` layer of
  `BookProof.ChapterContinuityUnitaryInfinite` on the proper dense domain of
  finitely supported modes.  This is the first instance in the development of
  vanishing adjoint deficiency on a domain that is *not* the whole space, so the
  predicate `HasZeroDeficiencyOn` is not vacuous there.

## Scope

Unchanged: nothing here is a statement about the continuum Navier–Stokes
operator.  The flow criterion is proved in full generality, but its hypotheses
(a *complete* norm-preserving flow leaving the domain invariant) are exactly
what is not known for the untruncated Navier–Stokes generator — that is the
research target recorded in `BookProof.ChapterNavierStokesFlow`.
-/

open scoped Matrix

namespace BookProof.NavierStokesFlow

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- A vector orthogonal to a dense subspace vanishes. -/
theorem eq_zero_of_inner_right_eq_zero_on_dense {D : Submodule ℂ F} (hdense : Dense (D : Set F))
    (w : F) (hw : ∀ v : D, (inner ℂ w (v : F) : ℂ) = 0) : w = 0 := by
  have hcont : Continuous fun y : F => (inner ℂ w y : ℂ) := (innerSL ℂ w).continuous
  have hall : (fun y : F => (inner ℂ w y : ℂ)) = fun _ => 0 :=
    Continuous.ext_on hdense hcont continuous_const fun x hx => hw ⟨x, hx⟩
  exact inner_self_eq_zero.mp (congrFun hall w)

/-- A vector orthogonal (on the left) to a dense subspace vanishes. -/
theorem eq_zero_of_inner_left_eq_zero_on_dense {D : Submodule ℂ F} (hdense : Dense (D : Set F))
    (w : F) (hw : ∀ v : D, (inner ℂ (v : F) w : ℂ) = 0) : w = 0 :=
  eq_zero_of_inner_right_eq_zero_on_dense hdense w fun v => by
    rw [← inner_conj_symm, hw v, map_zero]

/-- *The elementary ODE step.*  A bounded function `g : ℝ → ℂ` with `g' = s · g`
for a sign `s = ± 1` vanishes at the origin: the solution is `g(0) e^{st}`, which
is bounded on the whole line only if `g(0) = 0`.  This is the analytic engine of
`hasZeroDeficiencyOn_of_completeUnitaryFlow`: the deficiency vector produces a
solution that grows exponentially in one time direction, while the *complete*
unitary flow keeps it bounded there. -/
theorem eq_zero_of_hasDerivAt_smul_of_bounded (g : ℝ → ℂ) (s C : ℝ) (hs : s * s = 1)
    (hgd : ∀ t : ℝ, HasDerivAt g ((s : ℂ) * g t) t) (hb : ∀ t : ℝ, ‖g t‖ ≤ C) : g 0 = 0 := by
  set h : ℝ → ℂ := fun t => Real.exp (-(s * t)) • g t with hh
  have hhd : ∀ t : ℝ, HasDerivAt h 0 t := by
    intro t
    have h1 : HasDerivAt (fun t : ℝ => Real.exp (-(s * t))) (-s * Real.exp (-(s * t))) t := by
      have hlin : HasDerivAt (fun t : ℝ => -(s * t)) (-s) t := by
        simpa using ((hasDerivAt_id t).const_mul s).neg
      simpa [mul_comm] using hlin.exp
    have h2 := h1.smul (hgd t)
    have heq : Real.exp (-(s * t)) • ((s : ℂ) * g t) + (-s * Real.exp (-(s * t))) • g t = 0 := by
      push_cast [Complex.real_smul]
      ring
    rw [heq] at h2
    exact h2
  have hconst : ∀ t : ℝ, h t = h 0 := fun t =>
    is_const_of_deriv_eq_zero (fun x => (hhd x).differentiableAt) (fun x => (hhd x).deriv) t 0
  have hb0 : ∀ T : ℝ, ‖g 0‖ ≤ Real.exp (-T) * C := by
    intro T
    have hst : s * (s * T) = T := by rw [← mul_assoc, hs, one_mul]
    have h3 := hconst (s * T)
    simp only [hh, hst, mul_zero, neg_zero, Real.exp_zero, one_smul] at h3
    rw [← h3, norm_smul]
    simp only [Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
    exact mul_le_mul_of_nonneg_left (hb _) (Real.exp_pos _).le
  have htend : Filter.Tendsto (fun T : ℝ => Real.exp (-T) * C) Filter.atTop (nhds 0) := by
    simpa using Real.tendsto_exp_neg_atTop_nhds_zero.mul_const C
  have hle : ‖g 0‖ ≤ 0 := ge_of_tendsto htend (Filter.Eventually.of_forall hb0)
  simpa using le_antisymm hle (norm_nonneg _)

/-- The one-sided form of the flow criterion: a vector in the deficiency space
`H∗ w = s i w` of an operator generating a complete norm-preserving flow is `0`.
-/
theorem eq_zero_of_deficiency_of_completeUnitaryFlow (D : Submodule ℂ F) (H : D →ₗ[ℂ] D)
    (U : ℝ → F → F) (hdense : Dense (D : Set F)) (hnorm : ∀ (t : ℝ) (v : F), ‖U t v‖ = ‖v‖)
    (hU0 : ∀ v : F, U 0 v = v) (hUD : ∀ (t : ℝ) (v : D), U t (v : F) ∈ D)
    (hderiv : ∀ (v : D) (t : ℝ),
      HasDerivAt (fun s => U s (v : F)) (Complex.I • (H ⟨U t (v : F), hUD t v⟩ : F)) t)
    (s : ℝ) (hs : s * s = 1) (w : F)
    (hw : ∀ v : D, (inner ℂ (H v : F) w : ℂ) = inner ℂ (v : F) (((s : ℂ) * Complex.I) • w)) :
    w = 0 := by
  refine eq_zero_of_inner_right_eq_zero_on_dense hdense w fun v => ?_
  set g : ℝ → ℂ := fun t => inner ℂ w (U t (v : F)) with hg
  have hgd : ∀ t : ℝ, HasDerivAt g ((s : ℂ) * g t) t := by
    intro t
    have h1 : HasDerivAt g (inner ℂ w (Complex.I • (H ⟨U t (v : F), hUD t v⟩ : F)) : ℂ) t :=
      ((innerSL ℂ w).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt t (hderiv v t)
    have h2 : (inner ℂ w (Complex.I • (H ⟨U t (v : F), hUD t v⟩ : F)) : ℂ) = (s : ℂ) * g t := by
      have hk := hw ⟨U t (v : F), hUD t v⟩
      have hc : (inner ℂ w (H ⟨U t (v : F), hUD t v⟩ : F) : ℂ)
          = starRingEnd ℂ (inner ℂ (H ⟨U t (v : F), hUD t v⟩ : F) w) := (inner_conj_symm _ _).symm
      rw [hk, inner_smul_right] at hc
      rw [inner_smul_right, hc]
      simp only [map_mul, Complex.conj_I, Complex.conj_ofReal, inner_conj_symm, hg]
      ring_nf
      rw [Complex.I_sq]
      ring
    rw [h2] at h1
    exact h1
  have hb : ∀ t : ℝ, ‖g t‖ ≤ ‖w‖ * ‖(v : F)‖ := fun t =>
    calc ‖g t‖ ≤ ‖w‖ * ‖U t (v : F)‖ := norm_inner_le_norm _ _
      _ = ‖w‖ * ‖(v : F)‖ := by rw [hnorm]
  simpa [hg, hU0] using eq_zero_of_hasDerivAt_smul_of_bounded g s (‖w‖ * ‖(v : F)‖) hs hgd hb

/-- **Complete flow ⟹ essential self-adjointness** (Nelson's criterion, in the
form the Navier–Stokes discussion needs).

Let `H` be an operator on a dense domain `D` of a complex inner-product space,
and suppose it generates a flow `U` such that

* `U t` preserves the norm (the flow is *unitary*),
* `U 0 = id`,
* `U t` maps `D` into `D` (the domain is invariant), and
* `t ↦ U t v` is differentiable with `d/dt U t v = i H (U t v)` for every `t ∈ ℝ`
  and every `v ∈ D` — in particular the flow exists for **all** real times: it is
  *complete*.

Then the deficiency spaces of `H∗` vanish: `H` is essentially self-adjoint.

The proof is the classical one.  If `H∗ w = ± i w`, the orbit function
`g(t) = ⟪w, U t v⟫` satisfies `g' = ± g`, hence `g(t) = g(0) e^{± t}`, which the
unitarity of the flow keeps bounded on the whole line; so `g(0) = ⟪w, v⟫ = 0`
for every `v` in the dense domain and `w = 0`.

*Where completeness enters.* The exponential estimate has to hold for
arbitrarily large `|t|`; if the flow existed only up to a finite blow-up time
the argument would break down, which is exactly the warning recorded in
`PLAN_LEAN_SPECIALIST_NS_FLOW.md` §2 (the `ẋ = x²` example of the ODE chapter).
Nothing here is applied to the untruncated Navier–Stokes generator: for that
operator the completeness of the flow is the open problem. -/
theorem hasZeroDeficiencyOn_of_completeUnitaryFlow (D : Submodule ℂ F) (H : D →ₗ[ℂ] D)
    (U : ℝ → F → F) (hdense : Dense (D : Set F)) (hnorm : ∀ (t : ℝ) (v : F), ‖U t v‖ = ‖v‖)
    (hU0 : ∀ v : F, U 0 v = v) (hUD : ∀ (t : ℝ) (v : D), U t (v : F) ∈ D)
    (hderiv : ∀ (v : D) (t : ℝ),
      HasDerivAt (fun s => U s (v : F)) (Complex.I • (H ⟨U t (v : F), hUD t v⟩ : F)) t) :
    HasZeroDeficiencyOn D H := by
  constructor
  · intro w hw
    refine eq_zero_of_deficiency_of_completeUnitaryFlow D H U hdense hnorm hU0 hUD hderiv 1
      (by norm_num) w fun v => ?_
    simpa using hw v
  · intro w hw
    refine eq_zero_of_deficiency_of_completeUnitaryFlow D H U hdense hnorm hU0 hUD hderiv (-1)
      (by norm_num) w fun v => ?_
    simpa using hw v

/-- **A symmetric operator with a total family of eigenvectors in its domain is
essentially self-adjoint.**  If every `e i` lies in the domain and is an
eigenvector with a *real* eigenvalue, and the family is total (only `0` is
orthogonal to all of them), then the adjoint has no deficiency: testing the
deficiency identity against `e i` gives `(λ i ∓ i)⟪e i, w⟫ = 0`, and `λ i` is
real.  Unlike `hasZeroDeficiencyOn_of_bounded_symmetric` this applies to
*unbounded* operators — a diagonal operator with unbounded real entries is
essentially self-adjoint on the finite-mode domain. -/
theorem hasZeroDeficiencyOn_of_total_eigenvectors {I : Type*} (D : Submodule ℂ F) (H : D →ₗ[ℂ] D)
    (e : I → D) (lam : I → ℝ) (heig : ∀ i, H (e i) = ((lam i : ℂ)) • e i)
    (htotal : ∀ w : F, (∀ i, (inner ℂ ((e i : F)) w : ℂ) = 0) → w = 0) :
    HasZeroDeficiencyOn D H := by
  have key : ∀ (c : ℂ), (∀ i, ((lam i : ℂ)) ≠ c) → ∀ w : F,
      (∀ v : D, (inner ℂ (H v : F) w : ℂ) = inner ℂ (v : F) (c • w)) → w = 0 := by
    intro c hc w hw
    refine htotal w fun i => ?_
    have h := hw (e i)
    rw [heig i] at h
    simp only [Submodule.coe_smul, inner_smul_left, inner_smul_right, Complex.conj_ofReal] at h
    have hzero : (((lam i : ℂ)) - c) * (inner ℂ ((e i : F)) w : ℂ) = 0 := by
      linear_combination h
    exact (mul_eq_zero.mp hzero).resolve_left (sub_ne_zero.mpr (hc i))
  refine ⟨key Complex.I ?_, fun w hw => key (-Complex.I) ?_ w (by simpa using hw)⟩
  · intro i hi
    have himag := congrArg Complex.im hi
    simp at himag
  · intro i hi
    have himag := congrArg Complex.im hi
    simp at himag

/-- **A bounded symmetric operator is essentially self-adjoint on every dense
invariant domain.**  Here `A` is defined and symmetric on the whole space, `D` is
any dense subspace with `A D ⊆ D`, and `H` is the restriction of `A` to `D`.
Unlike `hasZeroDeficiencyOn_top_of_symmetric` this covers *proper* dense
domains, where symmetry of the restriction alone is not enough: the argument
uses the continuity of `A` through the density of `D`. -/
theorem hasZeroDeficiencyOn_of_bounded_symmetric (A : F →L[ℂ] F)
    (hsym : (A : F →ₗ[ℂ] F).IsSymmetric) (D : Submodule ℂ F) (hdense : Dense (D : Set F))
    (hinv : ∀ v : D, A (v : F) ∈ D) :
    HasZeroDeficiencyOn D
      (LinearMap.codRestrict D ((A : F →ₗ[ℂ] F).comp D.subtype) fun v => hinv v) := by
  have key : ∀ (c : ℂ) (w : F), (∀ v : D, (inner ℂ (A (v : F)) w : ℂ) = inner ℂ (v : F) (c • w)) →
      A w = c • w := by
    intro c w hw
    refine sub_eq_zero.mp (eq_zero_of_inner_left_eq_zero_on_dense hdense (A w - c • w) fun v => ?_)
    have hs := hsym (v : F) w
    simp only [ContinuousLinearMap.coe_coe] at hs
    rw [inner_sub_right, ← hw v, ← hs]
    ring
  constructor
  · intro w hw
    exact (symmetric_hasZeroDeficiency (A : F →ₗ[ℂ] F) hsym).1 w (key Complex.I w hw)
  · intro w hw
    refine (symmetric_hasZeroDeficiency (A : F →ₗ[ℂ] F) hsym).2 w ?_
    have := key (-Complex.I) w (by simpa using hw)
    simpa using this

end Abstract

/-! ## Finitely supported modes of an `ℓ²` space

The *finite-particle domain* of an `ℓ²` space: the states exciting only finitely
many modes.  It is dense (every `ℓ²` state is the limit of its truncations) and,
whenever the index type is infinite, a **proper** subspace — so it is the natural
place to test statements about densely defined operators. -/

section LpFiniteModes

variable {ι : Type*}

/-- The **finitely supported modes** of `ℓ²(ι)`. -/
def lpFiniteModes (ι : Type*) : Submodule ℂ (lp (fun _ : ι => ℂ) 2) where
  carrier := {f : lp (fun _ : ι => ℂ) 2 | (Function.support ((f : ι → ℂ))).Finite}
  add_mem' := by
    intro f g hf hg
    refine Set.Finite.subset (hf.union hg) ?_
    intro k hk
    simp only [Function.mem_support, lp.coeFn_add, Pi.add_apply] at hk
    by_contra hcon
    simp only [Set.mem_union, Function.mem_support, not_or, not_not] at hcon
    exact hk (by rw [hcon.1, hcon.2, add_zero])
  zero_mem' := by
    simp only [Set.mem_setOf_eq, lp.coeFn_zero]
    simp
  smul_mem' := by
    intro c f hf
    refine Set.Finite.subset hf ?_
    intro k hk
    simp only [Function.mem_support, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul] at hk
    exact fun hzero => hk (by rw [hzero, mul_zero])

theorem mem_lpFiniteModes {f : lp (fun _ : ι => ℂ) 2} :
    f ∈ lpFiniteModes ι ↔ (Function.support ((f : ι → ℂ))).Finite := Iff.rfl

/-- Each canonical basis state `e_k` has finite support. -/
theorem lpSingle_mem_lpFiniteModes [DecidableEq ι] (k : ι) (c : ℂ) :
    lp.single 2 k c ∈ lpFiniteModes ι := by
  refine Set.Finite.subset (Set.finite_singleton k) ?_
  intro j hj
  simp only [Function.mem_support] at hj
  by_contra hne
  have hjk : j ≠ k := by simpa using hne
  exact hj (by simp [lp.single_apply, Pi.single_eq_of_ne hjk])

/-- **The finite-mode domain is dense**: every `ℓ²` state is the limit of its
finite truncations. -/
theorem lpFiniteModes_dense :
    Dense ((lpFiniteModes ι : Submodule ℂ (lp (fun _ : ι => ℂ) 2)) :
      Set (lp (fun _ : ι => ℂ) 2)) := by
  classical
  intro f
  refine mem_closure_of_tendsto (lp.hasSum_single (by simp) f) ?_
  filter_upwards with S
  exact Submodule.sum_mem _ fun k _ => lpSingle_mem_lpFiniteModes k _

end LpFiniteModes

/-! ## An infinite-dimensional instance on a *proper* dense domain

The `ℓ²(ℤ)` layer of `BookProof.ChapterContinuityUnitaryInfinite` carries a
bounded self-adjoint generator, the Weyl-symmetrized continuity Hamiltonian
`H = ½(p v + v p)`.  Its natural *finite-particle* domain — the states with only
finitely many excited lattice modes — is dense but not the whole space, so the
statement `HasZeroDeficiencyOn finiteModes …` is a genuine (non-`⊤`) instance of
essential self-adjointness on a dense domain. -/

section InfiniteLattice

open BookProof.ChapterContinuityUnitaryInfinite

/-- The finitely supported modes of the lattice Hilbert space `ℓ²(ℤ)`. -/
abbrev finiteModes : Submodule ℂ L2Z := lpFiniteModes ℤ

theorem mem_finiteModes {f : L2Z} :
    f ∈ finiteModes ↔ (Function.support ((f : ℤ → ℂ))).Finite := Iff.rfl

theorem single_mem_finiteModes (k : ℤ) (c : ℂ) : lp.single 2 k c ∈ finiteModes :=
  lpSingle_mem_lpFiniteModes k c

/-- The lattice finite-mode domain is dense. -/
theorem finiteModes_dense : Dense ((finiteModes : Submodule ℂ L2Z) : Set L2Z) :=
  lpFiniteModes_dense

/-- The finite-mode domain is a **proper** subspace: the `ℓ²` state
`k ↦ 1/k` has infinitely many excited modes. -/
theorem finiteModes_ne_top : finiteModes ≠ (⊤ : Submodule ℂ L2Z) := by
  have hsummable : Summable fun k : ℤ => ‖(1 / (k : ℂ))‖ ^ 2 := by
    have h := (Real.summable_one_div_int_pow (p := 2)).mpr (by norm_num)
    refine h.congr fun k => ?_
    rw [norm_div, norm_one, Complex.norm_intCast, div_pow, one_pow, sq_abs]
  set g : L2Z := ⟨fun k : ℤ => 1 / (k : ℂ), memℓp_two_of_summable hsummable⟩ with hgdef
  intro htop
  have hg : g ∈ finiteModes := htop ▸ Submodule.mem_top
  rw [mem_finiteModes] at hg
  have hsub : (Set.univ \ {(0 : ℤ)}) ⊆ Function.support ((g : ℤ → ℂ)) := by
    intro k hk
    have hk0 : k ≠ 0 := by simpa using hk.2
    have hkC : (k : ℂ) ≠ 0 := Int.cast_ne_zero.mpr hk0
    simpa [hgdef, Function.mem_support] using one_div_ne_zero hkC
  exact (Set.infinite_univ.diff (Set.finite_singleton (0 : ℤ))) (hg.subset hsub)

/-- The lattice translation preserves the finite-mode domain. -/
theorem shiftOp_mem_finiteModes (m : ℤ) {f : L2Z} (hf : f ∈ finiteModes) :
    shiftOp m f ∈ finiteModes := by
  rw [mem_finiteModes] at hf ⊢
  refine Set.Finite.subset (hf.image fun k => k - m) ?_
  intro k hk
  simp only [Function.mem_support, shiftOp_apply] at hk
  exact ⟨k + m, hk, by ring⟩

/-- Multiplication by a bounded velocity field preserves the finite-mode
domain. -/
theorem velocityOp_mem_finiteModes (v : LinfZ) {f : L2Z} (hf : f ∈ finiteModes) :
    velocityOp v f ∈ finiteModes := by
  rw [mem_finiteModes] at hf ⊢
  refine hf.subset fun k hk => ?_
  simp only [Function.mem_support, velocityOp_apply] at hk
  exact fun hzero => hk (by rw [hzero, mul_zero])

/-- The continuity generator preserves the finite-mode domain. -/
theorem continuityHamiltonian_mem_finiteModes (v : LinfZ) {f : L2Z} (hf : f ∈ finiteModes) :
    continuityHamiltonian v f ∈ finiteModes := by
  have hmom : ∀ {g : L2Z}, g ∈ finiteModes → momentum g ∈ finiteModes := by
    intro g hg
    have hstep := Submodule.smul_mem finiteModes (-Complex.I / 2)
      (Submodule.sub_mem finiteModes (shiftOp_mem_finiteModes 1 hg)
        (shiftOp_mem_finiteModes (-1) hg))
    simpa [momentum] using hstep
  have h1 : momentum (velocityOp v f) ∈ finiteModes := hmom (velocityOp_mem_finiteModes v hf)
  have h2 : velocityOp v (momentum f) ∈ finiteModes := velocityOp_mem_finiteModes v (hmom hf)
  have hstep := Submodule.smul_mem finiteModes (1 / 2 : ℂ) (Submodule.add_mem finiteModes h1 h2)
  simpa [continuityHamiltonian] using hstep

/-- **An infinite-dimensional, proper-dense-domain instance of essential
self-adjointness.**  The Weyl-symmetrized continuity generator of
`BookProof.ChapterContinuityUnitaryInfinite`, restricted to the finitely
supported modes of `ℓ²(ℤ)`, has vanishing adjoint deficiency.  Together with
`finiteModes_ne_top` this shows that `HasZeroDeficiencyOn` has content beyond
the everywhere-defined case treated in `BookProof.ChapterNavierStokesFlow`. -/
theorem continuityHamiltonian_hasZeroDeficiencyOn_finiteModes (v : LinfZ) :
    HasZeroDeficiencyOn finiteModes
      (LinearMap.codRestrict finiteModes
        ((continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).comp finiteModes.subtype)
        fun f => continuityHamiltonian_mem_finiteModes v f.2) :=
  hasZeroDeficiencyOn_of_bounded_symmetric (continuityHamiltonian v)
    (continuityHamiltonian_isSymmetric v) finiteModes finiteModes_dense
    fun f => continuityHamiltonian_mem_finiteModes v f.2

end InfiniteLattice

/-! ## The truncated Navier–Stokes generator, via its complete flow

The truncation was already known to be essentially self-adjoint by symmetry
(`nsHamiltonian_hasZeroDeficiencyOn`).  Here it is re-derived along the route
that the continuum question would have to follow: from the **completeness** of
its unitary flow. -/

section Truncation

variable {n : ℕ} (d : NSTruncation n)

/-- The truncated Navier–Stokes flow, transported to the Euclidean (`ℓ²`) model
of `ℂⁿ`. -/
noncomputable def nsFlowEuclidean (t : ℝ) (psi : EuclideanSpace ℂ (Fin n)) :
    EuclideanSpace ℂ (Fin n) :=
  WithLp.toLp 2 (nsFlowUnitary d t *ᵥ WithLp.ofLp psi)

/-- The transported flow is norm-preserving. -/
theorem nsFlowEuclidean_norm (t : ℝ) (psi : EuclideanSpace ℂ (Fin n)) :
    ‖nsFlowEuclidean d t psi‖ = ‖psi‖ := by
  rw [EuclideanSpace.norm_eq, EuclideanSpace.norm_eq]
  congr 1
  simpa [nsFlowEuclidean] using nsFlow_norm_preserving d t (WithLp.ofLp psi)

/-- The transported flow starts at the identity. -/
theorem nsFlowEuclidean_zero (psi : EuclideanSpace ℂ (Fin n)) :
    nsFlowEuclidean d 0 psi = psi := by
  simp [nsFlowEuclidean, nsFlow_zero]

/-- The transported flow solves the Schrödinger equation of the truncation. -/
theorem nsFlowEuclidean_hasDerivAt (psi : EuclideanSpace ℂ (Fin n)) (t : ℝ) :
    HasDerivAt (fun s : ℝ => nsFlowEuclidean d s psi)
      (Complex.I • Matrix.toEuclideanLin (nsHamiltonian d) (nsFlowEuclidean d t psi)) t := by
  have h := nsFlow_solves_schrodinger d (WithLp.ofLp psi) t
  have h2 := ((((PiLp.continuousLinearEquiv 2 ℂ
      (fun _ : Fin n => ℂ)).symm.toContinuousLinearMap).restrictScalars
      ℝ).hasFDerivAt).comp_hasDerivAt t h
  have heq : Complex.I • Matrix.toEuclideanLin (nsHamiltonian d) (nsFlowEuclidean d t psi)
      = WithLp.toLp 2
        ((Complex.I • nsHamiltonian d) *ᵥ (nsFlowUnitary d t *ᵥ WithLp.ofLp psi)) := by
    ext i
    simp [nsFlowEuclidean, Matrix.smul_mulVec]
  rw [heq]
  simpa [Function.comp_def, nsFlowEuclidean] using h2

/-- **The truncated Navier–Stokes Hamiltonian is essentially self-adjoint
because its flow is complete.**  Every hypothesis of
`hasZeroDeficiencyOn_of_completeUnitaryFlow` is supplied by the results of
`BookProof.ChapterNavierStokesFlow` and `BookProof.ChapterNavierStokesCauchy`:
the flow is unitary, starts at the identity, and — the point of the plan's
Part D — exists for *every* real time.  This is the same conclusion as
`nsHamiltonian_hasZeroDeficiencyOn`, reached by the criterion that the
continuum problem would have to satisfy. -/
theorem nsHamiltonian_hasZeroDeficiencyOn_of_flow :
    HasZeroDeficiencyOn (⊤ : Submodule ℂ (EuclideanSpace ℂ (Fin n)))
      (restrictToTop (Matrix.toEuclideanLin (nsHamiltonian d))) :=
  hasZeroDeficiencyOn_of_completeUnitaryFlow _ _ (nsFlowEuclidean d)
    (by simp) (fun t psi => nsFlowEuclidean_norm d t psi)
    (fun psi => nsFlowEuclidean_zero d psi) (fun _ _ => trivial)
    (fun psi t => nsFlowEuclidean_hasDerivAt d (psi : EuclideanSpace ℂ (Fin n)) t)

end Truncation

end BookProof.NavierStokesFlow
