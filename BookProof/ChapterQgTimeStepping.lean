import Mathlib
import BookProof.ChapterQgTruncationResolvent

/-!
# The time-stepping half: the Crank–Nicolson (Cayley) scheme and the fully discrete flow

**Time stepping is not required by the SIRK/Hashimoto algorithm.**  That algorithm evaluates
the propagator at a *single finite time* by a rational function of the bounded shift-invert
resolvent, so no step size, number of steps or splitting enters; the statements it actually
uses are in `BookProof.ChapterSirkSingleTimeShift`
(`singleTime_flow_tendsto_of_strongResAt`, `qgOuterFock_singleTime_shiftInvert_convergence`),
and they need no boundedness of the Hamiltonian either.  What this module analyses is one
*optional* alternative — a time-marching scheme — and it is kept because it is a
self-contained convergence result, not because the pipeline depends on it.

`BookProof.ChapterQgTruncationResolvent` analyses the *space* half of such a scheme for the
outer-Fock quantum-gravity Hamiltonian: the mode cutoff.  This module analyses the *time*
half, for a concrete scheme — the **Crank–Nicolson / Cayley** (implicit midpoint) step

`C(τ) = (1 − i τ H / 2)(1 + i τ H / 2)⁻¹`,

which is exactly one shift-invert solve per step and is the scheme the shift-invert layer of
this project implements.

## What is proved

* `cnStep` — the one-step propagator, written with the resolvent of the project's
  `UnboundedSelfAdjoint` interface, and `cnStep_eq_neg_shift`, the identification
  `C(τ) = −(H + i·(2/τ))(H − i·(2/τ))⁻¹`.
* `norm_cnStep_apply`, `norm_iterate_cnStep_apply` — the scheme is **unitary**: every step,
  and hence every number of steps, preserves the norm exactly.  There is no numerical
  dissipation and no stability restriction on the step size.
* `cnStep_second_order` and `norm_cnStep_sub_taylor_le` — the **consistency** of the step:
  `C(τ)x = x − iτHx + iτ (H − 2i/τ)⁻¹H²x`, so `‖C(τ)x − (x − iτHx)‖ ≤ (τ²/2)‖H²x‖` for
  every `x` in the domain of `H²`.
* `norm_stoneU_sub_taylor_le` — the same second-order Taylor estimate for the exact flow.
* `norm_cnStep_sub_stoneU_le` — the local error `‖C(τ)x − e^{−iτH}x‖ ≤ 2τ²‖H²x‖`.
* `norm_iterate_cnStep_sub_stoneU_le` — the **global error** after `k` steps,
  `‖C(τ)^k x − e^{−ikτH}x‖ ≤ 2kτ²‖H²x‖`, by telescoping (each step is unitary and the exact
  orbit stays in the domain of `H²` with the same norm).
* **`tendsto_iterate_cnStep`** — hence, for *every* vector of the Hilbert space (no
  smoothness assumption) and every time `t`, the Crank–Nicolson iterates with step `t/k`
  converge to `e^{−itH}v` as `k → ∞`.
* **`qgOuterFock_fullyDiscrete_convergence`** — the fully discrete statement for the
  quantum-gravity Hamiltonian: mode cutoff *and* Crank–Nicolson time stepping.  For each
  cutoff there is a number of time steps such that the resulting fully discrete, finitely
  many degrees of freedom, unitary evolution converges to the exact quantum-gravity flow.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgTimeStepping

open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-! ## 1. The Crank–Nicolson (Cayley) one-step propagator -/

/-- **The Crank–Nicolson step** `C(τ) = (1 − iτA/2)(1 + iτA/2)⁻¹`, expressed through the
resolvent `(A − i l)⁻¹` at `l = 2/τ`:  `C(τ) = −1 − 2 i l (A − i l)⁻¹`. -/
def cnStep (T : UnboundedSelfAdjoint H) (tau : ℝ) : H →L[ℂ] H :=
  -(ContinuousLinearMap.id ℂ H)
    - (((2 * (2 / tau) : ℝ) : ℂ) * Complex.I) • T.resCLM (2 / tau)

theorem cnStep_apply (T : UnboundedSelfAdjoint H) (tau : ℝ) (y : H) :
    cnStep T tau y
      = -y - (((2 * (2 / tau) : ℝ) : ℂ) * Complex.I) • ((T.res (2 / tau) y : T.domain) : H) := by
  simp [cnStep]

theorem two_div_ne_zero {tau : ℝ} (h : tau ≠ 0) : (2 / tau : ℝ) ≠ 0 := by
  simpa using h

/-- The Crank–Nicolson step is the Cayley transform at the parameter `l = 2/τ`:
`C(τ) = −(A + i l)(A − i l)⁻¹`. -/
theorem cnStep_eq_neg_shift (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0) (y : H) :
    cnStep T tau y = -(T.shift (-(2 / tau)) (T.res (2 / tau) y)) := by
  have hl : (2 / tau : ℝ) ≠ 0 := two_div_ne_zero h
  have hop := T.op_res hl y
  rw [cnStep_apply, UnboundedSelfAdjoint.shift_apply, hop]
  push_cast
  module

/-- **The scheme is unitary**: the Crank–Nicolson step preserves the norm exactly. -/
theorem norm_cnStep_apply (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0) (y : H) :
    ‖cnStep T tau y‖ = ‖y‖ := by
  have hl : (2 / tau : ℝ) ≠ 0 := two_div_ne_zero h
  have h1 := T.norm_shift_sq (-(2 / tau)) (T.res (2 / tau) y)
  have h2 := T.norm_shift_sq (2 / tau) (T.res (2 / tau) y)
  rw [T.shift_res hl] at h2
  have hsq : ‖cnStep T tau y‖ ^ 2 = ‖y‖ ^ 2 := by
    rw [cnStep_eq_neg_shift T h, norm_neg, h1, h2]
    ring
  have := congrArg Real.sqrt hsq
  rwa [Real.sqrt_sq (norm_nonneg _), Real.sqrt_sq (norm_nonneg _)] at this

/-- The iterates are linear, so they act on differences. -/
theorem iterate_cnStep_sub (T : UnboundedSelfAdjoint H) (tau : ℝ) (k : ℕ) (u w : H) :
    (cnStep T tau)^[k] u - (cnStep T tau)^[k] w = (cnStep T tau)^[k] (u - w) := by
  induction k with
  | zero => simp
  | succ m ih =>
      rw [Function.iterate_succ_apply', Function.iterate_succ_apply',
        Function.iterate_succ_apply', ← map_sub, ih]

theorem norm_iterate_cnStep_apply (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0)
    (k : ℕ) (y : H) : ‖(cnStep T tau)^[k] y‖ = ‖y‖ := by
  induction k generalizing y with
  | zero => simp
  | succ k ih =>
      rw [Function.iterate_succ_apply, ih, norm_cnStep_apply T h]

/-! ## 2. Consistency: the second-order expansion of one step -/

variable (T : UnboundedSelfAdjoint H)

/-- The exact second-order expansion of the resolvent on the domain of `A²`. -/
theorem res_second_order {l : ℝ} (hl : l ≠ 0) (x : T.domain) (hx : T.op x ∈ T.domain) :
    ((T.res l (x : H) : T.domain) : H)
      = (Complex.I / (l : ℂ)) • (x : H) + (1 / (l : ℂ) ^ 2) • T.op x
        - (1 / (l : ℂ) ^ 2) • ((T.res l (T.op ⟨T.op x, hx⟩) : T.domain) : H) := by
  have hlC : ((l : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hl
  set x2 : T.domain := ⟨T.op x, hx⟩ with hx2
  set r : T.domain := T.res l (T.op x2) with hr
  set c : T.domain :=
    (Complex.I / (l : ℂ)) • x + (1 / (l : ℂ) ^ 2) • x2 - (1 / (l : ℂ) ^ 2) • r with hc
  have hopr : T.op r = T.op x2 + ((l : ℂ) * Complex.I) • (r : H) := T.op_res hl (T.op x2)
  have hopc : T.op c = (Complex.I / (l : ℂ)) • T.op x + (1 / (l : ℂ) ^ 2) • T.op x2
      - (1 / (l : ℂ) ^ 2) • T.op r := by
    rw [hc, map_sub, map_add, map_smul, map_smul, map_smul]
  have hcoe : (c : H) = (Complex.I / (l : ℂ)) • (x : H) + (1 / (l : ℂ) ^ 2) • (x2 : H)
      - (1 / (l : ℂ) ^ 2) • (r : H) := by
    rw [hc]; rfl
  have hx2coe : (x2 : H) = T.op x := rfl
  have hshift : T.shift l c = (x : H) := by
    rw [UnboundedSelfAdjoint.shift_apply, hopc, hopr, hcoe, hx2coe]
    match_scalars
    all_goals field_simp
    all_goals ring_nf
    all_goals simp [Complex.I_sq]
  have hres : T.res l (x : H) = c := by
    rw [← hshift, T.res_shift hl]
  rw [hres, hcoe, hx2coe]

/-- **Consistency of the Crank–Nicolson step**: on the domain of `A²`,
`C(τ)x = x − iτ A x + iτ (A − i(2/τ))⁻¹ A²x`. -/
theorem cnStep_second_order {tau : ℝ} (htau : tau ≠ 0) (x : T.domain) (hx : T.op x ∈ T.domain) :
    cnStep T tau (x : H)
      = (x : H) - ((tau : ℂ) * Complex.I) • T.op x
        + ((tau : ℂ) * Complex.I)
            • ((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H) := by
  have hl : (2 / tau : ℝ) ≠ 0 := two_div_ne_zero htau
  have hlC : ((2 / tau : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hl
  have htauC : ((tau : ℝ) : ℂ) ≠ 0 := by exact_mod_cast htau
  rw [cnStep_apply, res_second_order T hl x hx]
  push_cast
  match_scalars
  all_goals field_simp
  all_goals ring_nf
  all_goals simp [Complex.I_sq]
  all_goals ring

/-- The consistency estimate: the Crank–Nicolson step agrees with the first-order Taylor
polynomial of the flow up to `(τ²/2)‖A²x‖`. -/
theorem norm_cnStep_sub_taylor_le {tau : ℝ} (htau : 0 < tau) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖cnStep T tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)‖
      ≤ tau ^ 2 / 2 * ‖T.op ⟨T.op x, hx⟩‖ := by
  have hl : (2 / tau : ℝ) ≠ 0 := two_div_ne_zero (ne_of_gt htau)
  have hrb := T.norm_res_le (2 / tau) (T.op ⟨T.op x, hx⟩)
  have habs : |2 / tau| = 2 / tau := abs_of_pos (by positivity)
  rw [cnStep_second_order T (ne_of_gt htau) x hx]
  have heq : (x : H) - ((tau : ℂ) * Complex.I) • T.op x
        + ((tau : ℂ) * Complex.I) • ((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H)
      - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)
      = ((tau : ℂ) * Complex.I) • ((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H) := by
    abel
  rw [heq, norm_smul]
  have hns : ‖((tau : ℝ) : ℂ) * Complex.I‖ = tau := by
    simp [abs_of_pos htau]
  rw [hns]
  rw [habs] at hrb
  have h2 : ‖((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H)‖
      ≤ 1 / (2 / tau) * ‖T.op ⟨T.op x, hx⟩‖ := hrb
  have hpos : (0 : ℝ) < 2 / tau := by positivity
  have hkey : 1 / (2 / tau) = tau / 2 := by field_simp
  rw [hkey] at h2
  calc tau * ‖((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H)‖
      ≤ tau * (tau / 2 * ‖T.op ⟨T.op x, hx⟩‖) := by
        exact mul_le_mul_of_nonneg_left h2 (le_of_lt htau)
    _ = tau ^ 2 / 2 * ‖T.op ⟨T.op x, hx⟩‖ := by ring

/-! ## 3. The second-order Taylor estimate for the exact flow -/

/-- `‖e^{−iτA}x − (x − iτAx)‖ ≤ τ²‖A²x‖` for `x` in the domain of `A²`. -/
theorem norm_stoneU_sub_taylor_le {tau : ℝ} (htau : 0 ≤ tau) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖T.stoneU tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)‖
      ≤ tau ^ 2 * ‖T.op ⟨T.op x, hx⟩‖ := by
  set x2 : T.domain := ⟨T.op x, hx⟩ with hx2
  set C : ℝ := tau * ‖T.op x2‖ with hC
  set f : ℝ → H := fun s => T.stoneU s (x : H) - ((x : H) - ((s : ℂ) * Complex.I) • T.op x)
    with hf
  have hderiv : ∀ s : ℝ, HasDerivAt f
      (T.stoneU s ((-Complex.I) • T.op x) + Complex.I • T.op x) s := by
    intro s
    have h1 : HasDerivAt (fun s : ℝ => T.stoneU s (x : H))
        (T.stoneU s ((-Complex.I) • T.op x)) s := T.hasDerivAt_stoneU x s
    have h2 : HasDerivAt (fun s : ℝ => ((s : ℂ) * Complex.I) • T.op x)
        (Complex.I • T.op x) s := by
      have hc : HasDerivAt (fun s : ℝ => ((s : ℂ) * Complex.I)) Complex.I s := by
        simpa using (Complex.ofRealCLM.hasDerivAt (x := s)).mul_const Complex.I
      simpa using hc.smul_const (T.op x)
    have h3 : HasDerivAt (fun s : ℝ => (x : H) - ((s : ℂ) * Complex.I) • T.op x)
        (-(Complex.I • T.op x)) s := by
      simpa using (hasDerivAt_const s (x : H)).sub h2
    simpa [hf, sub_neg_eq_add] using h1.sub h3
  have hbound : ∀ s ∈ Set.Ico (0 : ℝ) tau,
      ‖T.stoneU s ((-Complex.I) • T.op x) + Complex.I • T.op x‖ ≤ C := by
    intro s hs
    have hsplit : T.stoneU s ((-Complex.I) • T.op x) + Complex.I • T.op x
        = (-Complex.I) • (T.stoneU s (T.op x) - T.op x) := by
      rw [map_smul]
      module
    rw [hsplit, norm_smul]
    have h1 : ‖T.stoneU s ((x2 : H)) - ((x2 : H))‖ ≤ |s| * ‖T.op x2‖ :=
      T.norm_stoneU_sub_domain s x2
    have hs' : |s| ≤ tau := by
      rw [abs_of_nonneg hs.1]; exact le_of_lt hs.2
    have : ‖T.stoneU s (T.op x) - T.op x‖ ≤ tau * ‖T.op x2‖ := by
      have hxx : ((x2 : H)) = T.op x := rfl
      rw [hxx] at h1
      exact le_trans h1 (mul_le_mul_of_nonneg_right hs' (norm_nonneg _))
    simpa using this
  have hzero : f 0 = 0 := by
    have h0 : T.stoneU 0 ((x : H)) = (x : H) := by
      rw [T.stoneU_zero]; simp
    have hval : f 0
        = T.stoneU 0 (x : H) - ((x : H) - (((0 : ℝ) : ℂ) * Complex.I) • T.op x) := rfl
    rw [hval, h0]
    simp
  have hmain : ‖f tau - f 0‖ ≤ C * (tau - 0) := by
    refine norm_image_sub_le_of_norm_deriv_le_segment' (f := f)
      (f' := fun s => T.stoneU s ((-Complex.I) • T.op x) + Complex.I • T.op x)
      (fun s hs => (hderiv s).hasDerivWithinAt) hbound tau (Set.right_mem_Icc.mpr htau)
  rw [hzero, sub_zero] at hmain
  calc ‖f tau‖ ≤ C * (tau - 0) := hmain
    _ = tau ^ 2 * ‖T.op x2‖ := by rw [hC]; ring

/-! ## 4. The local and the global error of the scheme -/

/-- **The local error of the Crank–Nicolson step**: `‖C(τ)x − e^{−iτA}x‖ ≤ 2τ²‖A²x‖`. -/
theorem norm_cnStep_sub_stoneU_le {tau : ℝ} (htau : 0 < tau) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖cnStep T tau (x : H) - T.stoneU tau (x : H)‖ ≤ 2 * tau ^ 2 * ‖T.op ⟨T.op x, hx⟩‖ := by
  have h1 := norm_cnStep_sub_taylor_le T htau x hx
  have h2 := norm_stoneU_sub_taylor_le T (le_of_lt htau) x hx
  have hsplit : cnStep T tau (x : H) - T.stoneU tau (x : H)
      = (cnStep T tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x))
        - (T.stoneU tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)) := by
    abel
  rw [hsplit]
  have := norm_sub_le (cnStep T tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x))
    (T.stoneU tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x))
  have hnn : (0 : ℝ) ≤ ‖T.op ⟨T.op x, hx⟩‖ := norm_nonneg _
  nlinarith

/-- The orbit of a vector in the domain of `A²` stays in the domain of `A²`. -/
theorem stoneU_mem_domain_two (t : ℝ) (x : T.domain) (hx : T.op x ∈ T.domain) :
    T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩ ∈ T.domain := by
  rw [T.stoneU_op t x]
  exact T.stoneU_mem_domain t ⟨T.op x, hx⟩

/-- ... with the same `‖A²·‖`, because the flow is unitary and commutes with `A`. -/
theorem norm_op_two_stoneU (t : ℝ) (x : T.domain) (hx : T.op x ∈ T.domain) :
    ‖T.op ⟨T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩,
        stoneU_mem_domain_two T t x hx⟩‖
      = ‖T.op ⟨T.op x, hx⟩‖ := by
  set x2 : T.domain := ⟨T.op x, hx⟩ with hx2
  have h1 : (⟨T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩,
      stoneU_mem_domain_two T t x hx⟩ : T.domain)
      = ⟨T.stoneU t ((x2 : H)), T.stoneU_mem_domain t x2⟩ := by
    apply Subtype.ext
    change T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩ = T.stoneU t ((x2 : H))
    rw [T.stoneU_op t x]
  rw [h1, T.stoneU_op t x2, T.norm_stoneU_apply]

/-- **The global error of the scheme after `k` steps**: `‖C(τ)^k x − e^{−ikτA}x‖ ≤
2kτ²‖A²x‖`.  Each step is unitary, so the errors merely add up. -/
theorem norm_iterate_cnStep_sub_stoneU_le {tau : ℝ} (htau : 0 < tau) (k : ℕ) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖(cnStep T tau)^[k] (x : H) - T.stoneU ((k : ℝ) * tau) (x : H)‖
      ≤ 2 * (k : ℝ) * tau ^ 2 * ‖T.op ⟨T.op x, hx⟩‖ := by
  induction k with
  | zero => simp
  | succ k ih =>
      set x2 : T.domain := ⟨T.op x, hx⟩ with hx2
      set y : T.domain := ⟨T.stoneU ((k : ℝ) * tau) (x : H),
        T.stoneU_mem_domain ((k : ℝ) * tau) x⟩ with hy
      have hymem : T.op y ∈ T.domain := stoneU_mem_domain_two T ((k : ℝ) * tau) x hx
      have hynorm : ‖T.op ⟨T.op y, hymem⟩‖ = ‖T.op x2‖ :=
        norm_op_two_stoneU T ((k : ℝ) * tau) x hx
      have hstep1 : ‖cnStep T tau ((cnStep T tau)^[k] (x : H)) - cnStep T tau ((y : H))‖
          ≤ 2 * (k : ℝ) * tau ^ 2 * ‖T.op x2‖ := by
        rw [← map_sub, norm_cnStep_apply T (ne_of_gt htau)]
        exact ih
      have hstep2 : ‖cnStep T tau ((y : H)) - T.stoneU tau ((y : H))‖
          ≤ 2 * tau ^ 2 * ‖T.op x2‖ := by
        have := norm_cnStep_sub_stoneU_le T htau y hymem
        rwa [hynorm] at this
      have hflow : T.stoneU tau ((y : H)) = T.stoneU (((k : ℝ) + 1) * tau) (x : H) := by
        change T.stoneU tau (T.stoneU ((k : ℝ) * tau) (x : H)) = _
        rw [T.stoneU_apply_stoneU]
        ring_nf
      have hsplit : (cnStep T tau)^[k + 1] (x : H)
            - T.stoneU (((k : ℕ) + 1 : ℝ) * tau) (x : H)
          = (cnStep T tau ((cnStep T tau)^[k] (x : H)) - cnStep T tau ((y : H)))
            + (cnStep T tau ((y : H)) - T.stoneU tau ((y : H))) := by
        rw [Function.iterate_succ_apply', hflow]
        abel
      have hcast : ((k + 1 : ℕ) : ℝ) = (k : ℝ) + 1 := by push_cast; ring
      rw [hcast, hsplit]
      have := norm_add_le (cnStep T tau ((cnStep T tau)^[k] (x : H)) - cnStep T tau ((y : H)))
        (cnStep T tau ((y : H)) - T.stoneU tau ((y : H)))
      have hnn : (0 : ℝ) ≤ ‖T.op x2‖ := norm_nonneg _
      nlinarith

/-! ## 5. Convergence of the scheme for every initial vector -/

/-- Vectors in the domain of `A²` are dense. -/
theorem exists_domain_two_approx (v : H) {eps : ℝ} (heps : 0 < eps) :
    ∃ x : T.domain, T.op x ∈ T.domain ∧ ‖v - (x : H)‖ < eps := by
  obtain ⟨w, hw⟩ := exists_res_domain_approx T v heps
  refine ⟨T.res 1 (w : H), ?_, hw⟩
  have h := T.op_res (l := 1) one_ne_zero (w : H)
  rw [h]
  exact T.domain.add_mem w.2 (T.domain.smul_mem _ (T.res 1 (w : H)).2)

/-- **Convergence of the Crank–Nicolson scheme.**  For every vector `v` — no smoothness
assumed — and every time `t > 0`, the `k`-fold Crank–Nicolson iterate with step `t/k`
converges to `e^{−itA}v`. -/
theorem tendsto_iterate_cnStep {t : ℝ} (ht : 0 < t) (v : H) :
    Tendsto (fun k : ℕ => (cnStep T (t / (k + 1)))^[k + 1] v) atTop
      (𝓝 (T.stoneU t v)) := by
  rw [Metric.tendsto_atTop]
  intro eps heps
  obtain ⟨x, hx, hvx⟩ := exists_domain_two_approx T v (eps := eps / 4) (by linarith)
  set Mv : ℝ := ‖T.op ⟨T.op x, hx⟩‖ with hMv
  have hMv0 : 0 ≤ Mv := norm_nonneg _
  obtain ⟨N, hN⟩ := exists_nat_gt (8 * t ^ 2 * Mv / eps)
  refine ⟨N, fun k hk => ?_⟩
  set tau : ℝ := t / ((k : ℝ) + 1) with htau
  have hk1 : (0 : ℝ) < (k : ℝ) + 1 := by positivity
  have htaupos : 0 < tau := by positivity
  have hkt : ((k : ℕ) + 1 : ℝ) * tau = t := by
    rw [htau]
    field_simp
  have hglob := norm_iterate_cnStep_sub_stoneU_le T htaupos (k + 1) x hx
  have hcast : (((k + 1 : ℕ)) : ℝ) = (k : ℝ) + 1 := by push_cast; ring
  rw [hcast, hkt] at hglob
  have hbnd : 2 * ((k : ℝ) + 1) * tau ^ 2 * Mv = 2 * t ^ 2 * Mv / ((k : ℝ) + 1) := by
    rw [htau, div_pow]
    field_simp
  rw [hbnd] at hglob
  have hsmall : 2 * t ^ 2 * Mv / ((k : ℝ) + 1) < eps / 2 := by
    have hNk : (N : ℝ) ≤ (k : ℝ) := Nat.cast_le.mpr hk
    have h1 : 8 * t ^ 2 * Mv / eps < (k : ℝ) + 1 := by linarith
    have h2 : 8 * t ^ 2 * Mv < ((k : ℝ) + 1) * eps := by
      rw [div_lt_iff₀ heps] at h1
      linarith
    rw [div_lt_iff₀ hk1]
    nlinarith
  have h1 : ‖(cnStep T tau)^[k + 1] v - (cnStep T tau)^[k + 1] (x : H)‖ < eps / 4 := by
    rw [iterate_cnStep_sub T tau, norm_iterate_cnStep_apply T (ne_of_gt htaupos)]
    exact hvx
  have h3 : ‖T.stoneU t (x : H) - T.stoneU t v‖ < eps / 4 := by
    rw [← map_sub, T.norm_stoneU_apply, norm_sub_rev]
    exact hvx
  have hsplit : (cnStep T tau)^[k + 1] v - T.stoneU t v
      = ((cnStep T tau)^[k + 1] v - (cnStep T tau)^[k + 1] (x : H))
        + ((cnStep T tau)^[k + 1] (x : H) - T.stoneU t (x : H))
        + (T.stoneU t (x : H) - T.stoneU t v) := by
    abel
  have htri := norm_add_le
    (((cnStep T tau)^[k + 1] v - (cnStep T tau)^[k + 1] (x : H))
      + ((cnStep T tau)^[k + 1] (x : H) - T.stoneU t (x : H)))
    (T.stoneU t (x : H) - T.stoneU t v)
  have htri2 := norm_add_le ((cnStep T tau)^[k + 1] v - (cnStep T tau)^[k + 1] (x : H))
    ((cnStep T tau)^[k + 1] (x : H) - T.stoneU t (x : H))
  rw [dist_eq_norm, hsplit]
  linarith

/-! ## 6. The fully discrete quantum-gravity evolution -/

variable {ι : Type*}

/-- **The fully discrete quantum-gravity scheme converges.**  Both halves of *this* concrete
scheme are analysed: the mode cutoff in space and the Crank–Nicolson (Cayley) step in time.
The time-stepping half is an option, not a requirement: for the SIRK/Hashimoto algorithm the
propagator at one finite time is produced directly from shift-invert solves, and the
corresponding statement, free of any time discretization, is
`BookProof.SirkSingleTime.qgOuterFock_singleTime_shiftInvert_convergence`.

For every family of mode windows exhausting the modes there are self-adjoint
realizations `S n` of the truncated Hamiltonians and `T` of the exact one, and for every
initial vector `v` and every time `t > 0` a number of time steps `k n` per cutoff, such that
the fully discrete unitary evolution — `k n` Crank–Nicolson steps of size `t / k n` for the
`n`-th mode cutoff — converges to the exact quantum-gravity flow `e^{−itH}v`. -/
theorem qgOuterFock_fullyDiscrete_convergence (W : WallPot) (Q : QgModeData ι) (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        ∀ (v : Sec ι) (t : ℝ), 0 < t →
          ∃ k : ℕ → ℕ, (∀ n, 0 < k n) ∧
            Tendsto (fun n => (cnStep (S n) (t / (k n)))^[k n] v) atTop
              (𝓝 (T.stoneU t v)) := by
  obtain ⟨T, S, hT, hS, -, hflow⟩ := qgOuterFock_truncation_flow_convergence W Q Λ hexh
  refine ⟨T, S, hT, hS, fun v t ht => ?_⟩
  have hSn : ∀ n : ℕ, ∃ m : ℕ, ‖(cnStep (S n) (t / ((m : ℝ) + 1)))^[m + 1] v
      - (S n).stoneU t v‖ < 1 / ((n : ℝ) + 1) := by
    intro n
    have h := tendsto_iterate_cnStep (S n) ht v
    rw [Metric.tendsto_atTop] at h
    obtain ⟨N, hN⟩ := h (1 / ((n : ℝ) + 1)) (by positivity)
    exact ⟨N, by simpa [dist_eq_norm] using hN N le_rfl⟩
  choose m hm using hSn
  refine ⟨fun n => m n + 1, fun n => Nat.succ_pos _, ?_⟩
  have hcast : ∀ n : ℕ, (t / ((m n + 1 : ℕ) : ℝ)) = t / ((m n : ℝ) + 1) := by
    intro n; push_cast; ring_nf
  rw [Metric.tendsto_atTop]
  intro eps heps
  have hexact : Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
    (hflow v t (le_of_lt ht)).2 t
  rw [Metric.tendsto_atTop] at hexact
  obtain ⟨N1, hN1⟩ := hexact (eps / 2) (by linarith)
  obtain ⟨N2, hN2⟩ := exists_nat_gt (2 / eps)
  refine ⟨max N1 N2, fun n hn => ?_⟩
  have hn1 : N1 ≤ n := le_trans (le_max_left _ _) hn
  have hn2 : N2 ≤ n := le_trans (le_max_right _ _) hn
  have hA : ‖(cnStep (S n) (t / ((m n + 1 : ℕ) : ℝ)))^[m n + 1] v - (S n).stoneU t v‖
      < 1 / ((n : ℝ) + 1) := by
    rw [hcast n]; exact hm n
  have hB : ‖(S n).stoneU t v - T.stoneU t v‖ < eps / 2 := by
    have := hN1 n hn1
    rwa [dist_eq_norm] at this
  have hC : 1 / ((n : ℝ) + 1) < eps / 2 := by
    have hNn : (N2 : ℝ) ≤ (n : ℝ) := Nat.cast_le.mpr hn2
    have h1 : 2 / eps < (n : ℝ) + 1 := by linarith
    rw [div_lt_iff₀ (by positivity : (0:ℝ) < (n : ℝ) + 1)]
    rw [div_lt_iff₀ heps] at h1
    linarith
  have hsplit : (cnStep (S n) (t / ((m n + 1 : ℕ) : ℝ)))^[m n + 1] v - T.stoneU t v
      = ((cnStep (S n) (t / ((m n + 1 : ℕ) : ℝ)))^[m n + 1] v - (S n).stoneU t v)
        + ((S n).stoneU t v - T.stoneU t v) := by
    abel
  have htri := norm_add_le
    ((cnStep (S n) (t / ((m n + 1 : ℕ) : ℝ)))^[m n + 1] v - (S n).stoneU t v)
    ((S n).stoneU t v - T.stoneU t v)
  rw [dist_eq_norm, hsplit]
  linarith

end

end BookProof.QgTimeStepping
