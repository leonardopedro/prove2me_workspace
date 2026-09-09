import Mathlib
import BookProof.ChapterSirkRestart

/-!
# BRST leakage under Krylov truncation: a quantitative bound

`CONSOLIDATED_PLAN.md` §12.2 **Gap 5** ("the physical-subspace (BRST) leakage") records
what is missing: the truncated dynamics the SIRK/Hashimoto solver actually integrates does
*not* preserve the physical subspace — the numerics document growth of the BRST-charge
content `‖Ω ψ(t)‖` under aggressive truncation, which is why the solver rides a BRST
projector along — and no formal bound on that leakage in terms of the truncation exists.
`BookProof.ChapterBRSTNilpotent` supplies the algebraic side (`Ω² = 0`, `[H, Ω] = 0`); this
module supplies the analytic side.

## What is new here

`BookProof.ChapterSirkRestart.brst_leakage_bound` already bounds the leakage of `n` cycles of
a truncated *propagator* `S` by `‖Ω‖ n ε ‖v‖` — but with the per-cycle closeness `ε` of `S`
to the exact propagator as a *hypothesis*, so nothing there ties the leakage to the
truncation itself.  This module works one level down, at the generators the algorithm
actually truncates, and produces `ε` rather than assuming it: the leakage rate is the norm
of the block of the Hamiltonian that the truncation discards.  The bridge back is
`brst_leakage_bound_of_generator`.

## The statement

Everything is at the level of *bounded* generators — the finite-`m` reduced generators the
algorithm exponentiates, and any bounded model Hamiltonian — on a complex Hilbert space `E`.
For a self-adjoint `A` the flow is `flow A t = exp (t • (-i A))`, a unitary group
(`flow_mem_unitary`, `norm_flow_apply`).

* **Exact dynamics does not leak.**  If `Ω` commutes with `H` then `Ω` is carried along the
  flow, `omega_flow_apply`, so `‖Ω (flow H t x)‖ = ‖Ω x‖` (`norm_omega_flow_eq`) and the
  physical subspace `ker Ω` is invariant (`flow_mem_ker_omega`).
* **The Duhamel estimate.**  `norm_flow_sub_flow_apply_le`: if `‖(A − B)(flow B s x)‖ ≤ K`
  along the `B`-orbit for `s ∈ [0, t]`, then `‖flow B t x − flow A t x‖ ≤ K t`.  The proof
  is the derivative of `s ↦ flow A (t − s) (flow B s x)` (`hasDerivAt_duhamel`) together
  with the mean-value inequality; unitarity of the two groups is what makes the derivative
  bound `K` and not `K e^{c t}`.
* **The sharp transfer rate.**  `norm_flow_sub_flow_le`: in operator norm,
  `‖e^{-itA} − e^{-itB}‖ ≤ ‖A − B‖ t` for self-adjoint bounded generators — the rate that
  `BookProof.ChapterSirkGroupTransfer` records as not claimed there, its telescoping
  estimate carrying an extra factor `e^{|t| M}` (which it needs, being valid for arbitrary
  bounded generators).
* **The leakage bound.**  `leakage_le`: for the truncated flow `ψ(t) = flow B t x`,

  `‖Ω ψ(t)‖ ≤ ‖Ω x‖ + ‖Ω‖ K t`,

  and `leakage_le_of_physical` for a physical initial state (`Ω x = 0`): the leakage grows
  at most linearly in `t`, with slope `‖Ω‖ K`.
* **The truncation instance.**  For an orthogonal projection `P` (idempotent and
  self-adjoint) the truncated generator is `truncGen P H = P H P`; the flow of the truncated
  generator keeps a state inside the retained subspace (`flow_truncGen_mem`, proved by an ODE
  uniqueness argument, not by a series manipulation), so the constant `K` is the
  *off-diagonal block* `‖(1 − P) H P‖ ‖x‖` and not the crude `‖H − P H P‖ ‖x‖`:
  **`truncation_leakage_le`**

  `‖Ω (flow (P H P) t x)‖ ≤ ‖Ω x‖ + ‖Ω‖ ‖(1 − P) H P‖ ‖x‖ t`   (`P x = x`).

  In particular a state that is physical and retained leaks at most
  `‖Ω‖ ‖(1 − P) H P‖ ‖x‖ t` (`truncation_leakage_le_of_physical`): the leakage is controlled
  by the part of the Hamiltonian that the truncation discards, and vanishes with it.
* **Both time directions.**  The bounds above are stated for `t ≥ 0`; when the defect is
  bounded along the whole orbit they hold for every real `t` with `t` replaced by `|t|`
  (`norm_flow_sub_flow_apply_le_abs`, `leakage_le_abs`, `truncation_leakage_le_abs`), by
  reflecting the generators.
* **Restarts.**  The numerics restarts the Krylov cycle, with a *new* truncation each cycle
  (§12.2 Gap 4a).  `leakageIter` is the restarted state after `n` cycles of length `τ` with
  truncated generators `B 0, B 1, …`, and **`leakage_iterate_le`** accumulates the bound
  linearly in the number of cycles:

  `‖Ω (leakageIter B τ x n)‖ ≤ ‖Ω x‖ + n ‖Ω‖ K τ ‖x‖`  whenever `‖H − B i‖ ≤ K`.

## Honest boundary

The generators here are bounded operators: this is the finite-`m` reduced problem and any
bounded model, not the unbounded field-theoretic Hamiltonian, for which the same estimate
needs the Duhamel argument in the strong-resolvent form of `ChapterSirkTrotterKato`.  `Ω` is
an arbitrary bounded operator commuting with `H`; nilpotency `Ω² = 0` — the BRST content of
`ChapterBRSTNilpotent` — is not needed for the leakage bound and is therefore not assumed.
No floating-point analysis (§12.2 Gap 6) is claimed.
-/

open NormedSpace

namespace BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-! ## The unitary group of a bounded self-adjoint generator -/

/-- The flow `e^{-i t A}` of a bounded generator `A`. -/
noncomputable def flow (A : E →L[ℂ] E) (t : ℝ) : E →L[ℂ] E := exp (t • ((-Complex.I) • A))

@[simp] lemma flow_zero (A : E →L[ℂ] E) : flow A 0 = 1 := by
  simp [flow]

@[simp] lemma flow_apply_zero (A : E →L[ℂ] E) (x : E) : flow A 0 x = x := by
  simp [flow]

/-- The flow of a self-adjoint generator is unitary. -/
theorem flow_mem_unitary {A : E →L[ℂ] E} (hA : IsSelfAdjoint A) (t : ℝ) :
    flow A t ∈ unitary (E →L[ℂ] E) := by
  have h1 : t • ((-Complex.I) • A) = Complex.I • ((-(t : ℝ)) • A) := by
    rw [smul_comm]; module
  have h2 : IsSelfAdjoint ((-(t : ℝ)) • A) := (IsSelfAdjoint.all (-(t : ℝ))).smul hA
  rw [flow, h1]
  exact (selfAdjoint.expUnitary ⟨_, h2⟩).2

/-- A unitary operator is an isometry. -/
theorem norm_unitary_apply {U : E →L[ℂ] E} (hU : U ∈ unitary (E →L[ℂ] E)) (x : E) :
    ‖U x‖ = ‖x‖ := by
  have h : star U * U = 1 := hU.1
  have hx : (ContinuousLinearMap.adjoint U) (U x) = x := by
    have : ((star U * U) : E →L[ℂ] E) x = (1 : E →L[ℂ] E) x := by rw [h]
    simpa [ContinuousLinearMap.star_eq_adjoint] using this
  have h2 : (inner ℂ (U x) (U x) : ℂ) = inner ℂ x x := by
    rw [← ContinuousLinearMap.adjoint_inner_left, hx]
  have h3 : ‖U x‖ ^ 2 = ‖x‖ ^ 2 := by
    have := congrArg Complex.re h2
    simpa [inner_self_eq_norm_sq_to_K, ← Complex.ofReal_pow] using this
  nlinarith [norm_nonneg (U x), norm_nonneg x, h3]

/-- The flow of a self-adjoint generator preserves the norm. -/
theorem norm_flow_apply {A : E →L[ℂ] E} (hA : IsSelfAdjoint A) (t : ℝ) (x : E) :
    ‖flow A t x‖ = ‖x‖ :=
  norm_unitary_apply (flow_mem_unitary hA t) x

/-! ## Exact dynamics carries a commuting observable along -/

/-- An observable commuting with the generator commutes with the flow. -/
theorem omega_flow_apply {A Om : E →L[ℂ] E} (h : Commute A Om) (t : ℝ) (x : E) :
    Om (flow A t x) = flow A t (Om x) := by
  have hc : Commute (t • ((-Complex.I) • A)) Om := (h.smul_left (-Complex.I)).smul_left t
  have : exp (t • ((-Complex.I) • A)) * Om = Om * exp (t • ((-Complex.I) • A)) :=
    (hc.exp_left).eq
  have := congrArg (fun T : E →L[ℂ] E => T x) this.symm
  simpa [flow, ContinuousLinearMap.mul_apply] using this

/-- **Exact dynamics does not leak.**  The BRST content of a state is constant along the
exact flow. -/
theorem norm_omega_flow_eq {A Om : E →L[ℂ] E} (hA : IsSelfAdjoint A) (h : Commute A Om)
    (t : ℝ) (x : E) : ‖Om (flow A t x)‖ = ‖Om x‖ := by
  rw [omega_flow_apply h t x, norm_flow_apply hA]

/-- **The physical subspace is invariant under the exact flow.** -/
theorem flow_mem_ker_omega {A Om : E →L[ℂ] E} (h : Commute A Om) (t : ℝ) {x : E}
    (hx : Om x = 0) : Om (flow A t x) = 0 := by
  rw [omega_flow_apply h t x, hx, map_zero]

/-! ## The Duhamel estimate -/

/-- The Duhamel derivative: the derivative of `s ↦ e^{(t-s)X} e^{sY} x`. -/
theorem hasDerivAt_duhamel (X Y : E →L[ℂ] E) (t s : ℝ) (x : E) :
    HasDerivAt (fun u : ℝ => (exp ((t - u) • X)) ((exp (u • Y)) x))
      ((exp ((t - s) • X)) ((Y - X) ((exp (s • Y)) x))) s := by
  have hc : HasDerivAt (fun u : ℝ => exp ((t - u) • X)) (-(exp ((t - s) • X) * X)) s := by
    have h1 : HasDerivAt (fun u : ℝ => exp (u • X)) (exp ((t - s) • X) * X) (t - s) :=
      hasDerivAt_exp_smul_const X (t - s)
    have h2 : HasDerivAt (fun u : ℝ => t - u) (-1) s := by
      simpa using (hasDerivAt_id s).const_sub t
    simpa [Function.comp_def] using h1.scomp s h2
  have hd : HasDerivAt (fun u : ℝ => exp (u • Y)) (exp (s • Y) * Y) s :=
    hasDerivAt_exp_smul_const Y s
  have hmul := hc.mul hd
  have hev : HasFDerivAt (fun T : E →L[ℂ] E => T x)
      ((ContinuousLinearMap.apply ℂ E x).restrictScalars ℝ) (exp ((t - s) • X) * exp (s • Y)) :=
    ((ContinuousLinearMap.apply ℂ E x).restrictScalars ℝ).hasFDerivAt
  have hres := hev.comp_hasDerivAt s hmul
  have hcomm : exp (s • Y) * Y = Y * exp (s • Y) := ((Commute.refl Y).smul_left s).exp_left.eq
  have heq : (-(exp ((t - s) • X) * X) * exp (s • Y) + exp ((t - s) • X) * (exp (s • Y) * Y)) x
      = (exp ((t - s) • X)) ((Y - X) ((exp (s • Y)) x)) := by
    rw [hcomm]
    simp [ContinuousLinearMap.sub_apply, ContinuousLinearMap.mul_apply]
    abel
  rw [← heq]
  exact hres

/-- **The Duhamel estimate.**  If the generators differ by at most `K` along the `B`-orbit
of `x`, then the two flows of `x` differ by at most `K t`. -/
theorem norm_flow_sub_flow_apply_le {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (t : ℝ) (ht : 0 ≤ t) (x : E) (K : ℝ)
    (hK : ∀ s ∈ Set.Icc (0 : ℝ) t, ‖(A - B) (flow B s x)‖ ≤ K) :
    ‖flow B t x - flow A t x‖ ≤ K * t := by
  set X : E →L[ℂ] E := (-Complex.I) • A with hXdef
  set Y : E →L[ℂ] E := (-Complex.I) • B with hYdef
  set g : ℝ → E := fun u => (exp ((t - u) • X)) ((exp (u • Y)) x) with hg
  have hderiv : ∀ s ∈ Set.Icc (0 : ℝ) t,
      HasDerivWithinAt g ((exp ((t - s) • X)) ((Y - X) ((exp (s • Y)) x))) (Set.Icc 0 t) s :=
    fun s _ => (hasDerivAt_duhamel X Y t s x).hasDerivWithinAt
  have hbound : ∀ s ∈ Set.Ico (0 : ℝ) t,
      ‖(exp ((t - s) • X)) ((Y - X) ((exp (s • Y)) x))‖ ≤ K := by
    intro s hs
    have hs' : s ∈ Set.Icc (0 : ℝ) t := ⟨hs.1, hs.2.le⟩
    have h1 : ‖(exp ((t - s) • X)) ((Y - X) ((exp (s • Y)) x))‖ = ‖(Y - X) (flow B s x)‖ := by
      have := norm_flow_apply hA (t - s) ((Y - X) ((exp (s • Y)) x))
      simpa [flow, hXdef, hYdef] using this
    have h2 : (Y - X) (flow B s x) = (-Complex.I) • ((B - A) (flow B s x)) := by
      simp [hXdef, hYdef, ContinuousLinearMap.sub_apply, smul_sub]
    have h3 : ‖(Y - X) (flow B s x)‖ = ‖(A - B) (flow B s x)‖ := by
      rw [h2]
      simp [norm_smul, ContinuousLinearMap.sub_apply, ← norm_neg (A (flow B s x) - _)]
    rw [h1, h3]
    exact hK s hs'
  have hmvt := norm_image_sub_le_of_norm_deriv_le_segment' hderiv hbound t
    (Set.right_mem_Icc.mpr ht)
  have hgt : g t = flow B t x := by simp [hg, flow, hYdef]
  have hg0 : g 0 = flow A t x := by simp [hg, flow, hXdef]
  rw [hgt, hg0] at hmvt
  simpa using hmvt

@[simp] lemma flow_neg_gen (A : E →L[ℂ] E) (t : ℝ) : flow (-A) t = flow A (-t) := by
  simp only [flow]
  congr 1
  module

/-- The Duhamel estimate at **any** time, positive or negative, when the defect is bounded
along the whole `B`-orbit. -/
theorem norm_flow_sub_flow_apply_le_abs {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (t : ℝ) (x : E) (K : ℝ) (hK : ∀ s : ℝ, ‖(A - B) (flow B s x)‖ ≤ K) :
    ‖flow B t x - flow A t x‖ ≤ K * |t| := by
  rcases le_or_gt 0 t with ht | ht
  · rw [abs_of_nonneg ht]
    exact norm_flow_sub_flow_apply_le hA t ht x K fun s _ => hK s
  · have hA' : IsSelfAdjoint (-A) := hA.neg
    have hK' : ∀ s ∈ Set.Icc (0 : ℝ) (-t), ‖((-A) - (-B)) (flow (-B) s x)‖ ≤ K := by
      intro s _
      have h1 : ((-A) - (-B)) = -(A - B) := by abel
      rw [h1, flow_neg_gen]
      rw [ContinuousLinearMap.neg_apply, norm_neg]
      exact hK (-s)
    have := norm_flow_sub_flow_apply_le hA' (-t) (by linarith) x K hK'
    rw [flow_neg_gen, flow_neg_gen, neg_neg] at this
    rwa [abs_of_neg ht]

/-- The crude form of the Duhamel estimate, with the operator-norm defect. -/
theorem norm_flow_sub_flow_apply_le' {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (hB : IsSelfAdjoint B) (t : ℝ) (ht : 0 ≤ t) (x : E) :
    ‖flow B t x - flow A t x‖ ≤ ‖A - B‖ * ‖x‖ * t := by
  refine norm_flow_sub_flow_apply_le hA t ht x _ fun s _ => ?_
  calc ‖(A - B) (flow B s x)‖ ≤ ‖A - B‖ * ‖flow B s x‖ := (A - B).le_opNorm _
    _ = ‖A - B‖ * ‖x‖ := by rw [norm_flow_apply hB]

/-- **The sharp rate for the unitary-group transfer.**  For *self-adjoint* bounded
generators the two propagators differ in operator norm by at most `‖A − B‖ t`, with no
exponential factor.  This is the rate that
`BookProof.ChapterSirkGroupTransfer.norm_groupFlow_sub_le` records as not claimed there:
its telescoping estimate gives `|t| ‖A − B‖ e^{|t| M}`, valid for arbitrary bounded
generators. -/
theorem norm_flow_sub_flow_le {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (hB : IsSelfAdjoint B) (t : ℝ) (ht : 0 ≤ t) :
    ‖flow A t - flow B t‖ ≤ ‖A - B‖ * t := by
  refine ContinuousLinearMap.opNorm_le_bound _ (by positivity) fun x => ?_
  have h := norm_flow_sub_flow_apply_le' hA hB t ht x
  have hrw : ‖(flow A t - flow B t) x‖ = ‖flow B t x - flow A t x‖ := by
    rw [ContinuousLinearMap.sub_apply, ← norm_neg, neg_sub]
  rw [hrw]
  calc ‖flow B t x - flow A t x‖ ≤ ‖A - B‖ * ‖x‖ * t := h
    _ = ‖A - B‖ * t * ‖x‖ := by ring

/-! ## The leakage bound -/

/-- **The BRST leakage bound.**  Along the truncated flow the BRST content of the state
grows at most linearly in time, at a rate set by the truncation defect. -/
theorem leakage_le {H B Om : E →L[ℂ] E} (hH : IsSelfAdjoint H) (hcomm : Commute H Om)
    (t : ℝ) (ht : 0 ≤ t) (x : E) (K : ℝ)
    (hK : ∀ s ∈ Set.Icc (0 : ℝ) t, ‖(H - B) (flow B s x)‖ ≤ K) :
    ‖Om (flow B t x)‖ ≤ ‖Om x‖ + ‖Om‖ * (K * t) := by
  have hsplit : Om (flow B t x) = Om (flow H t x) + Om (flow B t x - flow H t x) := by
    rw [map_sub]; abel
  have h1 : ‖Om (flow H t x)‖ = ‖Om x‖ := norm_omega_flow_eq hH hcomm t x
  have h2 : ‖Om (flow B t x - flow H t x)‖ ≤ ‖Om‖ * (K * t) := by
    refine le_trans (Om.le_opNorm _) ?_
    exact mul_le_mul_of_nonneg_left (norm_flow_sub_flow_apply_le hH t ht x K hK)
      (norm_nonneg Om)
  calc ‖Om (flow B t x)‖ ≤ ‖Om (flow H t x)‖ + ‖Om (flow B t x - flow H t x)‖ := by
        rw [hsplit]; exact norm_add_le _ _
    _ ≤ ‖Om x‖ + ‖Om‖ * (K * t) := by rw [h1]; gcongr

/-- The leakage bound for a physical initial state: the BRST content created by the
truncation is at most `‖Ω‖ K t`. -/
theorem leakage_le_of_physical {H B Om : E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hcomm : Commute H Om) (t : ℝ) (ht : 0 ≤ t) {x : E} (hx : Om x = 0) (K : ℝ)
    (hK : ∀ s ∈ Set.Icc (0 : ℝ) t, ‖(H - B) (flow B s x)‖ ≤ K) :
    ‖Om (flow B t x)‖ ≤ ‖Om‖ * (K * t) := by
  simpa [hx] using leakage_le hH hcomm t ht x K hK

/-- The leakage bound at any time, positive or negative. -/
theorem leakage_le_abs {H B Om : E →L[ℂ] E} (hH : IsSelfAdjoint H) (hcomm : Commute H Om)
    (t : ℝ) (x : E) (K : ℝ) (hK : ∀ s : ℝ, ‖(H - B) (flow B s x)‖ ≤ K) :
    ‖Om (flow B t x)‖ ≤ ‖Om x‖ + ‖Om‖ * (K * |t|) := by
  have hsplit : Om (flow B t x) = Om (flow H t x) + Om (flow B t x - flow H t x) := by
    rw [map_sub]; abel
  have h1 : ‖Om (flow H t x)‖ = ‖Om x‖ := norm_omega_flow_eq hH hcomm t x
  have h2 : ‖Om (flow B t x - flow H t x)‖ ≤ ‖Om‖ * (K * |t|) :=
    le_trans (Om.le_opNorm _)
      (mul_le_mul_of_nonneg_left (norm_flow_sub_flow_apply_le_abs hH t x K hK)
        (norm_nonneg Om))
  calc ‖Om (flow B t x)‖ ≤ ‖Om (flow H t x)‖ + ‖Om (flow B t x - flow H t x)‖ := by
        rw [hsplit]; exact norm_add_le _ _
    _ ≤ ‖Om x‖ + ‖Om‖ * (K * |t|) := by rw [h1]; gcongr

/-! ## The truncation instance -/

/-- The truncated generator `P H P` of an orthogonal projection `P`. -/
def truncGen (P H : E →L[ℂ] E) : E →L[ℂ] E := P * H * P

theorem truncGen_isSelfAdjoint {P H : E →L[ℂ] E} (hP : IsSelfAdjoint P)
    (hH : IsSelfAdjoint H) : IsSelfAdjoint (truncGen P H) := by
  have : star (P * H * P) = P * H * P := by
    rw [star_mul, star_mul, hP.star_eq, hH.star_eq]
    rw [mul_assoc]
  exact this

/-- The truncated flow keeps a retained state inside the retained subspace.  Proved by ODE
uniqueness: `f = flow (P H P) · x` and `P f` solve the same linear equation and agree at
`t = 0`. -/
theorem flow_truncGen_mem {P H : E →L[ℂ] E} (hP : IsIdempotentElem P) (t : ℝ) {x : E}
    (hx : P x = x) : P (flow (truncGen P H) t x) = flow (truncGen P H) t x := by
  set Z : E →L[ℂ] E := (-Complex.I) • truncGen P H with hZ
  have hPZ : P * Z = Z := by
    rw [hZ, truncGen]
    rw [mul_smul_comm, ← mul_assoc, ← mul_assoc, hP.eq]
  set f : ℝ → E := fun u => (exp (u • Z)) x with hf
  set d : ℝ → E := fun u => P (f u) - f u with hd
  have hfderiv : ∀ u : ℝ, HasDerivAt f (Z (f u)) u := by
    intro u
    have h1 : HasDerivAt (fun v : ℝ => exp (v • Z)) (exp (u • Z) * Z) u :=
      hasDerivAt_exp_smul_const Z u
    have hev : HasFDerivAt (fun T : E →L[ℂ] E => T x)
        ((ContinuousLinearMap.apply ℂ E x).restrictScalars ℝ) (exp (u • Z)) :=
      ((ContinuousLinearMap.apply ℂ E x).restrictScalars ℝ).hasFDerivAt
    have h2 := hev.comp_hasDerivAt u h1
    have hcomm : exp (u • Z) * Z = Z * exp (u • Z) := ((Commute.refl Z).smul_left u).exp_left.eq
    simpa [hf, Function.comp_def, hcomm, ContinuousLinearMap.mul_apply] using h2
  have hPfderiv : ∀ u : ℝ, HasDerivAt (fun v => P (f v)) (Z (f u)) u := by
    intro u
    have := (P.restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt u (hfderiv u)
    have hPZ' : P (Z (f u)) = Z (f u) := by
      have := congrArg (fun T : E →L[ℂ] E => T (f u)) hPZ
      simpa [ContinuousLinearMap.mul_apply] using this
    simpa [Function.comp_def, hPZ'] using this
  have hdderiv : ∀ u : ℝ, HasDerivAt d 0 u := by
    intro u
    simpa [hd] using (hPfderiv u).sub (hfderiv u)
  have hconst : d t = d 0 := by
    have : ∀ u : ℝ, deriv d u = 0 := fun u => (hdderiv u).deriv
    have hdiff : Differentiable ℝ d := fun u => (hdderiv u).differentiableAt
    exact is_const_of_deriv_eq_zero hdiff this t 0
  have h0 : d 0 = 0 := by simp [hd, hf, hx]
  have : d t = 0 := by rw [hconst, h0]
  have := sub_eq_zero.mp this
  simpa [hd, hf, flow, hZ] using this

/-- **The truncation leakage bound.**  For an orthogonal projection `P` and a retained
initial state, the BRST content of the truncated flow grows at most linearly, at the rate
set by the *discarded* off-diagonal block `(1 − P) H P` of the Hamiltonian. -/
theorem truncation_leakage_le {P H Om : E →L[ℂ] E} (hPi : IsIdempotentElem P)
    (hPs : IsSelfAdjoint P) (hH : IsSelfAdjoint H) (hcomm : Commute H Om)
    (t : ℝ) (ht : 0 ≤ t) {x : E} (hx : P x = x) :
    ‖Om (flow (truncGen P H) t x)‖ ≤ ‖Om x‖ + ‖Om‖ * (‖(1 - P) * H * P‖ * ‖x‖ * t) := by
  have hB : IsSelfAdjoint (truncGen P H) := truncGen_isSelfAdjoint hPs hH
  have hK : ∀ s ∈ Set.Icc (0 : ℝ) t,
      ‖(H - truncGen P H) (flow (truncGen P H) s x)‖ ≤ ‖(1 - P) * H * P‖ * ‖x‖ := by
    intro s _
    set y : E := flow (truncGen P H) s x with hy
    have hPy : P y = y := flow_truncGen_mem hPi s hx
    have hrw : (H - truncGen P H) y = ((1 - P) * H * P) y := by
      have : ((1 - P) * H * P) y = H (P y) - P (H (P y)) := by
        simp [ContinuousLinearMap.mul_apply, ContinuousLinearMap.sub_apply]
      rw [this, hPy]
      simp [truncGen, ContinuousLinearMap.sub_apply, ContinuousLinearMap.mul_apply, hPy]
    rw [hrw]
    calc ‖((1 - P) * H * P) y‖ ≤ ‖(1 - P) * H * P‖ * ‖y‖ := ((1 - P) * H * P).le_opNorm _
      _ = ‖(1 - P) * H * P‖ * ‖x‖ := by rw [hy, norm_flow_apply hB]
  have := leakage_le hH hcomm t ht x (‖(1 - P) * H * P‖ * ‖x‖) hK
  calc ‖Om (flow (truncGen P H) t x)‖
      ≤ ‖Om x‖ + ‖Om‖ * (‖(1 - P) * H * P‖ * ‖x‖ * t) := by
        simpa [mul_assoc] using this

/-- The truncation leakage bound at any time, positive or negative. -/
theorem truncation_leakage_le_abs {P H Om : E →L[ℂ] E} (hPi : IsIdempotentElem P)
    (hPs : IsSelfAdjoint P) (hH : IsSelfAdjoint H) (hcomm : Commute H Om)
    (t : ℝ) {x : E} (hx : P x = x) :
    ‖Om (flow (truncGen P H) t x)‖ ≤ ‖Om x‖ + ‖Om‖ * (‖(1 - P) * H * P‖ * ‖x‖ * |t|) := by
  have hB : IsSelfAdjoint (truncGen P H) := truncGen_isSelfAdjoint hPs hH
  have hK : ∀ s : ℝ,
      ‖(H - truncGen P H) (flow (truncGen P H) s x)‖ ≤ ‖(1 - P) * H * P‖ * ‖x‖ := by
    intro s
    set y : E := flow (truncGen P H) s x with hy
    have hPy : P y = y := flow_truncGen_mem hPi s hx
    have hrw : (H - truncGen P H) y = ((1 - P) * H * P) y := by
      have hexp : ((1 - P) * H * P) y = H (P y) - P (H (P y)) := by
        simp [ContinuousLinearMap.mul_apply, ContinuousLinearMap.sub_apply]
      rw [hexp, hPy]
      simp [truncGen, ContinuousLinearMap.sub_apply, ContinuousLinearMap.mul_apply, hPy]
    rw [hrw]
    calc ‖((1 - P) * H * P) y‖ ≤ ‖(1 - P) * H * P‖ * ‖y‖ := ((1 - P) * H * P).le_opNorm _
      _ = ‖(1 - P) * H * P‖ * ‖x‖ := by rw [hy, norm_flow_apply hB]
  simpa [mul_assoc] using leakage_le_abs hH hcomm t x (‖(1 - P) * H * P‖ * ‖x‖) hK

/-- The truncation leakage bound for a physical, retained initial state. -/
theorem truncation_leakage_le_of_physical {P H Om : E →L[ℂ] E} (hPi : IsIdempotentElem P)
    (hPs : IsSelfAdjoint P) (hH : IsSelfAdjoint H) (hcomm : Commute H Om)
    (t : ℝ) (ht : 0 ≤ t) {x : E} (hx : P x = x) (hOm : Om x = 0) :
    ‖Om (flow (truncGen P H) t x)‖ ≤ ‖Om‖ * (‖(1 - P) * H * P‖ * ‖x‖ * t) := by
  simpa [hOm] using truncation_leakage_le hPi hPs hH hcomm t ht hx

/-! ## Restarts -/

/-- The restarted state: `n` cycles of length `τ`, the `i`-th integrated with the truncated
generator `B i`. -/
noncomputable def leakageIter (B : ℕ → E →L[ℂ] E) (τ : ℝ) (x : E) : ℕ → E
  | 0 => x
  | n + 1 => flow (B n) τ (leakageIter B τ x n)

@[simp] lemma leakageIter_zero (B : ℕ → E →L[ℂ] E) (τ : ℝ) (x : E) :
    leakageIter B τ x 0 = x := rfl

lemma leakageIter_succ (B : ℕ → E →L[ℂ] E) (τ : ℝ) (x : E) (n : ℕ) :
    leakageIter B τ x (n + 1) = flow (B n) τ (leakageIter B τ x n) := rfl

lemma norm_leakageIter {B : ℕ → E →L[ℂ] E} (hB : ∀ i, IsSelfAdjoint (B i)) (τ : ℝ) (x : E) :
    ∀ n, ‖leakageIter B τ x n‖ = ‖x‖
  | 0 => rfl
  | n + 1 => by
      rw [leakageIter_succ, norm_flow_apply (hB n), norm_leakageIter hB τ x n]

/-- **Accumulated leakage over restarts.**  With a fresh truncation each cycle, the BRST
content grows at most linearly in the number of cycles. -/
theorem leakage_iterate_le {H Om : E →L[ℂ] E} {B : ℕ → E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : ∀ i, IsSelfAdjoint (B i)) (hcomm : Commute H Om) (τ : ℝ) (hτ : 0 ≤ τ) (x : E)
    (K : ℝ) (hK : ∀ i, ‖H - B i‖ ≤ K) :
    ∀ n : ℕ, ‖Om (leakageIter B τ x n)‖ ≤ ‖Om x‖ + n * (‖Om‖ * (K * ‖x‖ * τ))
  | 0 => by simp
  | n + 1 => by
      have hxn : ‖leakageIter B τ x n‖ = ‖x‖ := norm_leakageIter hB τ x n
      have hstep : ∀ s ∈ Set.Icc (0 : ℝ) τ,
          ‖(H - B n) (flow (B n) s (leakageIter B τ x n))‖ ≤ K * ‖x‖ := by
        intro s _
        calc ‖(H - B n) (flow (B n) s (leakageIter B τ x n))‖
            ≤ ‖H - B n‖ * ‖flow (B n) s (leakageIter B τ x n)‖ := (H - B n).le_opNorm _
          _ = ‖H - B n‖ * ‖x‖ := by rw [norm_flow_apply (hB n), hxn]
          _ ≤ K * ‖x‖ := by
              exact mul_le_mul_of_nonneg_right (hK n) (norm_nonneg x)
      have h1 := leakage_le hH hcomm τ hτ (leakageIter B τ x n) (K * ‖x‖) hstep
      have h2 := leakage_iterate_le hH hB hcomm τ hτ x K hK n
      have : ‖Om (leakageIter B τ x (n + 1))‖
          ≤ ‖Om (leakageIter B τ x n)‖ + ‖Om‖ * (K * ‖x‖ * τ) := by
        rw [leakageIter_succ]; exact h1
      have hcast : ((n : ℝ) + 1) * (‖Om‖ * (K * ‖x‖ * τ))
          = (n : ℝ) * (‖Om‖ * (K * ‖x‖ * τ)) + ‖Om‖ * (K * ‖x‖ * τ) := by ring
      push_cast
      rw [hcast]
      linarith

/-! ## The bridge to the discrete restart estimate

`BookProof.ChapterSirkRestart.brst_leakage_bound` bounds the leakage of `n` cycles of a
truncated *propagator* `S` by `‖Ω‖ n ε ‖v‖`, with the per-cycle closeness `ε` of `S` to the
exact propagator `U` as a hypothesis.  For propagators generated by bounded generators the
Duhamel estimate discharges that hypothesis, with `ε = ‖H − B‖ τ`. -/

/-- The one-cycle propagators of two bounded self-adjoint generators are `‖H − B‖ τ`-close.
This discharges the `hstep` hypothesis of `ChapterSirkRestart.brst_leakage_bound`. -/
theorem norm_flow_sub_flow_le_cycle {H B : E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : IsSelfAdjoint B) (tau : ℝ) (htau : 0 ≤ tau) (w : E) :
    ‖flow H tau w - flow B tau w‖ ≤ (‖H - B‖ * tau) * ‖w‖ := by
  rw [← norm_neg]
  have := norm_flow_sub_flow_apply_le' hH hB tau htau w
  calc ‖-(flow H tau w - flow B tau w)‖ = ‖flow B tau w - flow H tau w‖ := by
        rw [neg_sub]
    _ ≤ ‖H - B‖ * ‖w‖ * tau := this
    _ = (‖H - B‖ * tau) * ‖w‖ := by ring

/-- **The restart leakage bound with the constant supplied by the generators.**  Iterating
the truncated propagator `e^{-iτB}` from a physical state, the BRST content after `n`
cycles is at most `‖Ω‖ n ‖H − B‖ τ ‖v‖`. -/
theorem brst_leakage_bound_of_generator {H B Om : E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : IsSelfAdjoint B) (hcomm : Commute H Om) (tau : ℝ) (htau : 0 ≤ tau)
    (n : ℕ) (v : E) (hv : Om v = 0) :
    ‖Om (((flow B tau) ^ n) v)‖ ≤ ‖Om‖ * (n * (‖H - B‖ * tau) * ‖v‖) := by
  refine ChapterSirkRestart.brst_leakage_bound (flow H tau) (flow B tau) Om (‖H - B‖ * tau)
    (fun w => (norm_flow_apply hH tau w).le) (fun w => (norm_flow_apply hB tau w).le)
    (norm_flow_sub_flow_le_cycle hH hB tau htau) ?_ n v hv
  ext w
  simpa using omega_flow_apply hcomm tau w

end BookProof.BrstLeakage
