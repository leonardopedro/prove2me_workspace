import Definitions.Def_ChapterH9
import Mathlib


/-!
# Crouzeix-type inequalities from the numerical range, for general (non-normal) operators

`BookProof.ChapterCrouzeixSelfAdjoint` proves Crouzeix's inequality with constant `1` for
*normal* operators, and records the honest boundary that for a **general non-normal**
operator the bound `‖f(A)‖ ≤ C · sup_Σ |f|` over a convex set `Σ` containing the numerical
range — with its larger constant — is a named hypothesis.

This file removes that boundary in the disc regime, unconditionally and with an explicit
constant, for the analytic functional calculus.  The chain is:

* `NumRadiusLE A r` — the numerical range of `A` lies in the closed disc of radius `r`
  (`numRadiusLE_iff_numRange_subset` identifies this with `numRange A ⊆ closedBall 0 r`).
* `re_inner_sub_smul_nonneg` / `numRadiusLE_of_re_inner_sub_smul_nonneg` — the *Herglotz
  form* of the numerical-radius bound: `w(A) ≤ 1` iff `Re ⟪x, x − z A x⟫ ≥ 0` for every
  `‖z‖ < 1`.  This is the form that composes with the group of `n`-th roots of unity.
* **`numRadiusLE_pow`** — the **Berger power inequality** `w(Aⁿ) ≤ w(A)ⁿ`, proved by
  Pearcy's argument: the partial-fraction decomposition of `(1 − zⁿAⁿ)⁻¹` over the `n`-th
  roots of unity, realized here without any inverses at all, by the explicit vectors
  `u_k = ∑_{m<n} (ωᵏ z)^m Aᵐ y`.
* `norm_le_two_mul_of_numRadiusLE` — `‖A‖ ≤ 2 w(A)` (polarization), hence
  `norm_pow_le_of_numRadiusLE` — `‖Aⁿ‖ ≤ 2 w(A)ⁿ`.
* **`crouzeix_disc`** — the headline: if the numerical range of `A` lies in the closed disc
  of radius `r` and `f(z) = ∑ aₙ zⁿ` satisfies Cauchy's estimate `‖aₙ‖ ≤ M / Rⁿ` on a
  strictly larger disc of radius `R > r`, then the analytic functional calculus
  `f(A) = ∑ aₙ Aⁿ` converges in operator norm and
  `‖f(A)‖ ≤ (1 + 2r/(R − r)) · M`.
  This is a Crouzeix-type inequality for a *general non-normal* operator, with the
  numerical range as the spectral set and an explicit (larger) constant, **proved**.
* `NumBallLE`, `numBallLE_iff_numRange_subset` and `crouzeix_ball` — the same statement for
  a numerical range in an arbitrary closed disc `closedBall c r`, by the shift `A ↦ A - c`:
  `‖∑ aₙ (A - c)ⁿ‖ ≤ (1 + 2r/(R - r)) M` whenever `‖aₙ‖ ≤ M/Rⁿ` and `R > r`.

Everything is `sorry`-free and uses only the standard axioms.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- The numerical range of `A` lies in the closed disc of radius `r` about the origin,
written as a bound on Rayleigh quotients that is homogeneous in `x`. -/
def NumRadiusLE (A : E →L[ℂ] E) (r : ℝ) : Prop :=
  ∀ x : E, ‖(⟪x, A x⟫_ℂ)‖ ≤ r * ‖x‖ ^ 2





/-! ## The Herglotz form of the numerical-radius bound -/





/-! ## Pearcy's proof of the Berger power inequality -/

/-- The partial-fraction vectors of Pearcy's argument: `u_k = ∑_{m<n} (ωᵏ z)^m Aᵐ y`. -/
noncomputable def pearcyVec (A : E →L[ℂ] E) (c : ℂ) (n : ℕ) (y : E) : E :=
  ∑ m ∈ Finset.range n, c ^ m • (A ^ m) y









/-! ## From the numerical radius to the operator norm -/







/-! ## The Crouzeix-type bound for the analytic functional calculus -/

/-- The analytic functional calculus of a power series: `f(A) = ∑ aₙ Aⁿ`. -/
noncomputable def analyticFC (a : ℕ → ℂ) (A : E →L[ℂ] E) : E →L[ℂ] E :=
  ∑' n : ℕ, a n • A ^ n





ry in the disc regime, unconditionally and with an explicit
constant, for the analytic functional calculus.  The chain is:

* `NumRadiusLE A r` — the numerical range of `A` lies in the closed disc of radius `r`
  (`numRadiusLE_iff_numRange_subset` identifies this with `numRange A ⊆ closedBall 0 r`).
* `re_inner_sub_smul_nonneg` / `numRadiusLE_of_re_inner_sub_smul_nonneg` — the *Herglotz
  form* of the numerical-radius bound: `w(A) ≤ 1` iff `Re ⟪x, x − z A x⟫ ≥ 0` for every
  `‖z‖ < 1`.  This is the form that composes with the group of `n`-th roots of unity.
* **`numRadiusLE_pow`** — the **Berger power inequality** `w(Aⁿ) ≤ w(A)ⁿ`, proved by
  Pearcy's argument: the partial-fraction decomposition of `(1 − zⁿAⁿ)⁻¹` over the `n`-th
  roots of unity, realized here without any inverses at all, by the explicit vectors
  `u_k = ∑_{m<n} (ωᵏ z)^m Aᵐ y`.
* `norm_le_two_mul_of_numRadiusLE` — `‖A‖ ≤ 2 w(A)` (polarization), hence
  `norm_pow_le_of_numRadiusLE` — `‖Aⁿ‖ ≤ 2 w(A)ⁿ`.
* **`crouzeix_disc`** — the headline: if the numerical range of `A` lies in the closed disc
  of radius `r` and `f(z) = ∑ aₙ zⁿ` satisfies Cauchy's estimate `‖aₙ‖ ≤ M / Rⁿ` on a
  strictly larger disc of radius `R > r`, then the analytic functional calculus
  `f(A) = ∑ aₙ Aⁿ` converges in operator norm and
  `‖f(A)‖ ≤ (1 + 2r/(R − r)) · M`.
  This is a Crouzeix-type inequality for a *general non-normal* operator, with the
  numerical range as the spectral set and an explicit (larger) constant, **proved**.
* `NumBallLE`, `numBallLE_iff_numRange_subset` and `crouzeix_ball` — the same statement for
  a numerical range in an arbitrary closed disc `closedBall c r`, by the shift `A ↦ A - c`:
  `‖∑ aₙ (A - c)ⁿ‖ ≤ (1 + 2r/(R - r)) M` whenever `‖aₙ‖ ≤ M/Rⁿ` and `R > r`.

Everything is `sorry`-free and uses only the standard axioms.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- The numerical range of `A` lies in the closed disc of radius `r` about the origin,
written as a bound on Rayleigh quotients that is homogeneous in `x`. -/
def NumRadiusLE (A : E →L[ℂ] E) (r : ℝ) : Prop :=
  ∀ x : E, ‖(⟪x, A x⟫_ℂ)‖ ≤ r * ‖x‖ ^ 2

theorem inner_self_re (x : E) : (⟪x, x⟫_ℂ).re = ‖x‖ ^ 2 := by
  have := @inner_self_eq_norm_sq ℂ E _ _ _ x
  simpa using this

/-- `NumRadiusLE` is exactly the inclusion of the numerical range in a closed disc. -/
theorem numRadiusLE_iff_numRange_subset [CompleteSpace E] (A : E →L[ℂ] E) {r : ℝ} :
    NumRadiusLE A r ↔ BookProof.ChapterH9.numRange A ⊆ Metric.closedBall (0 : ℂ) r := by
  constructor
  · rintro h c ⟨x, hx, rfl⟩
    simpa [hx] using h x
  · intro h x
    rcases eq_or_ne x 0 with rfl | hx
    · simp
    · have hx0 : 0 < ‖x‖ := norm_pos_iff.mpr hx
      set y : E := (‖x‖ : ℂ)⁻¹ • x with hy
      have hynorm : ‖y‖ = 1 := by
        rw [hy, norm_smul]
        simp [abs_of_pos hx0, hx0.ne']
      have hmem : (⟪y, A y⟫_ℂ) ∈ BookProof.ChapterH9.numRange A :=
        BookProof.ChapterH9.mem_numRange y hynorm
      have hb : ‖(⟪y, A y⟫_ℂ)‖ ≤ r := by simpa using h hmem
      have hval : (⟪y, A y⟫_ℂ) = ((‖x‖ : ℂ) ^ 2)⁻¹ * (⟪x, A x⟫_ℂ) := by
        rw [hy, inner_smul_left, map_smul, inner_smul_right]
        simp [Complex.conj_ofReal]
        ring
      have hxc : ((‖x‖ : ℂ)) ≠ 0 := by simpa using hx0.ne'
      have : ‖(⟪x, A x⟫_ℂ)‖ = ‖x‖ ^ 2 * ‖(⟪y, A y⟫_ℂ)‖ := by
        rw [hval, norm_mul, norm_inv]
        simp [abs_of_pos hx0]
        field_simp
      rw [this]
      have h2 : (0:ℝ) ≤ ‖x‖ ^ 2 := by positivity
      nlinarith [hb, h2]

/-! ## The Herglotz form of the numerical-radius bound -/

/-- If `w(A) ≤ 1` then `Re ⟪x, x − z A x⟫ ≥ 0` for every `‖z‖ ≤ 1`. -/
theorem re_inner_sub_smul_nonneg {A : E →L[ℂ] E} (h : NumRadiusLE A 1) {z : ℂ}
    (hz : ‖z‖ ≤ 1) (x : E) : 0 ≤ (⟪x, x - z • A x⟫_ℂ).re := by
  rw [inner_sub_right, inner_smul_right]
  have h2 : (z * ⟪x, A x⟫_ℂ).re ≤ ‖z‖ * ‖(⟪x, A x⟫_ℂ)‖ := by
    calc (z * ⟪x, A x⟫_ℂ).re ≤ ‖z * ⟪x, A x⟫_ℂ‖ := Complex.re_le_norm _
      _ = ‖z‖ * ‖(⟪x, A x⟫_ℂ)‖ := by rw [norm_mul]
  have h3 := h x
  have hnn : (0:ℝ) ≤ ‖(⟪x, A x⟫_ℂ)‖ := norm_nonneg _
  simp only [Complex.sub_re, inner_self_re]
  nlinarith [norm_nonneg x, sq_nonneg ‖x‖]

/-- Conversely, the positivity of `Re ⟪x, x − z A x⟫` on the open unit disc of parameters
`z` forces `w(A) ≤ 1`. -/
theorem numRadiusLE_of_re_inner_sub_smul_nonneg {A : E →L[ℂ] E}
    (h : ∀ z : ℂ, ‖z‖ < 1 → ∀ x : E, 0 ≤ (⟪x, x - z • A x⟫_ℂ).re) : NumRadiusLE A 1 := by
  intro x
  by_cases hc : ⟪x, A x⟫_ℂ = 0
  · rw [hc]; simp
  · set c := ⟪x, A x⟫_ℂ with hcdef
    have hcn : (0:ℝ) < ‖c‖ := norm_pos_iff.mpr hc
    have hcn' : (‖c‖ : ℂ) ≠ 0 := by simpa using hc
    have key : ∀ t : ℝ, 0 ≤ t → t < 1 → t * ‖c‖ ≤ ‖x‖ ^ 2 := by
      intro t ht ht1
      have hz : ‖((t : ℂ) * (starRingEnd ℂ) c / (‖c‖ : ℂ))‖ < 1 := by
        rw [norm_div, norm_mul]
        simp only [Complex.norm_real, Real.norm_eq_abs, RCLike.norm_conj]
        rw [abs_of_nonneg ht, abs_of_nonneg (norm_nonneg c), mul_div_assoc,
          div_self hcn.ne']
        simpa using ht1
      have hpos := h _ hz x
      rw [inner_sub_right, inner_smul_right] at hpos
      have hmul : ((t : ℂ) * (starRingEnd ℂ) c / (‖c‖ : ℂ)) * c = ((t * ‖c‖ : ℝ) : ℂ) := by
        have h1 : (starRingEnd ℂ) c * c = ((‖c‖ : ℂ)) ^ 2 := by rw [Complex.conj_mul']
        calc (t:ℂ) * (starRingEnd ℂ) c / (‖c‖:ℂ) * c
            = (t:ℂ) * ((starRingEnd ℂ) c * c) / (‖c‖:ℂ) := by ring
          _ = (t:ℂ) * (‖c‖:ℂ)^2 / (‖c‖:ℂ) := by rw [h1]
          _ = (t:ℂ) * (‖c‖:ℂ) := by field_simp
          _ = ((t * ‖c‖ : ℝ) : ℂ) := by push_cast; ring
      rw [← hcdef, hmul] at hpos
      simp only [Complex.sub_re, Complex.ofReal_re, inner_self_re] at hpos
      linarith
    by_contra hcon
    push_neg at hcon
    rw [one_mul] at hcon
    set t := (‖x‖ ^ 2 / ‖c‖ + 1) / 2 with htdef
    have hx2 : ‖x‖ ^ 2 / ‖c‖ < 1 := (div_lt_one hcn).mpr hcon
    have hx0 : 0 ≤ ‖x‖ ^ 2 / ‖c‖ := by positivity
    have ht0 : 0 ≤ t := by rw [htdef]; linarith
    have ht1 : t < 1 := by rw [htdef]; linarith
    have hkey := key t ht0 ht1
    have hgt : ‖x‖ ^ 2 / ‖c‖ < t := by rw [htdef]; linarith
    rw [div_lt_iff₀ hcn] at hgt
    linarith

/-! ## Pearcy's proof of the Berger power inequality -/

/-- The partial-fraction vectors of Pearcy's argument: `u_k = ∑_{m<n} (ωᵏ z)^m Aᵐ y`. -/
noncomputable def pearcyVec (A : E →L[ℂ] E) (c : ℂ) (n : ℕ) (y : E) : E :=
  ∑ m ∈ Finset.range n, c ^ m • (A ^ m) y

/-- Each partial-fraction vector solves `(1 − c A) u = y − cⁿ Aⁿ y`. -/
theorem pearcyVec_apply (A : E →L[ℂ] E) (c : ℂ) (n : ℕ) (y : E) :
    pearcyVec A c n y - c • A (pearcyVec A c n y) = y - c ^ n • (A ^ n) y := by
  set v : ℕ → E := fun m => c ^ m • (A ^ m) y with hv
  have hcomm : ∀ (m : ℕ), A ((A ^ m) y) = (A ^ m) (A y) := by
    intro m
    rw [← ContinuousLinearMap.mul_apply, ← ContinuousLinearMap.mul_apply, ← pow_succ',
      ← pow_succ]
  have hpow : ∀ (m : ℕ) (z : E), (A ^ m) z = (⇑A)^[m] z := by
    intro m z
    induction m generalizing z with
    | zero => simp
    | succ m ih =>
      rw [pow_succ, ContinuousLinearMap.mul_apply, Function.iterate_succ_apply, ih]
  have hcommI : ∀ (m : ℕ), A ((⇑A)^[m] y) = (⇑A)^[m] (A y) := fun m => by
    rw [← hpow m y, ← hpow m (A y)]
    exact hcomm m
  have hstep : ∀ m, c • A (v m) = v (m + 1) := by
    intro m
    simp [hv, map_smul, pow_succ, pow_succ', smul_smul, mul_comm, hcommI]
  have h1 : A (pearcyVec A c n y) = ∑ m ∈ Finset.range n, A (v m) := by
    simp [pearcyVec, hv, map_sum]
  calc pearcyVec A c n y - c • A (pearcyVec A c n y)
      = (∑ m ∈ Finset.range n, v m) - ∑ m ∈ Finset.range n, c • A (v m) := by
        rw [h1, Finset.smul_sum]; rfl
    _ = ∑ m ∈ Finset.range n, (v m - v (m + 1)) := by
        rw [← Finset.sum_sub_distrib]
        exact Finset.sum_congr rfl fun m _ => by rw [hstep m]
    _ = v 0 - v n := Finset.sum_range_sub' v n
    _ = y - c ^ n • (A ^ n) y := by simp [hv]

/-- The partial-fraction vectors over the `n`-th roots of unity sum to `n · y`. -/
theorem sum_pearcyVec {A : E →L[ℂ] E} {w : ℂ} {n : ℕ} (hn : 0 < n)
    (hw : IsPrimitiveRoot w n) (z : ℂ) (y : E) :
    ∑ k ∈ Finset.range n, pearcyVec A (w ^ k * z) n y = (n : ℂ) • y := by
  have hcoef : ∀ m ∈ Finset.range n,
      (∑ k ∈ Finset.range n, (w ^ k * z) ^ m) = if m = 0 then (n : ℂ) else 0 := by
    intro m hm
    rcases Nat.eq_zero_or_pos m with rfl | hm0
    · simp
    · have hmn : m < n := Finset.mem_range.mp hm
      have hne : w ^ m ≠ 1 := hw.pow_ne_one_of_pos_of_lt hm0.ne' hmn
      have hsplit : ∑ k ∈ Finset.range n, (w ^ k * z) ^ m
          = z ^ m * ∑ k ∈ Finset.range n, (w ^ m) ^ k := by
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun k _ => by
          rw [mul_pow, ← pow_mul, ← pow_mul, mul_comm k m]; ring
      have hone : (w ^ m) ^ n = 1 := by
        rw [← pow_mul, mul_comm, pow_mul, hw.pow_eq_one, one_pow]
      rw [hsplit, geom_sum_eq hne, hone]
      simp [hm0.ne']
  calc ∑ k ∈ Finset.range n, pearcyVec A (w ^ k * z) n y
      = ∑ m ∈ Finset.range n, (∑ k ∈ Finset.range n, (w ^ k * z) ^ m) • (A ^ m) y := by
        simp only [pearcyVec]
        rw [Finset.sum_comm]
        exact Finset.sum_congr rfl fun m _ => by rw [Finset.sum_smul]
    _ = (n : ℂ) • y := by
        rw [Finset.sum_congr rfl (fun m hm => by rw [hcoef m hm])]
        rw [Finset.sum_eq_single 0]
        · simp
        · intro b _ hb; simp [hb]
        · intro hcon; exact absurd (Finset.mem_range.mpr hn) hcon

/-- **The Berger power inequality** `w(Aⁿ) ≤ 1` whenever `w(A) ≤ 1`, by Pearcy's argument. -/
theorem numRadiusLE_pow_one {A : E →L[ℂ] E} (h : NumRadiusLE A 1) (n : ℕ) (hn : 0 < n) :
    NumRadiusLE (A ^ n) 1 := by
  refine numRadiusLE_of_re_inner_sub_smul_nonneg ?_
  intro q hq y
  obtain ⟨z, hz⟩ : ∃ z : ℂ, z ^ n = q := IsAlgClosed.exists_pow_nat_eq q hn
  have hzlt : ‖z‖ < 1 := by
    by_contra hcon
    push_neg at hcon
    have h1 : (1:ℝ) ≤ ‖z‖ ^ n := one_le_pow₀ hcon
    rw [← norm_pow, hz] at h1
    linarith
  set w : ℂ := Complex.exp (2 * Real.pi * Complex.I / n) with hwdef
  have hw : IsPrimitiveRoot w n := Complex.isPrimitiveRoot_exp n hn.ne'
  have hwnorm : ‖w‖ = 1 := Complex.norm_eq_one_of_pow_eq_one hw.pow_eq_one hn.ne'
  set W : E := y - q • (A ^ n) y with hW
  have hsolve : ∀ k : ℕ, pearcyVec A (w ^ k * z) n y
      - (w ^ k * z) • A (pearcyVec A (w ^ k * z) n y) = W := by
    intro k
    rw [pearcyVec_apply, hW]
    congr 2
    rw [mul_pow, ← pow_mul, mul_comm k n, pow_mul, hw.pow_eq_one, one_pow, one_mul, hz]
  have hnorm_c : ∀ k : ℕ, ‖w ^ k * z‖ ≤ 1 := by
    intro k
    rw [norm_mul, norm_pow, hwnorm, one_pow, one_mul]
    exact hzlt.le
  have hterm : ∀ k : ℕ, 0 ≤ (⟪pearcyVec A (w ^ k * z) n y, W⟫_ℂ).re := by
    intro k
    have hk := re_inner_sub_smul_nonneg h (hnorm_c k) (pearcyVec A (w ^ k * z) n y)
    rwa [hsolve k] at hk
  have hsum : ⟪((n : ℂ) • y), W⟫_ℂ
      = ∑ k ∈ Finset.range n, ⟪pearcyVec A (w ^ k * z) n y, W⟫_ℂ := by
    rw [← sum_pearcyVec hn hw z y, sum_inner]
  have hre : 0 ≤ (⟪((n : ℂ) • y), W⟫_ℂ).re := by
    rw [hsum, Complex.re_sum]
    exact Finset.sum_nonneg fun k _ => hterm k
  rw [inner_smul_left] at hre
  simp only [map_natCast, Complex.mul_re, Complex.natCast_re, Complex.natCast_im, zero_mul,
    sub_zero] at hre
  have hn' : (0:ℝ) < (n : ℝ) := by exact_mod_cast hn
  nlinarith [hre]

/-- The homogeneous form of the power inequality: `w(Aⁿ) ≤ w(A)ⁿ`. -/
theorem numRadiusLE_pow {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r) (h : NumRadiusLE A r) (n : ℕ)
    (hn : 0 < n) : NumRadiusLE (A ^ n) (r ^ n) := by
  rcases eq_or_lt_of_le hr with hr0 | hr0
  · -- `r = 0` forces `A = 0`
    have hA : (A : E →ₗ[ℂ] E) = 0 := by
      refine (inner_map_self_eq_zero (A : E →ₗ[ℂ] E)).mp ?_
      intro x
      have hx := h x
      rw [← hr0] at hx
      simp only [zero_mul, norm_le_zero_iff] at hx
      have : (⟪A x, x⟫_ℂ) = (starRingEnd ℂ) (⟪x, A x⟫_ℂ) := (inner_conj_symm _ _).symm
      simp [this, hx]
    have hA0 : A = 0 := by
      ext x
      have := congrArg (fun (T : E →ₗ[ℂ] E) => T x) hA
      simpa using this
    intro x
    rw [hA0]
    simp [zero_pow hn.ne']
    positivity
  · -- scale to numerical radius `1`
    set B : E →L[ℂ] E := (r : ℂ)⁻¹ • A with hB
    have hB1 : NumRadiusLE B 1 := by
      intro x
      have hx := h x
      rw [hB]
      simp only [ContinuousLinearMap.smul_apply, inner_smul_right, norm_mul, norm_inv]
      rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr0]
      rw [inv_mul_le_iff₀ hr0]
      calc ‖(⟪x, A x⟫_ℂ)‖ ≤ r * ‖x‖ ^ 2 := hx
        _ = r * (1 * ‖x‖ ^ 2) := by ring
    have hBn := numRadiusLE_pow_one hB1 n hn
    intro x
    have hBpow : (B ^ n) x = ((r : ℂ)⁻¹) ^ n • (A ^ n) x := by
      rw [hB, smul_pow]
      simp
    have hx := hBn x
    rw [hBpow, inner_smul_right, norm_mul] at hx
    have hrn : ‖(((r : ℂ)⁻¹) ^ n)‖ = (r ^ n)⁻¹ := by
      rw [norm_pow, norm_inv, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr0, ← inv_pow]
    rw [hrn, one_mul, inv_mul_le_iff₀ (by positivity)] at hx
    calc ‖(⟪x, (A ^ n) x⟫_ℂ)‖ ≤ r ^ n * ‖x‖ ^ 2 := by linarith [hx]
      _ = r ^ n * ‖x‖ ^ 2 := rfl

/-! ## From the numerical radius to the operator norm -/

/-- The polarization bound `‖⟪A y, x⟫‖ ≤ w(A) (‖x‖² + ‖y‖²)`. -/
theorem inner_polar_bound {A : E →L[ℂ] E} {r : ℝ} (h : NumRadiusLE A r) (x y : E) :
    ‖(⟪A y, x⟫_ℂ)‖ ≤ r * (‖x‖ ^ 2 + ‖y‖ ^ 2) := by
  have hQ : ∀ u : E, ‖(⟪A u, u⟫_ℂ)‖ ≤ r * ‖u‖ ^ 2 := by
    intro u
    have hcs : (⟪A u, u⟫_ℂ) = (starRingEnd ℂ) (⟪u, A u⟫_ℂ) := (inner_conj_symm _ _).symm
    rw [hcs, RCLike.norm_conj]
    exact h u
  have key := inner_map_polarization (A : E →ₗ[ℂ] E) x y
  simp only [ContinuousLinearMap.coe_coe] at key
  rw [key]
  have e1 : ‖(⟪A (x + y), x + y⟫_ℂ)‖ ≤ r * ‖x + y‖ ^ 2 := hQ _
  have e2 : ‖(⟪A (x - y), x - y⟫_ℂ)‖ ≤ r * ‖x - y‖ ^ 2 := hQ _
  have e3 : ‖(⟪A (x + Complex.I • y), x + Complex.I • y⟫_ℂ)‖
      ≤ r * ‖x + Complex.I • y‖ ^ 2 := hQ _
  have e4 : ‖(⟪A (x - Complex.I • y), x - Complex.I • y⟫_ℂ)‖
      ≤ r * ‖x - Complex.I • y‖ ^ 2 := hQ _
  have hpar1 : ‖x + y‖ ^ 2 + ‖x - y‖ ^ 2 = 2 * (‖x‖ ^ 2 + ‖y‖ ^ 2) := by
    simpa [pow_two] using parallelogram_law_with_norm ℂ x y
  have hpar2 : ‖x + Complex.I • y‖ ^ 2 + ‖x - Complex.I • y‖ ^ 2
      = 2 * (‖x‖ ^ 2 + ‖y‖ ^ 2) := by
    simpa [pow_two, norm_smul] using parallelogram_law_with_norm ℂ x (Complex.I • y)
  have hdiv : ∀ a b c d : ℂ, ‖(a - b + Complex.I * c - Complex.I * d) / 4‖
      ≤ (‖a‖ + ‖b‖ + ‖c‖ + ‖d‖) / 4 := by
    intro a b c d
    rw [norm_div]
    simp only [Complex.norm_ofNat]
    gcongr
    calc ‖a - b + Complex.I * c - Complex.I * d‖
        ≤ ‖a - b + Complex.I * c‖ + ‖Complex.I * d‖ := norm_sub_le _ _
      _ ≤ (‖a - b‖ + ‖Complex.I * c‖) + ‖Complex.I * d‖ := by gcongr; exact norm_add_le _ _
      _ ≤ ((‖a‖ + ‖b‖) + ‖Complex.I * c‖) + ‖Complex.I * d‖ := by gcongr; exact norm_sub_le _ _
      _ = ‖a‖ + ‖b‖ + ‖c‖ + ‖d‖ := by simp
  refine le_trans (hdiv _ _ _ _) ?_
  rw [div_le_iff₀ (by norm_num : (0:ℝ) < 4)]
  have hr1 : r * (‖x + y‖ ^ 2 + ‖x - y‖ ^ 2) = r * (2 * (‖x‖ ^ 2 + ‖y‖ ^ 2)) := by rw [hpar1]
  have hr2 : r * (‖x + Complex.I • y‖ ^ 2 + ‖x - Complex.I • y‖ ^ 2)
      = r * (2 * (‖x‖ ^ 2 + ‖y‖ ^ 2)) := by rw [hpar2]
  nlinarith [e1, e2, e3, e4, hr1, hr2]

/-- **`‖A‖ ≤ 2 w(A)`**, by polarization. -/
theorem norm_le_two_mul_of_numRadiusLE {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r)
    (h : NumRadiusLE A r) : ‖A‖ ≤ 2 * r := by
  refine ContinuousLinearMap.opNorm_le_bound _ (by linarith) fun y => ?_
  rcases eq_or_ne (A y) 0 with hAy | hAy
  · rw [hAy]
    simp
    positivity
  · have hAy0 : 0 < ‖A y‖ := norm_pos_iff.mpr hAy
    have hy0 : 0 < ‖y‖ := by
      rcases eq_or_ne y 0 with rfl | hy
      · simp at hAy
      · exact norm_pos_iff.mpr hy
    set t : ℝ := ‖y‖ / ‖A y‖ with ht
    have htv : t * ‖A y‖ = ‖y‖ := by rw [ht, div_mul_cancel₀ _ hAy0.ne']
    have ht0 : 0 ≤ t := by positivity
    have hb := inner_polar_bound h ((t : ℂ) • A y) y
    have hinner : (⟪A y, (t : ℂ) • A y⟫_ℂ) = ((t * ‖A y‖ ^ 2 : ℝ) : ℂ) := by
      rw [inner_smul_right, inner_self_eq_norm_sq_to_K]
      push_cast
      rfl
    have hnormx : ‖((t : ℂ) • A y)‖ = t * ‖A y‖ := by
      rw [norm_smul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg ht0]
    have habs : ‖(((t * ‖A y‖ ^ 2 : ℝ)) : ℂ)‖ = t * ‖A y‖ ^ 2 := by
      rw [Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    rw [hinner, hnormx, habs] at hb
    have hleft : t * ‖A y‖ ^ 2 = ‖y‖ * ‖A y‖ := by
      rw [pow_two, ← mul_assoc, htv]
    rw [hleft, htv] at hb
    nlinarith [hb, hy0]

/-- The powers of an operator with numerical range in the disc of radius `r` obey
`‖Aⁿ‖ ≤ 2 rⁿ`. -/
theorem norm_pow_le_of_numRadiusLE {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r)
    (h : NumRadiusLE A r) (n : ℕ) (hn : 0 < n) : ‖A ^ n‖ ≤ 2 * r ^ n :=
  norm_le_two_mul_of_numRadiusLE (by positivity) (numRadiusLE_pow hr h n hn)

/-! ## The Crouzeix-type bound for the analytic functional calculus -/

/-- The analytic functional calculus of a power series: `f(A) = ∑ aₙ Aⁿ`. -/
noncomputable def analyticFC (a : ℕ → ℂ) (A : E →L[ℂ] E) : E →L[ℂ] E :=
  ∑' n : ℕ, a n • A ^ n

/-- The termwise bound behind the Crouzeix-type estimate. -/
theorem norm_term_le [CompleteSpace E] {A : E →L[ℂ] E} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumRadiusLE A r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) (n : ℕ) (hn : 0 < n) :
    ‖a n • A ^ n‖ ≤ 2 * M * (r / R) ^ n := by
  have hR0 : 0 < R := lt_of_le_of_lt hr hR
  have hRn : 0 < R ^ n := by positivity
  have h1 : ‖a n • A ^ n‖ = ‖a n‖ * ‖A ^ n‖ := by rw [norm_smul]
  rw [h1]
  have h2 : ‖A ^ n‖ ≤ 2 * r ^ n := norm_pow_le_of_numRadiusLE hr h n hn
  have h3 : ‖a n‖ ≤ M / R ^ n := ha n
  have h4 : (0:ℝ) ≤ ‖A ^ n‖ := norm_nonneg _
  have h5 : ‖a n‖ * ‖A ^ n‖ ≤ (M / R ^ n) * (2 * r ^ n) := by
    apply mul_le_mul h3 h2 h4
    positivity
  calc ‖a n‖ * ‖A ^ n‖ ≤ (M / R ^ n) * (2 * r ^ n) := h5
    _ = 2 * M * (r / R) ^ n := by
        rw [div_pow]
        field_simp

/-- Under the Cauchy estimate `‖aₙ‖ ≤ M / Rⁿ` with `R > r ≥ w(A)`, the series defining the
analytic functional calculus converges absolutely in operator norm. -/
theorem summable_analyticFC [CompleteSpace E] {A : E →L[ℂ] E} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumRadiusLE A r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) : Summable fun n : ℕ => a n • A ^ n := by
  have hR0 : 0 < R := lt_of_le_of_lt hr hR
  have hq0 : 0 ≤ r / R := by positivity
  have hq1 : r / R < 1 := (div_lt_one hR0).mpr hR
  have hgeo : Summable fun n : ℕ => 2 * M * (r / R) ^ n :=
    (summable_geometric_of_lt_one hq0 hq1).mul_left _
  refine Summable.of_norm_bounded hgeo ?_
  intro n
  rcases Nat.eq_zero_or_pos n with rfl | hn
  · have h2 : ‖a 0‖ ≤ M := by simpa using ha 0
    have hone : ‖(1 : E →L[ℂ] E)‖ ≤ 1 := by
      rw [show (1 : E →L[ℂ] E) = ContinuousLinearMap.id ℂ E from rfl]
      exact ContinuousLinearMap.norm_id_le
    have h1 : ‖a 0 • A ^ 0‖ ≤ ‖a 0‖ := by
      rw [norm_smul, pow_zero]
      nlinarith [norm_nonneg (a 0), norm_nonneg (1 : E →L[ℂ] E)]
    calc ‖a 0 • A ^ 0‖ ≤ M := le_trans h1 h2
      _ ≤ 2 * M * (r / R) ^ 0 := by simp; linarith
  · exact norm_term_le hr hM hR h ha n hn

/-- **Crouzeix's inequality for a general operator, from the numerical range, with an
explicit larger constant.**  If the numerical range of `A` lies in the closed disc of
radius `r` and `f(z) = ∑ aₙ zⁿ` obeys Cauchy's estimate `‖aₙ‖ ≤ M/Rⁿ` on the strictly
larger disc of radius `R`, then `‖f(A)‖ ≤ (1 + 2r/(R − r)) M`. -/
theorem crouzeix_disc [CompleteSpace E] {A : E →L[ℂ] E} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumRadiusLE A r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) :
    ‖analyticFC a A‖ ≤ (1 + 2 * r / (R - r)) * M := by
  have hR0 : 0 < R := lt_of_le_of_lt hr hR
  have hRr : (0:ℝ) < R - r := by linarith
  have hq0 : 0 ≤ r / R := by positivity
  have hq1 : r / R < 1 := (div_lt_one hR0).mpr hR
  have hsum : Summable fun n : ℕ => a n • A ^ n := summable_analyticFC hr hM hR h ha
  have hhead : ‖a 0 • A ^ 0‖ ≤ M := by
    have h2 : ‖a 0‖ ≤ M := by simpa using ha 0
    have hone : ‖(1 : E →L[ℂ] E)‖ ≤ 1 := by
      rw [show (1 : E →L[ℂ] E) = ContinuousLinearMap.id ℂ E from rfl]
      exact ContinuousLinearMap.norm_id_le
    have h1 : ‖a 0 • A ^ 0‖ ≤ ‖a 0‖ := by
      rw [norm_smul, pow_zero]
      nlinarith [norm_nonneg (a 0), norm_nonneg (1 : E →L[ℂ] E)]
    linarith
  have hsplit : analyticFC a A = a 0 • A ^ 0 + ∑' n : ℕ, a (n + 1) • A ^ (n + 1) := by
    rw [analyticFC, hsum.tsum_eq_zero_add]
  have hgeo : HasSum (fun n : ℕ => (2 * M * (r / R)) * (r / R) ^ n)
      ((2 * M * (r / R)) * (1 - r / R)⁻¹) :=
    (hasSum_geometric_of_lt_one hq0 hq1).mul_left _
  have hval : (2 * M * (r / R)) * (1 - r / R)⁻¹ = 2 * M * (r / (R - r)) := by
    have h1 : (1 : ℝ) - r / R = (R - r) / R := by field_simp
    rw [h1]
    field_simp
  rw [hval] at hgeo
  have htail : ‖∑' n : ℕ, a (n + 1) • A ^ (n + 1)‖ ≤ 2 * M * (r / (R - r)) := by
    refine tsum_of_norm_bounded hgeo fun n => ?_
    refine le_trans (norm_term_le hr hM hR h ha (n + 1) (Nat.succ_pos n)) ?_
    rw [pow_succ]
    ring_nf
    exact le_of_eq (by ring)
  rw [hsplit]
  calc ‖a 0 • A ^ 0 + ∑' n : ℕ, a (n + 1) • A ^ (n + 1)‖
      ≤ ‖a 0 • A ^ 0‖ + ‖∑' n : ℕ, a (n + 1) • A ^ (n + 1)‖ := norm_add_le _ _
    _ ≤ M + 2 * M * (r / (R - r)) := by linarith
    _ = (1 + 2 * r / (R - r)) * M := by field_simp

/-! ## The shifted disc: a numerical range in an arbitrary closed ball -/

/-- The numerical range of `A` lies in the closed ball of centre `c` and radius `r`: the
numerical radius of the shifted operator `A - c` is at most `r`. -/
def NumBallLE (A : E →L[ℂ] E) (c : ℂ) (r : ℝ) : Prop :=
  NumRadiusLE (A - c • (1 : E →L[ℂ] E)) rdisc regime, unconditionally and with an explicit
constant, for the analytic functional calculus.  The chain is:

* `NumRadiusLE A r` — the numerical range of `A` lies in the closed disc of radius `r`
  (`numRadiusLE_iff_numRange_subset` identifies this with `numRange A ⊆ closedBall 0 r`).
* `re_inner_sub_smul_nonneg` / `numRadiusLE_of_re_inner_sub_smul_nonneg` — the *Herglotz
  form* of the numerical-radius bound: `w(A) ≤ 1` iff `Re ⟪x, x − z A x⟫ ≥ 0` for every
  `‖z‖ < 1`.  This is the form that composes with the group of `n`-th roots of unity.
* **`numRadiusLE_pow`** — the **Berger power inequality** `w(Aⁿ) ≤ w(A)ⁿ`, proved by
  Pearcy's argument: the partial-fraction decomposition of `(1 − zⁿAⁿ)⁻¹` over the `n`-th
  roots of unity, realized here without any inverses at all, by the explicit vectors
  `u_k = ∑_{m<n} (ωᵏ z)^m Aᵐ y`.
* `norm_le_two_mul_of_numRadiusLE` — `‖A‖ ≤ 2 w(A)` (polarization), hence
  `norm_pow_le_of_numRadiusLE` — `‖Aⁿ‖ ≤ 2 w(A)ⁿ`.
* **`crouzeix_disc`** — the headline: if the numerical range of `A` lies in the closed disc
  of radius `r` and `f(z) = ∑ aₙ zⁿ` satisfies Cauchy's estimate `‖aₙ‖ ≤ M / Rⁿ` on a
  strictly larger disc of radius `R > r`, then the analytic functional calculus
  `f(A) = ∑ aₙ Aⁿ` converges in operator norm and
  `‖f(A)‖ ≤ (1 + 2r/(R − r)) · M`.
  This is a Crouzeix-type inequality for a *general non-normal* operator, with the
  numerical range as the spectral set and an explicit (larger) constant, **proved**.
* `NumBallLE`, `numBallLE_iff_numRange_subset` and `crouzeix_ball` — the same statement for
  a numerical range in an arbitrary closed disc `closedBall c r`, by the shift `A ↦ A - c`:
  `‖∑ aₙ (A - c)ⁿ‖ ≤ (1 + 2r/(R - r)) M` whenever `‖aₙ‖ ≤ M/Rⁿ` and `R > r`.

Everything is `sorry`-free and uses only the standard axioms.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- The numerical range of `A` lies in the closed disc of radius `r` about the origin,
written as a bound on Rayleigh quotients that is homogeneous in `x`. -/
def NumRadiusLE (A : E →L[ℂ] E) (r : ℝ) : Prop :=
  ∀ x : E, ‖(⟪x, A x⟫_ℂ)‖ ≤ r * ‖x‖ ^ 2

theorem inner_self_re (x : E) : (⟪x, x⟫_ℂ).re = ‖x‖ ^ 2 := by
  have := @inner_self_eq_norm_sq ℂ E _ _ _ x
  simpa using this

/-- `NumRadiusLE` is exactly the inclusion of the numerical range in a closed disc. -/
theorem numRadiusLE_iff_numRange_subset [CompleteSpace E] (A : E →L[ℂ] E) {r : ℝ} :
    NumRadiusLE A r ↔ BookProof.ChapterH9.numRange A ⊆ Metric.closedBall (0 : ℂ) r := by
  constructor
  · rintro h c ⟨x, hx, rfl⟩
    simpa [hx] using h x
  · intro h x
    rcases eq_or_ne x 0 with rfl | hx
    · simp
    · have hx0 : 0 < ‖x‖ := norm_pos_iff.mpr hx
      set y : E := (‖x‖ : ℂ)⁻¹ • x with hy
      have hynorm : ‖y‖ = 1 := by
        rw [hy, norm_smul]
        simp [abs_of_pos hx0, hx0.ne']
      have hmem : (⟪y, A y⟫_ℂ) ∈ BookProof.ChapterH9.numRange A :=
        BookProof.ChapterH9.mem_numRange y hynorm
      have hb : ‖(⟪y, A y⟫_ℂ)‖ ≤ r := by simpa using h hmem
      have hval : (⟪y, A y⟫_ℂ) = ((‖x‖ : ℂ) ^ 2)⁻¹ * (⟪x, A x⟫_ℂ) := by
        rw [hy, inner_smul_left, map_smul, inner_smul_right]
        simp [Complex.conj_ofReal]
        ring
      have hxc : ((‖x‖ : ℂ)) ≠ 0 := by simpa using hx0.ne'
      have : ‖(⟪x, A x⟫_ℂ)‖ = ‖x‖ ^ 2 * ‖(⟪y, A y⟫_ℂ)‖ := by
        rw [hval, norm_mul, norm_inv]
        simp [abs_of_pos hx0]
        field_simp
      rw [this]
      have h2 : (0:ℝ) ≤ ‖x‖ ^ 2 := by positivity
      nlinarith [hb, h2]

/-! ## The Herglotz form of the numerical-radius bound -/

/-- If `w(A) ≤ 1` then `Re ⟪x, x − z A x⟫ ≥ 0` for every `‖z‖ ≤ 1`. -/
theorem re_inner_sub_smul_nonneg {A : E →L[ℂ] E} (h : NumRadiusLE A 1) {z : ℂ}
    (hz : ‖z‖ ≤ 1) (x : E) : 0 ≤ (⟪x, x - z • A x⟫_ℂ).re := by
  rw [inner_sub_right, inner_smul_right]
  have h2 : (z * ⟪x, A x⟫_ℂ).re ≤ ‖z‖ * ‖(⟪x, A x⟫_ℂ)‖ := by
    calc (z * ⟪x, A x⟫_ℂ).re ≤ ‖z * ⟪x, A x⟫_ℂ‖ := Complex.re_le_norm _
      _ = ‖z‖ * ‖(⟪x, A x⟫_ℂ)‖ := by rw [norm_mul]
  have h3 := h x
  have hnn : (0:ℝ) ≤ ‖(⟪x, A x⟫_ℂ)‖ := norm_nonneg _
  simp only [Complex.sub_re, inner_self_re]
  nlinarith [norm_nonneg x, sq_nonneg ‖x‖]

/-- Conversely, the positivity of `Re ⟪x, x − z A x⟫` on the open unit disc of parameters
`z` forces `w(A) ≤ 1`. -/
theorem numRadiusLE_of_re_inner_sub_smul_nonneg {A : E →L[ℂ] E}
    (h : ∀ z : ℂ, ‖z‖ < 1 → ∀ x : E, 0 ≤ (⟪x, x - z • A x⟫_ℂ).re) : NumRadiusLE A 1 := by
  intro x
  by_cases hc : ⟪x, A x⟫_ℂ = 0
  · rw [hc]; simp
  · set c := ⟪x, A x⟫_ℂ with hcdef
    have hcn : (0:ℝ) < ‖c‖ := norm_pos_iff.mpr hc
    have hcn' : (‖c‖ : ℂ) ≠ 0 := by simpa using hc
    have key : ∀ t : ℝ, 0 ≤ t → t < 1 → t * ‖c‖ ≤ ‖x‖ ^ 2 := by
      intro t ht ht1
      have hz : ‖((t : ℂ) * (starRingEnd ℂ) c / (‖c‖ : ℂ))‖ < 1 := by
        rw [norm_div, norm_mul]
        simp only [Complex.norm_real, Real.norm_eq_abs, RCLike.norm_conj]
        rw [abs_of_nonneg ht, abs_of_nonneg (norm_nonneg c), mul_div_assoc,
          div_self hcn.ne']
        simpa using ht1
      have hpos := h _ hz x
      rw [inner_sub_right, inner_smul_right] at hpos
      have hmul : ((t : ℂ) * (starRingEnd ℂ) c / (‖c‖ : ℂ)) * c = ((t * ‖c‖ : ℝ) : ℂ) := by
        have h1 : (starRingEnd ℂ) c * c = ((‖c‖ : ℂ)) ^ 2 := by rw [Complex.conj_mul']
        calc (t:ℂ) * (starRingEnd ℂ) c / (‖c‖:ℂ) * c
            = (t:ℂ) * ((starRingEnd ℂ) c * c) / (‖c‖:ℂ) := by ring
          _ = (t:ℂ) * (‖c‖:ℂ)^2 / (‖c‖:ℂ) := by rw [h1]
          _ = (t:ℂ) * (‖c‖:ℂ) := by field_simp
          _ = ((t * ‖c‖ : ℝ) : ℂ) := by push_cast; ring
      rw [← hcdef, hmul] at hpos
      simp only [Complex.sub_re, Complex.ofReal_re, inner_self_re] at hpos
      linarith
    by_contra hcon
    push_neg at hcon
    rw [one_mul] at hcon
    set t := (‖x‖ ^ 2 / ‖c‖ + 1) / 2 with htdef
    have hx2 : ‖x‖ ^ 2 / ‖c‖ < 1 := (div_lt_one hcn).mpr hcon
    have hx0 : 0 ≤ ‖x‖ ^ 2 / ‖c‖ := by positivity
    have ht0 : 0 ≤ t := by rw [htdef]; linarith
    have ht1 : t < 1 := by rw [htdef]; linarith
    have hkey := key t ht0 ht1
    have hgt : ‖x‖ ^ 2 / ‖c‖ < t := by rw [htdef]; linarith
    rw [div_lt_iff₀ hcn] at hgt
    linarith

/-! ## Pearcy's proof of the Berger power inequality -/

/-- The partial-fraction vectors of Pearcy's argument: `u_k = ∑_{m<n} (ωᵏ z)^m Aᵐ y`. -/
noncomputable def pearcyVec (A : E →L[ℂ] E) (c : ℂ) (n : ℕ) (y : E) : E :=
  ∑ m ∈ Finset.range n, c ^ m • (A ^ m) y

/-- Each partial-fraction vector solves `(1 − c A) u = y − cⁿ Aⁿ y`. -/
theorem pearcyVec_apply (A : E →L[ℂ] E) (c : ℂ) (n : ℕ) (y : E) :
    pearcyVec A c n y - c • A (pearcyVec A c n y) = y - c ^ n • (A ^ n) y := by
  set v : ℕ → E := fun m => c ^ m • (A ^ m) y with hv
  have hcomm : ∀ (m : ℕ), A ((A ^ m) y) = (A ^ m) (A y) := by
    intro m
    rw [← ContinuousLinearMap.mul_apply, ← ContinuousLinearMap.mul_apply, ← pow_succ',
      ← pow_succ]
  have hpow : ∀ (m : ℕ) (z : E), (A ^ m) z = (⇑A)^[m] z := by
    intro m z
    induction m generalizing z with
    | zero => simp
    | succ m ih =>
      rw [pow_succ, ContinuousLinearMap.mul_apply, Function.iterate_succ_apply, ih]
  have hcommI : ∀ (m : ℕ), A ((⇑A)^[m] y) = (⇑A)^[m] (A y) := fun m => by
    rw [← hpow m y, ← hpow m (A y)]
    exact hcomm m
  have hstep : ∀ m, c • A (v m) = v (m + 1) := by
    intro m
    simp [hv, map_smul, pow_succ, pow_succ', smul_smul, mul_comm, hcommI]
  have h1 : A (pearcyVec A c n y) = ∑ m ∈ Finset.range n, A (v m) := by
    simp [pearcyVec, hv, map_sum]
  calc pearcyVec A c n y - c • A (pearcyVec A c n y)
      = (∑ m ∈ Finset.range n, v m) - ∑ m ∈ Finset.range n, c • A (v m) := by
        rw [h1, Finset.smul_sum]; rfl
    _ = ∑ m ∈ Finset.range n, (v m - v (m + 1)) := by
        rw [← Finset.sum_sub_distrib]
        exact Finset.sum_congr rfl fun m _ => by rw [hstep m]
    _ = v 0 - v n := Finset.sum_range_sub' v n
    _ = y - c ^ n • (A ^ n) y := by simp [hv]

/-- The partial-fraction vectors over the `n`-th roots of unity sum to `n · y`. -/
theorem sum_pearcyVec {A : E →L[ℂ] E} {w : ℂ} {n : ℕ} (hn : 0 < n)
    (hw : IsPrimitiveRoot w n) (z : ℂ) (y : E) :
    ∑ k ∈ Finset.range n, pearcyVec A (w ^ k * z) n y = (n : ℂ) • y := by
  have hcoef : ∀ m ∈ Finset.range n,
      (∑ k ∈ Finset.range n, (w ^ k * z) ^ m) = if m = 0 then (n : ℂ) else 0 := by
    intro m hm
    rcases Nat.eq_zero_or_pos m with rfl | hm0
    · simp
    · have hmn : m < n := Finset.mem_range.mp hm
      have hne : w ^ m ≠ 1 := hw.pow_ne_one_of_pos_of_lt hm0.ne' hmn
      have hsplit : ∑ k ∈ Finset.range n, (w ^ k * z) ^ m
          = z ^ m * ∑ k ∈ Finset.range n, (w ^ m) ^ k := by
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun k _ => by
          rw [mul_pow, ← pow_mul, ← pow_mul, mul_comm k m]; ring
      have hone : (w ^ m) ^ n = 1 := by
        rw [← pow_mul, mul_comm, pow_mul, hw.pow_eq_one, one_pow]
      rw [hsplit, geom_sum_eq hne, hone]
      simp [hm0.ne']
  calc ∑ k ∈ Finset.range n, pearcyVec A (w ^ k * z) n y
      = ∑ m ∈ Finset.range n, (∑ k ∈ Finset.range n, (w ^ k * z) ^ m) • (A ^ m) y := by
        simp only [pearcyVec]
        rw [Finset.sum_comm]
        exact Finset.sum_congr rfl fun m _ => by rw [Finset.sum_smul]
    _ = (n : ℂ) • y := by
        rw [Finset.sum_congr rfl (fun m hm => by rw [hcoef m hm])]
        rw [Finset.sum_eq_single 0]
        · simp
        · intro b _ hb; simp [hb]
        · intro hcon; exact absurd (Finset.mem_range.mpr hn) hcon

/-- **The Berger power inequality** `w(Aⁿ) ≤ 1` whenever `w(A) ≤ 1`, by Pearcy's argument. -/
theorem numRadiusLE_pow_one {A : E →L[ℂ] E} (h : NumRadiusLE A 1) (n : ℕ) (hn : 0 < n) :
    NumRadiusLE (A ^ n) 1 := by
  refine numRadiusLE_of_re_inner_sub_smul_nonneg ?_
  intro q hq y
  obtain ⟨z, hz⟩ : ∃ z : ℂ, z ^ n = q := IsAlgClosed.exists_pow_nat_eq q hn
  have hzlt : ‖z‖ < 1 := by
    by_contra hcon
    push_neg at hcon
    have h1 : (1:ℝ) ≤ ‖z‖ ^ n := one_le_pow₀ hcon
    rw [← norm_pow, hz] at h1
    linarith
  set w : ℂ := Complex.exp (2 * Real.pi * Complex.I / n) with hwdef
  have hw : IsPrimitiveRoot w n := Complex.isPrimitiveRoot_exp n hn.ne'
  have hwnorm : ‖w‖ = 1 := Complex.norm_eq_one_of_pow_eq_one hw.pow_eq_one hn.ne'
  set W : E := y - q • (A ^ n) y with hW
  have hsolve : ∀ k : ℕ, pearcyVec A (w ^ k * z) n y
      - (w ^ k * z) • A (pearcyVec A (w ^ k * z) n y) = W := by
    intro k
    rw [pearcyVec_apply, hW]
    congr 2
    rw [mul_pow, ← pow_mul, mul_comm k n, pow_mul, hw.pow_eq_one, one_pow, one_mul, hz]
  have hnorm_c : ∀ k : ℕ, ‖w ^ k * z‖ ≤ 1 := by
    intro k
    rw [norm_mul, norm_pow, hwnorm, one_pow, one_mul]
    exact hzlt.le
  have hterm : ∀ k : ℕ, 0 ≤ (⟪pearcyVec A (w ^ k * z) n y, W⟫_ℂ).re := by
    intro k
    have hk := re_inner_sub_smul_nonneg h (hnorm_c k) (pearcyVec A (w ^ k * z) n y)
    rwa [hsolve k] at hk
  have hsum : ⟪((n : ℂ) • y), W⟫_ℂ
      = ∑ k ∈ Finset.range n, ⟪pearcyVec A (w ^ k * z) n y, W⟫_ℂ := by
    rw [← sum_pearcyVec hn hw z y, sum_inner]
  have hre : 0 ≤ (⟪((n : ℂ) • y), W⟫_ℂ).re := by
    rw [hsum, Complex.re_sum]
    exact Finset.sum_nonneg fun k _ => hterm k
  rw [inner_smul_left] at hre
  simp only [map_natCast, Complex.mul_re, Complex.natCast_re, Complex.natCast_im, zero_mul,
    sub_zero] at hre
  have hn' : (0:ℝ) < (n : ℝ) := by exact_mod_cast hn
  nlinarith [hre]

/-- The homogeneous form of the power inequality: `w(Aⁿ) ≤ w(A)ⁿ`. -/
theorem numRadiusLE_pow {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r) (h : NumRadiusLE A r) (n : ℕ)
    (hn : 0 < n) : NumRadiusLE (A ^ n) (r ^ n) := by
  rcases eq_or_lt_of_le hr with hr0 | hr0
  · -- `r = 0` forces `A = 0`
    have hA : (A : E →ₗ[ℂ] E) = 0 := by
      refine (inner_map_self_eq_zero (A : E →ₗ[ℂ] E)).mp ?_
      intro x
      have hx := h x
      rw [← hr0] at hx
      simp only [zero_mul, norm_le_zero_iff] at hx
      have : (⟪A x, x⟫_ℂ) = (starRingEnd ℂ) (⟪x, A x⟫_ℂ) := (inner_conj_symm _ _).symm
      simp [this, hx]
    have hA0 : A = 0 := by
      ext x
      have := congrArg (fun (T : E →ₗ[ℂ] E) => T x) hA
      simpa using this
    intro x
    rw [hA0]
    simp [zero_pow hn.ne']
    positivity
  · -- scale to numerical radius `1`
    set B : E →L[ℂ] E := (r : ℂ)⁻¹ • A with hB
    have hB1 : NumRadiusLE B 1 := by
      intro x
      have hx := h x
      rw [hB]
      simp only [ContinuousLinearMap.smul_apply, inner_smul_right, norm_mul, norm_inv]
      rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr0]
      rw [inv_mul_le_iff₀ hr0]
      calc ‖(⟪x, A x⟫_ℂ)‖ ≤ r * ‖x‖ ^ 2 := hx
        _ = r * (1 * ‖x‖ ^ 2) := by ring
    have hBn := numRadiusLE_pow_one hB1 n hn
    intro x
    have hBpow : (B ^ n) x = ((r : ℂ)⁻¹) ^ n • (A ^ n) x := by
      rw [hB, smul_pow]
      simp
    have hx := hBn x
    rw [hBpow, inner_smul_right, norm_mul] at hx
    have hrn : ‖(((r : ℂ)⁻¹) ^ n)‖ = (r ^ n)⁻¹ := by
      rw [norm_pow, norm_inv, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr0, ← inv_pow]
    rw [hrn, one_mul, inv_mul_le_iff₀ (by positivity)] at hx
    calc ‖(⟪x, (A ^ n) x⟫_ℂ)‖ ≤ r ^ n * ‖x‖ ^ 2 := by linarith [hx]
      _ = r ^ n * ‖x‖ ^ 2 := rfl

/-! ## From the numerical radius to the operator norm -/

/-- The polarization bound `‖⟪A y, x⟫‖ ≤ w(A) (‖x‖² + ‖y‖²)`. -/
theorem inner_polar_bound {A : E →L[ℂ] E} {r : ℝ} (h : NumRadiusLE A r) (x y : E) :
    ‖(⟪A y, x⟫_ℂ)‖ ≤ r * (‖x‖ ^ 2 + ‖y‖ ^ 2) := by
  have hQ : ∀ u : E, ‖(⟪A u, u⟫_ℂ)‖ ≤ r * ‖u‖ ^ 2 := by
    intro u
    have hcs : (⟪A u, u⟫_ℂ) = (starRingEnd ℂ) (⟪u, A u⟫_ℂ) := (inner_conj_symm _ _).symm
    rw [hcs, RCLike.norm_conj]
    exact h u
  have key := inner_map_polarization (A : E →ₗ[ℂ] E) x y
  simp only [ContinuousLinearMap.coe_coe] at key
  rw [key]
  have e1 : ‖(⟪A (x + y), x + y⟫_ℂ)‖ ≤ r * ‖x + y‖ ^ 2 := hQ _
  have e2 : ‖(⟪A (x - y), x - y⟫_ℂ)‖ ≤ r * ‖x - y‖ ^ 2 := hQ _
  have e3 : ‖(⟪A (x + Complex.I • y), x + Complex.I • y⟫_ℂ)‖
      ≤ r * ‖x + Complex.I • y‖ ^ 2 := hQ _
  have e4 : ‖(⟪A (x - Complex.I • y), x - Complex.I • y⟫_ℂ)‖
      ≤ r * ‖x - Complex.I • y‖ ^ 2 := hQ _
  have hpar1 : ‖x + y‖ ^ 2 + ‖x - y‖ ^ 2 = 2 * (‖x‖ ^ 2 + ‖y‖ ^ 2) := by
    simpa [pow_two] using parallelogram_law_with_norm ℂ x y
  have hpar2 : ‖x + Complex.I • y‖ ^ 2 + ‖x - Complex.I • y‖ ^ 2
      = 2 * (‖x‖ ^ 2 + ‖y‖ ^ 2) := by
    simpa [pow_two, norm_smul] using parallelogram_law_with_norm ℂ x (Complex.I • y)
  have hdiv : ∀ a b c d : ℂ, ‖(a - b + Complex.I * c - Complex.I * d) / 4‖
      ≤ (‖a‖ + ‖b‖ + ‖c‖ + ‖d‖) / 4 := by
    intro a b c d
    rw [norm_div]
    simp only [Complex.norm_ofNat]
    gcongr
    calc ‖a - b + Complex.I * c - Complex.I * d‖
        ≤ ‖a - b + Complex.I * c‖ + ‖Complex.I * d‖ := norm_sub_le _ _
      _ ≤ (‖a - b‖ + ‖Complex.I * c‖) + ‖Complex.I * d‖ := by gcongr; exact norm_add_le _ _
      _ ≤ ((‖a‖ + ‖b‖) + ‖Complex.I * c‖) + ‖Complex.I * d‖ := by gcongr; exact norm_sub_le _ _
      _ = ‖a‖ + ‖b‖ + ‖c‖ + ‖d‖ := by simp
  refine le_trans (hdiv _ _ _ _) ?_
  rw [div_le_iff₀ (by norm_num : (0:ℝ) < 4)]
  have hr1 : r * (‖x + y‖ ^ 2 + ‖x - y‖ ^ 2) = r * (2 * (‖x‖ ^ 2 + ‖y‖ ^ 2)) := by rw [hpar1]
  have hr2 : r * (‖x + Complex.I • y‖ ^ 2 + ‖x - Complex.I • y‖ ^ 2)
      = r * (2 * (‖x‖ ^ 2 + ‖y‖ ^ 2)) := by rw [hpar2]
  nlinarith [e1, e2, e3, e4, hr1, hr2]

/-- **`‖A‖ ≤ 2 w(A)`**, by polarization. -/
theorem norm_le_two_mul_of_numRadiusLE {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r)
    (h : NumRadiusLE A r) : ‖A‖ ≤ 2 * r := by
  refine ContinuousLinearMap.opNorm_le_bound _ (by linarith) fun y => ?_
  rcases eq_or_ne (A y) 0 with hAy | hAy
  · rw [hAy]
    simp
    positivity
  · have hAy0 : 0 < ‖A y‖ := norm_pos_iff.mpr hAy
    have hy0 : 0 < ‖y‖ := by
      rcases eq_or_ne y 0 with rfl | hy
      · simp at hAy
      · exact norm_pos_iff.mpr hy
    set t : ℝ := ‖y‖ / ‖A y‖ with ht
    have htv : t * ‖A y‖ = ‖y‖ := by rw [ht, div_mul_cancel₀ _ hAy0.ne']
    have ht0 : 0 ≤ t := by positivity
    have hb := inner_polar_bound h ((t : ℂ) • A y) y
    have hinner : (⟪A y, (t : ℂ) • A y⟫_ℂ) = ((t * ‖A y‖ ^ 2 : ℝ) : ℂ) := by
      rw [inner_smul_right, inner_self_eq_norm_sq_to_K]
      push_cast
      rfl
    have hnormx : ‖((t : ℂ) • A y)‖ = t * ‖A y‖ := by
      rw [norm_smul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg ht0]
    have habs : ‖(((t * ‖A y‖ ^ 2 : ℝ)) : ℂ)‖ = t * ‖A y‖ ^ 2 := by
      rw [Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    rw [hinner, hnormx, habs] at hb
    have hleft : t * ‖A y‖ ^ 2 = ‖y‖ * ‖A y‖ := by
      rw [pow_two, ← mul_assoc, htv]
    rw [hleft, htv] at hb
    nlinarith [hb, hy0]

/-- The powers of an operator with numerical range in the disc of radius `r` obey
`‖Aⁿ‖ ≤ 2 rⁿ`. -/
theorem norm_pow_le_of_numRadiusLE {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r)
    (h : NumRadiusLE A r) (n : ℕ) (hn : 0 < n) : ‖A ^ n‖ ≤ 2 * r ^ n :=
  norm_le_two_mul_of_numRadiusLE (by positivity) (numRadiusLE_pow hr h n hn)

/-! ## The Crouzeix-type bound for the analytic functional calculus -/

/-- The analytic functional calculus of a power series: `f(A) = ∑ aₙ Aⁿ`. -/
noncomputable def analyticFC (a : ℕ → ℂ) (A : E →L[ℂ] E) : E →L[ℂ] E :=
  ∑' n : ℕ, a n • A ^ n

/-- The termwise bound behind the Crouzeix-type estimate. -/
theorem norm_term_le [CompleteSpace E] {A : E →L[ℂ] E} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumRadiusLE A r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) (n : ℕ) (hn : 0 < n) :
    ‖a n • A ^ n‖ ≤ 2 * M * (r / R) ^ n := by
  have hR0 : 0 < R := lt_of_le_of_lt hr hR
  have hRn : 0 < R ^ n := by positivity
  have h1 : ‖a n • A ^ n‖ = ‖a n‖ * ‖A ^ n‖ := by rw [norm_smul]
  rw [h1]
  have h2 : ‖A ^ n‖ ≤ 2 * r ^ n := norm_pow_le_of_numRadiusLE hr h n hn
  have h3 : ‖a n‖ ≤ M / R ^ n := ha n
  have h4 : (0:ℝ) ≤ ‖A ^ n‖ := norm_nonneg _
  have h5 : ‖a n‖ * ‖A ^ n‖ ≤ (M / R ^ n) * (2 * r ^ n) := by
    apply mul_le_mul h3 h2 h4
    positivity
  calc ‖a n‖ * ‖A ^ n‖ ≤ (M / R ^ n) * (2 * r ^ n) := h5
    _ = 2 * M * (r / R) ^ n := by
        rw [div_pow]
        field_simp

/-- Under the Cauchy estimate `‖aₙ‖ ≤ M / Rⁿ` with `R > r ≥ w(A)`, the series defining the
analytic functional calculus converges absolutely in operator norm. -/
theorem summable_analyticFC [CompleteSpace E] {A : E →L[ℂ] E} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumRadiusLE A r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) : Summable fun n : ℕ => a n • A ^ n := by
  have hR0 : 0 < R := lt_of_le_of_lt hr hR
  have hq0 : 0 ≤ r / R := by positivity
  have hq1 : r / R < 1 := (div_lt_one hR0).mpr hR
  have hgeo : Summable fun n : ℕ => 2 * M * (r / R) ^ n :=
    (summable_geometric_of_lt_one hq0 hq1).mul_left _
  refine Summable.of_norm_bounded hgeo ?_
  intro n
  rcases Nat.eq_zero_or_pos n with rfl | hn
  · have h2 : ‖a 0‖ ≤ M := by simpa using ha 0
    have hone : ‖(1 : E →L[ℂ] E)‖ ≤ 1 := by
      rw [show (1 : E →L[ℂ] E) = ContinuousLinearMap.id ℂ E from rfl]
      exact ContinuousLinearMap.norm_id_le
    have h1 : ‖a 0 • A ^ 0‖ ≤ ‖a 0‖ := by
      rw [norm_smul, pow_zero]
      nlinarith [norm_nonneg (a 0), norm_nonneg (1 : E →L[ℂ] E)]
    calc ‖a 0 • A ^ 0‖ ≤ M := le_trans h1 h2
      _ ≤ 2 * M * (r / R) ^ 0 := by simp; linarith
  · exact norm_term_le hr hM hR h ha n hn

/-- **Crouzeix's inequality for a general operator, from the numerical range, with an
explicit larger constant.**  If the numerical range of `A` lies in the closed disc of
radius `r` and `f(z) = ∑ aₙ zⁿ` obeys Cauchy's estimate `‖aₙ‖ ≤ M/Rⁿ` on the strictly
larger disc of radius `R`, then `‖f(A)‖ ≤ (1 + 2r/(R − r)) M`. -/
theorem crouzeix_disc [CompleteSpace E] {A : E →L[ℂ] E} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumRadiusLE A r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) :
    ‖analyticFC a A‖ ≤ (1 + 2 * r / (R - r)) * M := by
  have hR0 : 0 < R := lt_of_le_of_lt hr hR
  have hRr : (0:ℝ) < R - r := by linarith
  have hq0 : 0 ≤ r / R := by positivity
  have hq1 : r / R < 1 := (div_lt_one hR0).mpr hR
  have hsum : Summable fun n : ℕ => a n • A ^ n := summable_analyticFC hr hM hR h ha
  have hhead : ‖a 0 • A ^ 0‖ ≤ M := by
    have h2 : ‖a 0‖ ≤ M := by simpa using ha 0
    have hone : ‖(1 : E →L[ℂ] E)‖ ≤ 1 := by
      rw [show (1 : E →L[ℂ] E) = ContinuousLinearMap.id ℂ E from rfl]
      exact ContinuousLinearMap.norm_id_le
    have h1 : ‖a 0 • A ^ 0‖ ≤ ‖a 0‖ := by
      rw [norm_smul, pow_zero]
      nlinarith [norm_nonneg (a 0), norm_nonneg (1 : E →L[ℂ] E)]
    linarith
  have hsplit : analyticFC a A = a 0 • A ^ 0 + ∑' n : ℕ, a (n + 1) • A ^ (n + 1) := by
    rw [analyticFC, hsum.tsum_eq_zero_add]
  have hgeo : HasSum (fun n : ℕ => (2 * M * (r / R)) * (r / R) ^ n)
      ((2 * M * (r / R)) * (1 - r / R)⁻¹) :=
    (hasSum_geometric_of_lt_one hq0 hq1).mul_left _
  have hval : (2 * M * (r / R)) * (1 - r / R)⁻¹ = 2 * M * (r / (R - r)) := by
    have h1 : (1 : ℝ) - r / R = (R - r) / R := by field_simp
    rw [h1]
    field_simp
  rw [hval] at hgeo
  have htail : ‖∑' n : ℕ, a (n + 1) • A ^ (n + 1)‖ ≤ 2 * M * (r / (R - r)) := by
    refine tsum_of_norm_bounded hgeo fun n => ?_
    refine le_trans (norm_term_le hr hM hR h ha (n + 1) (Nat.succ_pos n)) ?_
    rw [pow_succ]
    ring_nf
    exact le_of_eq (by ring)
  rw [hsplit]
  calc ‖a 0 • A ^ 0 + ∑' n : ℕ, a (n + 1) • A ^ (n + 1)‖
      ≤ ‖a 0 • A ^ 0‖ + ‖∑' n : ℕ, a (n + 1) • A ^ (n + 1)‖ := norm_add_le _ _
    _ ≤ M + 2 * M * (r / (R - r)) := by linarith
    _ = (1 + 2 * r / (R - r)) * M := by field_simp

/-! ## The shifted disc: a numerical range in an arbitrary closed ball -/

/-- The numerical range of `A` lies in the closed ball of centre `c` and radius `r`: the
numerical radius of the shifted operator `A - c` is at most `r`. -/
def NumBallLE (A : E →L[ℂ] E) (c : ℂ) (r : ℝ) : Prop :=
  NumRadiusLE (A - c • (1 : E →L[ℂ] E)) r



/-- `NumBallLE` is exactly the inclusion of the numerical range in a closed ball. -/
theorem numBallLE_iff_numRange_subset [CompleteSpace E] (A : E →L[ℂ] E) (c : ℂ) {r : ℝ} :
    NumBallLE A c r ↔ BookProof.ChapterH9.numRange A ⊆ Metric.closedBall c r := by
  rw [NumBallLE, numRadiusLE_iff_numRange_subset]
  constructor
  · rintro h w ⟨x, hx, rfl⟩
    have hmem : (⟪ x, (A - c • (1 : E →L[ℂ] E)) x ⟫_ℂ)
        ∈ BookProof.ChapterH9.numRange (A - c • (1 : E →L[ℂ] E)) :=
      BookProof.ChapterH9.mem_numRange x hx
    have hb := h hmem
    rw [Metric.mem_closedBall, Complex.dist_eq, inner_sub_const_smul A c x, hx] at hb
    rw [Metric.mem_closedBall, Complex.dist_eq]
    simp only [ContinuousLinearMap.coe_coe]
    simpa using hb
  · rintro h w ⟨x, hx, rfl⟩
    have hb := h (BookProof.ChapterH9.mem_numRange (X := A) x hx)
    rw [Metric.mem_closedBall, Complex.dist_eq] at hb
    rw [Metric.mem_closedBall, Complex.dist_eq]
    simp only [ContinuousLinearMap.coe_coe]
    rw [inner_sub_const_smul A c x, hx]
    simpa using hb

/-- **Crouzeix's inequality from a numerical range in an arbitrary disc.**  If the
numerical range of `A` lies in the closed ball of centre `c` and radius `r`, and
`f(z) = ∑ aₙ (z - c)ⁿ` obeys Cauchy's estimate `‖aₙ‖ ≤ M/Rⁿ` on the strictly larger ball of
radius `R` about `c`, then `‖f(A)‖ ≤ (1 + 2r/(R - r)) M`, where `f(A) = ∑ aₙ (A - c)ⁿ`. -/
theorem crouzeix_ball [CompleteSpace E] {A : E →L[ℂ] E} {c : ℂ} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumBallLE A c r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) :
    ‖analyticFC a (A - c • (1 : E →L[ℂ] E))‖ ≤ (1 + 2 * r / (R - r)) * M :=
  crouzeix_disc hr hM hR h ha

end BookProof.ChapterNumericalRangeCrouzeix
