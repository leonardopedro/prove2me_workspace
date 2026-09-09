import Mathlib
import BookProof.ChapterSirkEndToEnd
import BookProof.ChapterQgTruncationResolvent
import BookProof.ChapterQgManifoldModeInstance

/-!
# One shift, one finite time: the SIRK/Hashimoto algorithm needs no time discretization

The shift-invert rational Krylov (SIRK/Hashimoto) algorithm evaluates the propagator at a
**single finite time** `t`: it builds a rational approximant of `e^{−itA}` whose poles are
the *shifts*, and the only operator it ever applies is the **bounded** shift-invert
resolvent `(A − iℓ)⁻¹`.  There is therefore

* no time discretization (no step size, no number of steps, no Trotter splitting), and
* no boundedness requirement on the Hamiltonian: `‖(A − iℓ)⁻¹‖ ≤ 1/|ℓ|` holds for every
  self-adjoint `A`, however unbounded.

`BookProof.ChapterQgTimeStepping` analyses a time-stepping scheme (Crank–Nicolson) as *one
possible* way of producing the propagator.  This module records that time stepping is an
option, not a requirement, and supplies the statements the algorithm actually uses.

## What is proved

* `res_sub_res` — the first resolvent identity
  `(A − iℓ)⁻¹ − (A − im)⁻¹ = i(ℓ − m)(A − iℓ)⁻¹(A − im)⁻¹` for the project's
  `UnboundedSelfAdjoint` interface.
* `norm_res_neg` — `‖(A + iℓ)⁻¹y‖ = ‖(A − iℓ)⁻¹y‖`: the resolvent is normal, proved from
  the adjoint relation and the commutation of resolvents, with no spectral theorem.
* `StrongResAt T S ℓ` — strong convergence of the shift-invert operators at the **single**
  shift `ℓ`.
* `strongResAt_of_abs_sub_lt` — a Neumann/resolvent-identity step: convergence at `ℓ`
  gives convergence at every `m` with `|m − ℓ| < |ℓ|`.
* `strongResAt_neg`, `strongResAt_of_pos_of_pos`, **`strongResAt_of_ne_zero`** — hence
  convergence at *one* nonzero shift already gives convergence at *every* nonzero shift:
  the algorithm's choice of shift is immaterial.
* **`singleTime_flow_tendsto_of_strongResAt`** — and therefore, by Trotter–Kato, the
  approximants' propagators converge at **every single finite time** `t`, with no time
  discretization and no boundedness assumption anywhere.
* `isShiftInvertC_neg_resCLM_shift` — the Hashimoto shift-invert operator at the complex
  shift `γ = iℓ` is `−(A − iℓ)⁻¹` for every real `ℓ ≠ 0` (the case `ℓ = 1` is
  `BookProof.QgTruncationResolvent.isShiftInvertC_neg_resCLM`).
* **`sirk_single_time_shiftInvert_bound`** — the end-to-end SIRK bound applied at one
  finite time: with `X = (A − iℓ)⁻¹` the bounded operator the algorithm iterates, the
  Krylov reduction approximates `e^{−itA}v` itself, at that single `t`; there is no time
  step anywhere in the statement.
* **`qgOuterFock_singleTime_shiftInvert_convergence`**,
  **`starobinsky_qgContinuum_singleTime_shiftInvert_convergence`** and
  **`starobinsky_qgManifold_singleTime_shiftInvert_convergence`** — the quantum-gravity
  instance: the mode-truncated Hamiltonians' shift-invert operators converge at *every*
  nonzero shift, and their propagators converge to the exact one at *every single finite
  time*.  This replaces the "choose a number of time steps per cutoff" formulation of
  `BookProof.ChapterQgTimeStepping.qgOuterFock_fullyDiscrete_convergence`.

Everything is `sorry`-free and `axiom`-free.
-/

open scoped InnerProductSpace

namespace BookProof.SirkSingleTime

open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-! ## 1. The resolvent identity and normality of the resolvent -/

/-- **The first resolvent identity**
`(A − iℓ)⁻¹y − (A − im)⁻¹y = i(ℓ − m) (A − iℓ)⁻¹((A − im)⁻¹y)`. -/
theorem res_sub_res (T : UnboundedSelfAdjoint E) {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0) (y : E) :
    ((T.res l y : T.domain) : E) - ((T.res m y : T.domain) : E)
      = (((l - m : ℝ) : ℂ) * Complex.I) •
          ((T.res l ((T.res m y : T.domain) : E) : T.domain) : E) := by
  set x : T.domain := T.res m y with hx
  set u : T.domain := T.res l y with hu
  set w : T.domain := T.res l ((x : T.domain) : E) with hw
  have hux : T.shift l u = y := T.shift_res hl y
  have hwx : T.shift l w = ((x : T.domain) : E) := T.shift_res hl ((x : T.domain) : E)
  have hAx : T.op x = y + ((m : ℂ) * Complex.I) • ((x : T.domain) : E) := T.op_res hm y
  have hkey : T.shift l (u - x - ((((l - m : ℝ)) : ℂ) * Complex.I) • w) = 0 := by
    rw [map_sub, map_sub, map_smul, hux, hwx, UnboundedSelfAdjoint.shift_apply, hAx]
    push_cast
    module
  have hz : u - x - ((((l - m : ℝ)) : ℂ) * Complex.I) • w = 0 :=
    T.shift_injective hl (by rw [hkey, map_zero])
  have h' : (((u : T.domain) : E) - ((x : T.domain) : E))
      - ((((l - m : ℝ)) : ℂ) * Complex.I) • ((w : T.domain) : E) = 0 := by
    simpa using congrArg (fun z : T.domain => (z : E)) hz
  exact sub_eq_zero.mp h'

/-- The resolvent at the conjugate shift has the same norm on every vector: the resolvent of
a self-adjoint operator is **normal**.  Proved from the adjoint relation `inner_res` and the
commutation `res_comm`, with no spectral theorem. -/
theorem norm_res_neg (T : UnboundedSelfAdjoint E) {l : ℝ} (hl : l ≠ 0) (y : E) :
    ‖((T.res (-l) y : T.domain) : E)‖ = ‖((T.res l y : T.domain) : E)‖ := by
  have hl' : -l ≠ 0 := neg_ne_zero.mpr hl
  have h1 : ⟪((T.res l y : T.domain) : E), ((T.res l y : T.domain) : E)⟫_ℂ
      = ⟪y, ((T.res (-l) (((T.res l y : T.domain) : E)) : T.domain) : E)⟫_ℂ :=
    T.inner_res hl y ((T.res l y : T.domain) : E)
  have h2 : ⟪((T.res (-l) y : T.domain) : E), ((T.res (-l) y : T.domain) : E)⟫_ℂ
      = ⟪y, ((T.res l (((T.res (-l) y : T.domain) : E)) : T.domain) : E)⟫_ℂ := by
    simpa using T.inner_res hl' y ((T.res (-l) y : T.domain) : E)
  have hcomm : ((T.res (-l) (((T.res l y : T.domain) : E)) : T.domain) : E)
      = ((T.res l (((T.res (-l) y : T.domain) : E)) : T.domain) : E) := T.res_comm hl' hl y
  have heq : ⟪((T.res (-l) y : T.domain) : E), ((T.res (-l) y : T.domain) : E)⟫_ℂ
      = ⟪((T.res l y : T.domain) : E), ((T.res l y : T.domain) : E)⟫_ℂ := by
    rw [h2, h1, hcomm]
  rw [inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K] at heq
  have hre : ‖((T.res (-l) y : T.domain) : E)‖ ^ 2 = ‖((T.res l y : T.domain) : E)‖ ^ 2 := by
    exact_mod_cast heq
  rw [← Real.sqrt_sq (norm_nonneg (((T.res (-l) y : T.domain) : E))),
    ← Real.sqrt_sq (norm_nonneg (((T.res l y : T.domain) : E))), hre]

/-! ## 2. Strong convergence at one shift gives strong convergence at every shift -/

/-- Strong convergence of the shift-invert operators at the single shift `ℓ`. -/
def StrongResAt (T : UnboundedSelfAdjoint E) (S : ℕ → UnboundedSelfAdjoint E) (l : ℝ) : Prop :=
  ∀ y : E, Tendsto (fun n => (S n).resCLM l y) atTop (𝓝 (T.resCLM l y))

variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}

/-- **One resolvent-identity step.**  If the shift-invert operators converge at `ℓ`, they
converge at every shift `m` with `|m − ℓ| < |ℓ|`. -/
theorem strongResAt_of_abs_sub_lt {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0)
    (hlt : |m - l| < |l|) (h : StrongResAt T S l) : StrongResAt T S m := by
  intro y
  have hlabs : 0 < |l| := abs_pos.mpr hl
  set c : ℂ := ((m - l : ℝ) : ℂ) * Complex.I with hc
  have hcabs : ‖c‖ = |m - l| := by
    rw [hc, norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]
  have hid : ∀ (A : UnboundedSelfAdjoint E) (z : E),
      A.resCLM m z = A.resCLM l z + c • A.resCLM l (A.resCLM m z) := by
    intro A z
    have key := res_sub_res A hl hm z
    have hcc : (((l - m : ℝ)) : ℂ) * Complex.I = -c := by rw [hc]; push_cast; ring
    rw [hcc, neg_smul] at key
    have h3 : c • ((A.res l (((A.res m z : A.domain) : E)) : A.domain) : E)
        = -(((A.res l z : A.domain) : E) - ((A.res m z : A.domain) : E)) := by
      rw [key, neg_neg]
    simp only [UnboundedSelfAdjoint.resCLM_apply]
    rw [h3]
    abel
  have hdiff : ∀ n, (S n).resCLM m y - T.resCLM m y
      = ((S n).resCLM l y - T.resCLM l y)
        + (c • ((S n).resCLM l ((S n).resCLM m y - T.resCLM m y))
          + c • ((S n).resCLM l (T.resCLM m y) - T.resCLM l (T.resCLM m y))) := by
    intro n
    have e1 := hid (S n) y
    have e2 := hid T y
    have e3 : (S n).resCLM l ((S n).resCLM m y - T.resCLM m y)
        = (S n).resCLM l ((S n).resCLM m y) - (S n).resCLM l (T.resCLM m y) := map_sub _ _ _
    rw [e3]
    linear_combination (norm := module) e1 - e2
  have hstep : ∀ n, ‖(S n).resCLM m y - T.resCLM m y‖ * (1 - |m - l| / |l|)
      ≤ ‖(S n).resCLM l y - T.resCLM l y‖
        + |m - l| * ‖(S n).resCLM l (T.resCLM m y) - T.resCLM l (T.resCLM m y)‖ := by
    intro n
    have h1 : ‖c • ((S n).resCLM l ((S n).resCLM m y - T.resCLM m y))‖
        ≤ |m - l| * ((1 / |l|) * ‖(S n).resCLM m y - T.resCLM m y‖) := by
      rw [norm_smul, hcabs]
      have := (S n).norm_resCLM_apply_le l ((S n).resCLM m y - T.resCLM m y)
      have habs : (0:ℝ) ≤ |m - l| := abs_nonneg _
      exact mul_le_mul_of_nonneg_left this habs
    have h2 : ‖c • ((S n).resCLM l (T.resCLM m y) - T.resCLM l (T.resCLM m y))‖
        = |m - l| * ‖(S n).resCLM l (T.resCLM m y) - T.resCLM l (T.resCLM m y)‖ := by
      rw [norm_smul, hcabs]
    have hA := norm_add_le ((S n).resCLM l y - T.resCLM l y)
      (c • ((S n).resCLM l ((S n).resCLM m y - T.resCLM m y))
        + c • ((S n).resCLM l (T.resCLM m y) - T.resCLM l (T.resCLM m y)))
    have hB := norm_add_le (c • ((S n).resCLM l ((S n).resCLM m y - T.resCLM m y)))
      (c • ((S n).resCLM l (T.resCLM m y) - T.resCLM l (T.resCLM m y)))
    rw [← hdiff n] at hA
    have hprod : |m - l| * ((1 / |l|) * ‖(S n).resCLM m y - T.resCLM m y‖)
        = (|m - l| / |l|) * ‖(S n).resCLM m y - T.resCLM m y‖ := by
      field_simp
    nlinarith [hA, hB, h1, h2, hprod]
  have ha : Tendsto (fun n => ‖(S n).resCLM l y - T.resCLM l y‖) atTop (𝓝 0) :=
    tendsto_iff_norm_sub_tendsto_zero.mp (h y)
  have hb : Tendsto
      (fun n => ‖(S n).resCLM l (T.resCLM m y) - T.resCLM l (T.resCLM m y)‖) atTop (𝓝 0) :=
    tendsto_iff_norm_sub_tendsto_zero.mp (h (T.resCLM m y))
  have hk1 : 0 < 1 - |m - l| / |l| := by
    have : |m - l| / |l| < 1 := (div_lt_one hlabs).mpr hlt
    linarith
  have hlim : Tendsto (fun n => (‖(S n).resCLM l y - T.resCLM l y‖
      + |m - l| * ‖(S n).resCLM l (T.resCLM m y) - T.resCLM l (T.resCLM m y)‖)
      / (1 - |m - l| / |l|)) atTop (𝓝 0) := by
    have := (ha.add (hb.const_mul |m - l|)).div_const (1 - |m - l| / |l|)
    simpa using this
  rw [tendsto_iff_norm_sub_tendsto_zero]
  refine squeeze_zero (fun n => norm_nonneg _) (fun n => ?_) hlim
  rw [le_div_iff₀ hk1]
  exact hstep n

/-- **Flipping the sign of the shift.**  Convergence at `ℓ` implies convergence at `−ℓ`:
the operators are adjoint to one another, which gives weak convergence, and normality
(`norm_res_neg`) gives convergence of the norms. -/
theorem strongResAt_neg {l : ℝ} (hl : l ≠ 0) (h : StrongResAt T S l) :
    StrongResAt T S (-l) := by
  intro y
  have hl' : -l ≠ 0 := neg_ne_zero.mpr hl
  set x : E := T.resCLM (-l) y with hx
  have hnorm : Tendsto (fun n => ‖(S n).resCLM (-l) y‖) atTop (𝓝 ‖x‖) := by
    have heq : ∀ n, ‖(S n).resCLM (-l) y‖ = ‖(S n).resCLM l y‖ := by
      intro n; simpa using norm_res_neg (S n) hl y
    have hxx : ‖x‖ = ‖T.resCLM l y‖ := by simpa [hx] using norm_res_neg T hl y
    simp only [heq, hxx]
    exact (h y).norm
  have hinner : Tendsto (fun n => (⟪(S n).resCLM (-l) y, x⟫_ℂ : ℂ)) atTop (𝓝 (⟪x, x⟫_ℂ : ℂ)) := by
    have heq : ∀ n, (⟪(S n).resCLM (-l) y, x⟫_ℂ : ℂ) = ⟪y, (S n).resCLM l x⟫_ℂ := by
      intro n; simpa using (S n).inner_res hl' y x
    have hxx : (⟪x, x⟫_ℂ : ℂ) = ⟪y, T.resCLM l x⟫_ℂ := by
      simpa [hx] using T.inner_res hl' y x
    simp only [heq, hxx]
    exact Filter.Tendsto.inner tendsto_const_nhds (h x)
  have hsq : Tendsto (fun n => ‖(S n).resCLM (-l) y - x‖ ^ 2) atTop (𝓝 0) := by
    have hexp : ∀ n, ‖(S n).resCLM (-l) y - x‖ ^ 2
        = ‖(S n).resCLM (-l) y‖ ^ 2 - 2 * (⟪(S n).resCLM (-l) y, x⟫_ℂ : ℂ).re + ‖x‖ ^ 2 := by
      intro n; exact norm_sub_sq (𝕜 := ℂ) _ _
    simp only [hexp]
    have h1 : Tendsto (fun n => ‖(S n).resCLM (-l) y‖ ^ 2) atTop (𝓝 (‖x‖ ^ 2)) := hnorm.pow 2
    have h2 : Tendsto (fun n => ((⟪(S n).resCLM (-l) y, x⟫_ℂ : ℂ).re)) atTop (𝓝 (‖x‖ ^ 2)) := by
      have hre := (Complex.continuous_re.tendsto _).comp hinner
      simp only [Function.comp_def] at hre
      have hxx : ((⟪x, x⟫_ℂ : ℂ)).re = ‖x‖ ^ 2 := by
        rw [inner_self_eq_norm_sq_to_K]
        simp [← Complex.ofReal_pow]
      rwa [hxx] at hre
    have hcomb := (h1.sub (h2.const_mul 2)).add (tendsto_const_nhds (x := ‖x‖ ^ 2))
    have : ‖x‖ ^ 2 - 2 * ‖x‖ ^ 2 + ‖x‖ ^ 2 = 0 := by ring
    rw [this] at hcomb
    exact hcomb
  have hroot := (Real.continuous_sqrt.tendsto 0).comp hsq
  simp only [Function.comp_def] at hroot
  rw [tendsto_iff_norm_sub_tendsto_zero]
  simpa [Real.sqrt_sq_eq_abs, abs_norm] using hroot

/-- Convergence at a positive shift propagates to every positive shift. -/
theorem strongResAt_of_pos_of_pos {l m : ℝ} (hl : 0 < l) (hm : 0 < m)
    (h : StrongResAt T S l) : StrongResAt T S m := by
  have hup : ∀ k : ℕ, StrongResAt T S (((3 : ℝ) / 2) ^ k * l) := by
    intro k
    induction k with
    | zero => simpa using h
    | succ k ih =>
        have hpos : 0 < ((3 : ℝ) / 2) ^ k * l := by positivity
        have hstep : StrongResAt T S (((3 : ℝ) / 2) * (((3 : ℝ) / 2) ^ k * l)) := by
          refine strongResAt_of_abs_sub_lt (ne_of_gt hpos) (by positivity) ?_ ih
          have hval : (3 : ℝ) / 2 * (((3 : ℝ) / 2) ^ k * l) - ((3 : ℝ) / 2) ^ k * l
              = (((3 : ℝ) / 2) ^ k * l) / 2 := by ring
          rw [hval, abs_of_pos (by positivity), abs_of_pos hpos]
          linarith
        have hcast : ((3 : ℝ) / 2) * (((3 : ℝ) / 2) ^ k * l) = ((3 : ℝ) / 2) ^ (k + 1) * l := by
          ring
        rwa [hcast] at hstep
  obtain ⟨k, hk⟩ := pow_unbounded_of_one_lt (m / (2 * l)) (by norm_num : (1 : ℝ) < 3 / 2)
  have hL : 0 < ((3 : ℝ) / 2) ^ k * l := by positivity
  have hmlt : m < 2 * (((3 : ℝ) / 2) ^ k * l) := by
    rw [div_lt_iff₀ (by positivity : (0:ℝ) < 2 * l)] at hk
    linarith
  refine strongResAt_of_abs_sub_lt (ne_of_gt hL) (ne_of_gt hm) ?_ (hup k)
  rw [abs_of_pos hL, abs_sub_lt_iff]
  constructor <;> linarith

/-- **The shift is immaterial.**  Strong convergence of the shift-invert operators at one
nonzero shift implies it at every nonzero shift. -/
theorem strongResAt_of_ne_zero {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0)
    (h : StrongResAt T S l) : StrongResAt T S m := by
  have hpos : ∀ l' : ℝ, 0 < l' → StrongResAt T S l' → StrongResAt T S m := by
    intro l' hl' h'
    rcases lt_or_gt_of_ne hm with hmneg | hmpos
    · have hmm : StrongResAt T S (-m) := strongResAt_of_pos_of_pos hl' (by linarith) h'
      have := strongResAt_neg (l := -m) (by linarith) hmm
      simpa using this
    · exact strongResAt_of_pos_of_pos hl' hmpos h'
  rcases lt_or_gt_of_ne hl with hlneg | hlpos
  · exact hpos (-l) (by linarith) (strongResAt_neg hl h)
  · exact hpos l hlpos h

/-- In particular the hypothesis of Trotter–Kato — stated at the shift `ℓ = 1` — follows
from convergence at an arbitrary nonzero shift. -/
theorem strongResolventConvergence_of_strongResAt {l : ℝ} (hl : l ≠ 0)
    (h : StrongResAt T S l) : StrongResolventConvergence T S :=
  fun y => strongResAt_of_ne_zero hl one_ne_zero h y

/-- **The single-finite-time statement.**  From the shift-invert operators at *one*
arbitrary nonzero shift, the approximants' propagators converge at *every single finite
time* `t`.  No time discretization occurs anywhere in the statement, and no boundedness of
the generators is assumed. -/
theorem singleTime_flow_tendsto_of_strongResAt {l : ℝ} (hl : l ≠ 0)
    (h : StrongResAt T S l) (v : E) (t : ℝ) :
    Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  trotterKato_tendsto T S (strongResolventConvergence_of_strongResAt hl h) v t

/-! ## 3. The Hashimoto shift-invert operator at an arbitrary complex shift `γ = iℓ` -/

/-- The **Hashimoto shift-invert operator** of a self-adjoint operator at the complex shift
`γ = iℓ` is `−(A − iℓ)⁻¹`, for every real `ℓ ≠ 0`.  It is bounded by `1/|ℓ|` whatever `A`
is: this is why the algorithm applies to unbounded Hamiltonians. -/
theorem isShiftInvertC_neg_resCLM_shift (T : UnboundedSelfAdjoint E) {l : ℝ} (hl : l ≠ 0) :
    IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) := by
  have hI : ((((l : ℝ) : ℂ) * Complex.I)).im ≠ 0 := by simpa using hl
  have key : ∀ x : T.domain,
      cshiftMap T.op (((l : ℝ) : ℂ) * Complex.I) x = -(T.shift l x) := by
    intro x
    rw [UnboundedSelfAdjoint.shift_apply, cshiftMap_apply]
    abel
  refine isShiftInvertC_of_rightInverse T.symmetric hI fun u => ?_
  have hmem : (-(T.resCLM l)) u ∈ T.domain := by
    have h := T.resCLM_mem l u
    simp only [ContinuousLinearMap.neg_apply]
    exact T.domain.neg_mem h
  refine ⟨hmem, ?_⟩
  have hneg : (⟨(-(T.resCLM l)) u, hmem⟩ : T.domain) = -(T.res l u) := Subtype.ext (by simp)
  rw [hneg, map_neg, key, neg_neg, T.shift_res hl]

/-- The shift-invert operator is bounded — by `1/|ℓ|` — for every self-adjoint `A`,
however unbounded. -/
theorem norm_neg_resCLM_apply_le (T : UnboundedSelfAdjoint E) (l : ℝ) (y : E) :
    ‖(-(T.resCLM l)) y‖ ≤ (1 / |l|) * ‖y‖ := by
  simpa using T.norm_resCLM_apply_le l y

/-! ## 4. The SIRK bound at a single finite time -/

open BookProof.ChapterSirkEndToEnd BookProof.ChapterH4 BookProof.ChapterH6

variable {Fin' : Type*} [NormedAddCommGroup Fin'] [InnerProductSpace ℂ Fin'] [CompleteSpace Fin']

/-- **The SIRK/Hashimoto error bound at one finite time.**  The operator the Krylov
reduction is built from is the *bounded* shift-invert `X = (A − iℓ)⁻¹` of a possibly
unbounded self-adjoint `A`, and the object approximated is the propagator `e^{−itA}` at the
one finite time `t` — approximated by a single rational function of `X`, i.e. by a fixed
number of shift-invert solves.  No time step, no splitting and no number of steps occurs. -/
theorem sirk_single_time_shiftInvert_bound
    (A : UnboundedSelfAdjoint E) (l t : ℝ)
    (V : Fin' →L[ℂ] E) (qX qXinv : E →L[ℂ] E) (qBinv : Fin' →L[ℂ] Fin')
    (p : Polynomial ℂ) (psiB : Fin' →L[ℂ] Fin') (C Dmin h : ℝ) (m : ℕ)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ Fin')
    (hViso : ∀ x : Fin', ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hinvX : ∀ x : Fin', ∃ y : Fin', A.resCLM l (V x) = V y)
    (hinvq : ∀ x : Fin', ∃ y : Fin', qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ Fin')
    (hcx1 : ‖A.stoneU t - (Polynomial.aeval (A.resCLM l) p).comp qXinv‖
      ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcx2 : ‖psiB - (Polynomial.aeval (compress V (A.resCLM l)) p).comp qBinv‖
      ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : E) (hv : V (V.adjoint v) = v) :
    ‖A.stoneU t v - sirkApprox V psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m :=
  sirk_end_to_end V (A.resCLM l) qX qXinv qBinv p (A.stoneU t) (A.stoneU t) psiB C Dmin h m
    hVV hViso hVadj hinvX hinvq hqXl hqBr rfl hcx1 hcx2 v hv

/-! ## 5. The quantum-gravity instance: any single shift, any single finite time -/

open BookProof.QgTruncationResolvent BookProof.FarisLavine BookProof.EsaClosure
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL BookProof.QgOuterFockCoreFL

variable {ι : Type*}

/-- **The quantum-gravity scheme needs no time discretization.**  For the outer-Fock
quantum-gravity Hamiltonian with the full exponential Starobinsky wall and its mode
truncations:

* each truncation and the exact Hamiltonian have a self-adjoint realization;
* at **every** nonzero shift `ℓ` the Hashimoto shift-invert operators `−(H − iℓ)⁻¹` of the
  truncations converge strongly to that of the exact Hamiltonian — one shift is as good as
  any other, and each of them is a bounded operator even though the Hamiltonians are not;
* consequently, for **every single finite time** `t` and every state `v`, the truncated
  propagators converge to the exact one.

No step size, number of steps or time-splitting appears: the algorithm is run at one finite
time. -/
theorem qgOuterFock_singleTime_shiftInvert_convergence (W : WallPot) (Q : QgModeData ι)
    (Λ : ℕ → Set ι) (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Sec ι,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec ι) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by
  obtain ⟨T, S, hT, hS, hres, hflow⟩ := qgOuterFock_truncation_flow_convergence W Q Λ hexh
  have hres1 : StrongResAt T S 1 := fun y => hres y
  refine ⟨T, S, hT, hS, fun l hl => ⟨isShiftInvertC_neg_resCLM_shift T hl,
    fun n => isShiftInvertC_neg_resCLM_shift (S n) hl, fun u => ?_⟩, fun v t => ?_⟩
  · exact (strongResAt_of_ne_zero one_ne_zero hl hres1 u).neg
  · exact (hflow v |t| (abs_nonneg t)).2 t

open BookProof.QgContinuumModeInstance

/-- **The physical instance, at one finite time and one shift.**  For the exact Fourier-mode
quantum-gravity Hamiltonian — no lattice, the full exponential Einstein-frame Starobinsky
wall, the exact torsion Gram matrix and the scalaron–vielbein coupling at arbitrary coupling
constant `g` — the momentum-cutoff Hamiltonians have Hashimoto shift-invert operators at
*every* complex shift `γ = iℓ`, these converge strongly to the shift-invert operator of the
exact Hamiltonian, and the cutoff propagators converge to the exact one at *every single
finite time*.  No time discretization and no boundedness of the Hamiltonian is used. -/
theorem starobinsky_qgContinuum_singleTime_shiftInvert_convergence (M alpha : ℝ)
    (halpha : 0 < alpha) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec CMode)) (S : ℕ → UnboundedSelfAdjoint (Sec CMode)),
      IsSelfAdjointExtension
          (secHam (starobinskyWall M alpha halpha) (qgContinuumModes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (qgContinuumModes g) (momWindow n))) (S n).op) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Sec CMode,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec CMode) (t : ℝ),
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  qgOuterFock_singleTime_shiftInvert_convergence (starobinskyWall M alpha halpha)
    (qgContinuumModes g) momWindow momWindow_exhausts

open BookProof.QgManifoldModeInstance

/-- **The same statement over a general spatial manifold.**  With the mode data of a closed
Riemannian three-manifold (`VielbeinSpectrum`), the spectrally truncated Hamiltonians'
Hashimoto shift-invert operators converge at every complex shift `γ = iℓ`, and the truncated
propagators converge to the exact quantum-gravity flow at every single finite time.  No time
discretization is involved. -/
theorem starobinsky_qgManifold_singleTime_shiftInvert_convergence (M alpha : ℝ)
    (halpha : 0 < alpha) (Sp : VielbeinSpectrum ι) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (Sn : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha) (Sp.modes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (Sp.modes g) (Sp.energyWindow n))) (Sn n).op) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (Sn n).op (((l : ℝ) : ℂ) * Complex.I) (-((Sn n).resCLM l))) ∧
            ∀ u : Sec ι,
              Tendsto (fun n => -((Sn n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec ι) (t : ℝ),
          Tendsto (fun n => (Sn n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  qgOuterFock_singleTime_shiftInvert_convergence (starobinskyWall M alpha halpha)
    (Sp.modes g) Sp.energyWindow Sp.energyWindow_exhausts

end

end BookProof.SirkSingleTime
