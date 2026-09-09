import Mathlib
import BookProof.ChapterFockPairPerturbation

/-!
# Chapter FockCubicUnbounded — the quadratic degree is the boundary

`ChapterFockFieldPerturbation` proves that a gap survives a *linear* field coupling
`Φ(f) = a†(f) + a(f)`, and `ChapterFockPairPerturbation` that it survives a *quadratic*,
pair-creating coupling `P(f,g) = a†(f)a†(g) + a(g)a(f)`.  Both proceed by dominating the
perturbing form by the free form `Re⟪u, dΓ(h)u⟫`.  Every status update of
`CONSOLIDATED_PLAN.md` then records the same honest boundary: the *cubic and quartic*
Yang–Mills interaction terms are not covered.

This chapter shows that this is not a gap in the write-up but a fact about the route: the
domination that the linear and quadratic couplings admit **fails outright** at degree three.

## Deliverables

* `cubeA k` — the single-mode cubic field term `C_k = (a_k†)³ + (a_k)³`, self-adjoint,
  unbounded, and changing the particle number by three;
* `trial_numberQuad`, `trial_norm_sq`, `trial_cubic_form` — the exact values of the three
  relevant quantities on the two-term trial states `|n⟩ + c|n+3⟩`: the number form
  `n + (n+3)c²`, the squared norm `1 + c²`, and the cubic form `2c√((n+1)(n+2)(n+3))`;
* **`cubic_no_relative_form_bound`** — for *every* pair of constants `a, b` there is a
  vacuum-orthogonal finite-particle state with
  `a·⟪u, N u⟫ + b‖u‖² < Re⟪u, C_k u⟫`.  So the cubic term admits **no** relative form bound
  of the shape `|v| ≤ a q + b‖·‖²` against the number form — the hypothesis of
  `FockInteractionStability.gap_persists_of_relative_form_bound` can never be met by it,
  however small the coupling constant is made;
* **`fock_gap_fails_for_cubic`** — the consequence for the gap: for the free Fock
  Hamiltonian `dΓ(N)` (one-particle gap `1`) and *any* coupling strength `lam > 0`, the
  perturbed form `dΓ(N) + lam·C_k` is **unbounded below** on the vacuum-orthogonal sector:
  for every `M` there is a vacuum-orthogonal state with
  `Re⟪u, dΓ(N)u⟫ + lam·Re⟪u, C_k u⟫ ≤ -M‖u‖²`.

Together with `ChapterFockPairPerturbation`, this locates the boundary exactly: degree two
survives (with a smallness condition), degree three does not survive at all.

A final section makes the complementary point precise.  `quartA k = (a_k†)²(a_k)²` is the
normal-ordered quartic term, diagonal with eigenvalue `m(m − 1)` (`quartA_single_confAt`,
`trial_quartic_form`), and **`trial_cubic_quartic_bounded_below`** shows that on the very
family of states that drives `dΓ(N) + lam·C_k` to `-∞`, the sum
`dΓ(N) + lam·C_k + Q_k` is bounded below by `-(lam⁴/4 + 2lam²)‖u‖²`, uniformly in the
occupation number and in the mixing coefficient.  The divergence above is therefore a
property of a *bare* cubic term.

## Honest boundary

`C_k` is a single-mode cubic term, not the full Yang–Mills cubic vertex; what is proved is
that *this* form-domination route cannot reach degree three, not that no gap exists for the
physical theory — a physical cubic term is accompanied by a quartic term which is bounded
below, and controlling their sum in general is a different problem, of which only the
statement along the above trial family is proved here.  `1.932` remains a certified
truncated number; no mass gap of the physical Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockCubicUnbounded

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

/-! ## 1. Single-mode configurations -/

/-- The occupation-`m` configuration of the mode `k`. -/
def confAt (k m : ℕ) : Conf := Finsupp.single k m

theorem confAt_self (k m : ℕ) : confAt k m k = m := by simp [confAt]

theorem confAt_injective (k : ℕ) {m m' : ℕ} (h : confAt k m = confAt k m') : m = m' := by
  have := congrArg (fun β : Conf => β k) h
  simpa [confAt_self] using this

theorem up_confAt (k m : ℕ) : up k (confAt k m) = confAt k (m + 1) := by
  refine Finsupp.ext fun i => ?_
  rcases eq_or_ne i k with rfl | h
  · simp [up, confAt]
  · rw [up_of_ne _ h]
    simp [confAt, h]

theorem dn_confAt (k m : ℕ) : dn k (confAt k m) = confAt k (m - 1) := by
  refine Finsupp.ext fun i => ?_
  rcases eq_or_ne i k with rfl | h
  · simp [dn, confAt]
  · rw [dn_of_ne _ h]
    simp [confAt, h]

theorem confAt_ne_zero {k m : ℕ} (h : m ≠ 0) : confAt k m ≠ 0 := by
  intro hc
  have := congrArg (fun β : Conf => β k) hc
  simp only [confAt_self] at this
  exact h this

theorem confNumber_confAt (k m : ℕ) : confNumber (confAt k m) = m := by
  classical
  rcases eq_or_ne m 0 with rfl | hm
  · simp [confAt, confNumber]
  · have hsupp : (confAt k m).support = {k} :=
      Finsupp.support_single_ne_zero k hm
    simp [confNumber, hsupp, confAt_self]

/-! ## 2. The cubic field term -/

/-- **The single-mode cubic field term** `C_k = (a_k†)³ + (a_k)³`: it is unbounded and
changes the particle number by three. -/
def cubeA (k : ℕ) : FockAlg →ₗ[ℂ] FockAlg :=
  (creA k).comp ((creA k).comp (creA k)) + (annA k).comp ((annA k).comp (annA k))

theorem cubeA_apply (k : ℕ) (x : FockAlg) :
    cubeA k x = creA k (creA k (creA k x)) + annA k (annA k (annA k x)) := rfl

/-- The coordinates of the cubic term. -/
theorem cubeA_coord (k : ℕ) (x : FockAlg) (γ : Conf) :
    cubeA k x γ
      = ((Real.sqrt (γ k) : ℝ) : ℂ) * ((Real.sqrt ((dn k γ) k) : ℝ) : ℂ)
          * ((Real.sqrt ((dn k (dn k γ)) k) : ℝ) : ℂ) * x (dn k (dn k (dn k γ)))
        + ((Real.sqrt ((γ k : ℝ) + 1) : ℝ) : ℂ)
            * ((Real.sqrt (((up k γ) k : ℝ) + 1) : ℝ) : ℂ)
            * ((Real.sqrt (((up k (up k γ)) k : ℝ) + 1) : ℝ) : ℂ)
            * x (up k (up k (up k γ))) := by
  rw [cubeA_apply, Finsupp.add_apply, creA_apply, creA_apply, creA_apply,
    annA_apply, annA_apply, annA_apply]
  ring

/-! ## 3. The two-term trial states -/

/-- The trial state `|n⟩ + c|n+3⟩` of the mode `k`. -/
def trial (k n : ℕ) (c : ℝ) : FockAlg :=
  Finsupp.single (confAt k n) 1 + Finsupp.single (confAt k (n + 3)) ((c : ℝ) : ℂ)

theorem trial_support_subset (k n : ℕ) (c : ℝ) :
    (trial k n c).support ⊆ {confAt k n, confAt k (n + 3)} := by
  classical
  intro γ hγ
  by_contra hcon
  simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hcon
  have : trial k n c γ = 0 := by
    simp [trial, Ne.symm hcon.1, Ne.symm hcon.2]
  exact (Finsupp.mem_support_iff.mp hγ) this

theorem trial_at_n (k n : ℕ) (c : ℝ) : trial k n c (confAt k n) = 1 := by
  have hne : confAt k (n + 3) ≠ confAt k n := by
    intro h
    have := confAt_injective k h
    omega
  simp [trial, hne]

theorem trial_at_n3 (k n : ℕ) (c : ℝ) :
    trial k n c (confAt k (n + 3)) = ((c : ℝ) : ℂ) := by
  have hne : confAt k n ≠ confAt k (n + 3) := by
    intro h
    have := confAt_injective k h
    omega
  simp [trial, hne]

theorem trial_at_other {k n : ℕ} {c : ℝ} {m : ℕ} (h1 : m ≠ n) (h2 : m ≠ n + 3) :
    trial k n c (confAt k m) = 0 := by
  have hne1 : confAt k n ≠ confAt k m := fun h => h1 (confAt_injective k h).symm
  have hne2 : confAt k (n + 3) ≠ confAt k m := fun h => h2 (confAt_injective k h).symm
  simp [trial, hne1, hne2]

theorem trial_vacuum_orthogonal {k n : ℕ} (hn : n ≠ 0) (c : ℝ) : trial k n c 0 = 0 := by
  have h0 : (0 : Conf) = confAt k 0 := by simp [confAt]
  rw [h0]
  exact trial_at_other (by omega) (by omega)

/-! ## 4. The three quantities on a trial state -/

theorem trial_norm_sq (k n : ℕ) (c : ℝ) : ‖toLp (trial k n c)‖ ^ 2 = 1 + c ^ 2 := by
  classical
  have hne : confAt k n ≠ confAt k (n + 3) := by
    intro h
    have := confAt_injective k h
    omega
  have hinner := inner_toLp_of_subset (trial_support_subset k n c) (trial k n c)
  have hsum : (inner ℂ (toLp (trial k n c)) (toLp (trial k n c)) : ℂ)
      = ((1 + c ^ 2 : ℝ) : ℂ) := by
    rw [hinner, Finset.sum_insert (by simpa using hne), Finset.sum_singleton,
      trial_at_n, trial_at_n3]
    push_cast
    simp [Complex.conj_ofReal]
    ring
  have := congrArg Complex.re hsum
  rw [inner_self_eq_norm_sq_to_K] at this
  simpa [← Complex.ofReal_pow] using this

theorem trial_numberQuad (k n : ℕ) (c : ℝ) :
    numberQuad (trial k n c) = (n : ℝ) + ((n : ℝ) + 3) * c ^ 2 := by
  classical
  have hne : confAt k n ≠ confAt k (n + 3) := by
    intro h
    have := confAt_injective k h
    omega
  have hcoord : ∀ γ : Conf, dGamma numberCol (trial k n c) γ
      = ((confNumber γ : ℝ) : ℂ) * trial k n c γ := by
    intro γ
    rw [numberCol, dGamma_diagCol_apply, confEnergy_one]
  have hinner := inner_toLp_of_subset (trial_support_subset k n c)
    (dGamma numberCol (trial k n c))
  have hsum : (inner ℂ (toLp (trial k n c)) (toLp (dGamma numberCol (trial k n c))) : ℂ)
      = (((n : ℝ) + ((n : ℝ) + 3) * c ^ 2 : ℝ) : ℂ) := by
    rw [hinner, Finset.sum_insert (by simpa using hne), Finset.sum_singleton,
      hcoord, hcoord, trial_at_n, trial_at_n3, confNumber_confAt, confNumber_confAt]
    push_cast
    simp [Complex.conj_ofReal]
    ring
  have := congrArg Complex.re hsum
  simpa [numberQuad, ← Complex.ofReal_pow] using this

theorem trial_cubic_form (k n : ℕ) (hn : 1 ≤ n) (c : ℝ) :
    (inner ℂ (toLp (trial k n c)) (toLp (cubeA k (trial k n c))) : ℂ).re
      = 2 * c * (Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2) * ((n : ℝ) + 3))) := by
  classical
  have hne : confAt k n ≠ confAt k (n + 3) := by
    intro h
    have := confAt_injective k h
    omega
  have hsqrt : Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2) * ((n : ℝ) + 3))
      = Real.sqrt ((n : ℝ) + 1) * Real.sqrt ((n : ℝ) + 2) * Real.sqrt ((n : ℝ) + 3) := by
    rw [Real.sqrt_mul (by positivity), Real.sqrt_mul (by positivity)]
  have hval_n : cubeA k (trial k n c) (confAt k n)
      = ((c : ℝ) : ℂ)
          * ((Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2) * ((n : ℝ) + 3)) : ℝ) : ℂ) := by
    rw [cubeA_coord]
    simp only [dn_confAt, up_confAt, confAt_self]
    rw [trial_at_other (k := k) (c := c) (m := n - 1 - 1 - 1) (by omega) (by omega),
      show n + 1 + 1 + 1 = n + 3 from by omega, trial_at_n3, hsqrt]
    push_cast
    ring_nf
  have hval_n3 : cubeA k (trial k n c) (confAt k (n + 3))
      = ((Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2) * ((n : ℝ) + 3)) : ℝ) : ℂ) := by
    have e1 : n + 3 - 1 = n + 2 := by omega
    have e2 : n + 2 - 1 = n + 1 := by omega
    have e3 : n + 1 - 1 = n := by omega
    rw [cubeA_coord]
    simp only [dn_confAt, up_confAt, confAt_self, e1, e2, e3]
    rw [trial_at_n, trial_at_other (k := k) (c := c) (by omega) (by omega), hsqrt]
    push_cast
    ring
  have hinner := inner_toLp_of_subset (trial_support_subset k n c) (cubeA k (trial k n c))
  have hsum : (inner ℂ (toLp (trial k n c)) (toLp (cubeA k (trial k n c))) : ℂ)
      = ((2 * c * Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2) * ((n : ℝ) + 3)) : ℝ) : ℂ) := by
    rw [hinner, Finset.sum_insert (by simpa using hne), Finset.sum_singleton,
      hval_n, hval_n3, trial_at_n, trial_at_n3]
    push_cast
    simp [Complex.conj_ofReal]
    ring
  have := congrArg Complex.re hsum
  simpa using this

/-! ## 5. No relative form bound at degree three -/

/-- **The cubic term admits no relative form bound against the number form.**  For every
pair of constants `a, b` there is a vacuum-orthogonal finite-particle state on which the
cubic form exceeds `a⟪u, N u⟫ + b‖u‖²`.  Consequently the domination hypothesis of
`FockInteractionStability.gap_persists_of_relative_form_bound` — the hypothesis that both
`ChapterFockFieldPerturbation` and `ChapterFockPairPerturbation` verify at degrees one and
two — is unattainable at degree three. -/
theorem cubic_no_relative_form_bound (k : ℕ) (a b : ℝ) :
    ∃ u : FockAlg, u 0 = 0 ∧
      a * numberQuad u + b * ‖toLp u‖ ^ 2
        < (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re := by
  obtain ⟨n, hn⟩ := exists_nat_gt (((3 * |a| + 2 * |b|) / 2) ^ 2 + 1)
  have hnpos : 1 ≤ n := by
    by_contra hcon
    have hn0 : n = 0 := by omega
    rw [hn0] at hn
    have : (0 : ℝ) ≤ ((3 * |a| + 2 * |b|) / 2) ^ 2 := sq_nonneg _
    simp at hn
    linarith
  refine ⟨trial k n 1, trial_vacuum_orthogonal (by omega) 1, ?_⟩
  rw [trial_numberQuad, trial_norm_sq, trial_cubic_form k n hnpos 1]
  set s := Real.sqrt ((n : ℝ) + 1) with hsdef
  have hs0 : 0 ≤ s := Real.sqrt_nonneg _
  have hs2 : s ^ 2 = (n : ℝ) + 1 := Real.sq_sqrt (by positivity)
  have hs1 : 1 ≤ s := by nlinarith [Nat.cast_nonneg (α := ℝ) n]
  have hlow : ((n : ℝ) + 1) * s
      ≤ Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2) * ((n : ℝ) + 3)) := by
    rw [Real.le_sqrt (by positivity)]
    · nlinarith [Nat.cast_nonneg (α := ℝ) n]
    · positivity
  have hK : a * ((n : ℝ) + ((n : ℝ) + 3) * 1 ^ 2) + b * (1 + 1 ^ 2)
      ≤ (3 * |a| + 2 * |b|) * ((n : ℝ) + 1) := by
    nlinarith [le_abs_self a, le_abs_self b, abs_nonneg a, abs_nonneg b,
      Nat.cast_nonneg (α := ℝ) n]
  have hbig : (3 * |a| + 2 * |b|) / 2 < s := by
    have hsq : ((3 * |a| + 2 * |b|) / 2) ^ 2 < s ^ 2 := by
      rw [hs2]; linarith
    nlinarith [abs_nonneg a, abs_nonneg b]
  nlinarith [mul_le_mul_of_nonneg_left hlow (by norm_num : (0 : ℝ) ≤ 2)]

/-- **A cubic perturbation destroys the gap, at every coupling strength.**  For the free
Fock Hamiltonian `dΓ(N)`, whose one-particle gap is `1`, and any `lam > 0`, the perturbed
form is unbounded below on the vacuum-orthogonal sector. -/
theorem fock_gap_fails_for_cubic (k : ℕ) {lam : ℝ} (hlam : 0 < lam) (M : ℝ) :
    ∃ u : FockAlg, u 0 = 0 ∧
      (inner ℂ (toLp u) (toLp (dGamma numberCol u)) : ℂ).re
          + lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
        ≤ -M * ‖toLp u‖ ^ 2 := by
  obtain ⟨n, hn⟩ := exists_nat_gt (((3 + 2 * |M|) / (2 * lam)) ^ 2 + 1)
  have hnpos : 1 ≤ n := by
    by_contra hcon
    have hn0 : n = 0 := by omega
    rw [hn0] at hn
    have : (0 : ℝ) ≤ ((3 + 2 * |M|) / (2 * lam)) ^ 2 := sq_nonneg _
    simp at hn
    linarith
  refine ⟨trial k n (-1), trial_vacuum_orthogonal (by omega) (-1), ?_⟩
  have hnum : (inner ℂ (toLp (trial k n (-1)))
      (toLp (dGamma numberCol (trial k n (-1)))) : ℂ).re = numberQuad (trial k n (-1)) := rfl
  rw [hnum, trial_numberQuad, trial_norm_sq, trial_cubic_form k n hnpos (-1)]
  set s := Real.sqrt ((n : ℝ) + 1) with hsdef
  have hs0 : 0 ≤ s := Real.sqrt_nonneg _
  have hs2 : s ^ 2 = (n : ℝ) + 1 := Real.sq_sqrt (by positivity)
  have hs1 : 1 ≤ s := by nlinarith [Nat.cast_nonneg (α := ℝ) n]
  have hlow : ((n : ℝ) + 1) * s
      ≤ Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2) * ((n : ℝ) + 3)) := by
    rw [Real.le_sqrt (by positivity)]
    · nlinarith [Nat.cast_nonneg (α := ℝ) n]
    · positivity
  have hM : (n : ℝ) + ((n : ℝ) + 3) * (-1 : ℝ) ^ 2 + M * (1 + (-1 : ℝ) ^ 2)
      ≤ (3 + 2 * |M|) * ((n : ℝ) + 1) := by
    nlinarith [le_abs_self M, abs_nonneg M, Nat.cast_nonneg (α := ℝ) n]
  have hbig : (3 + 2 * |M|) / (2 * lam) < s := by
    have hsq : ((3 + 2 * |M|) / (2 * lam)) ^ 2 < s ^ 2 := by
      rw [hs2]; linarith
    have hnn : 0 ≤ (3 + 2 * |M|) / (2 * lam) := by positivity
    nlinarith
  have hbig' : 3 + 2 * |M| < 2 * lam * s := by
    rw [div_lt_iff₀ (by positivity)] at hbig
    linarith
  nlinarith [mul_le_mul_of_nonneg_left hlow (le_of_lt hlam),
    mul_nonneg (Nat.cast_nonneg (α := ℝ) n) hs0]

/-! ## 6. The quartic term restores a lower bound on the same witnesses -/

/-- **The single-mode quartic (normal-ordered) term** `Q_k = (a_k†)²(a_k)²`, which acts
diagonally with eigenvalue `m(m − 1)` on the occupation-`m` state of the mode `k`. -/
def quartA (k : ℕ) : FockAlg →ₗ[ℂ] FockAlg :=
  (creA k).comp ((creA k).comp ((annA k).comp (annA k)))

theorem quartA_single_confAt (k m : ℕ) (z : ℂ) :
    quartA k (Finsupp.single (confAt k m) z)
      = Finsupp.single (confAt k m) ((((m : ℝ) * ((m : ℝ) - 1) : ℝ) : ℂ) * z) := by
  match m with
  | 0 => simp [quartA, confAt_self, dn_confAt]
  | 1 => simp [quartA, confAt_self, dn_confAt]
  | (m + 2) =>
      have e1 : m + 2 - 1 = m + 1 := by omega
      have e2 : m + 1 - 1 = m := by omega
      simp only [quartA, LinearMap.comp_apply, annA_single, creA_single,
        confAt_self, dn_confAt, up_confAt, e1, e2, Finsupp.smul_single,
        smul_eq_mul]
      congr 1
      have hs1 : Real.sqrt ((m : ℝ) + 1) * Real.sqrt ((m : ℝ) + 1) = (m : ℝ) + 1 :=
        Real.mul_self_sqrt (by positivity)
      have hs2 : Real.sqrt ((m : ℝ) + 2) * Real.sqrt ((m : ℝ) + 2) = (m : ℝ) + 2 :=
        Real.mul_self_sqrt (by positivity)
      have e3 : ((m + 1 : ℕ) : ℝ) = (m : ℝ) + 1 := by push_cast; ring
      have e4 : ((m + 2 : ℕ) : ℝ) = (m : ℝ) + 2 := by push_cast; ring
      have hA : Real.sqrt ((m + 2 : ℕ) : ℝ) * Real.sqrt ((m + 1 : ℕ) : ℝ)
            * Real.sqrt ((m : ℝ) + 1) * Real.sqrt (((m + 1 : ℕ) : ℝ) + 1)
          = ((m + 2 : ℕ) : ℝ) * (((m + 2 : ℕ) : ℝ) - 1) := by
        rw [e3, e4, show (m : ℝ) + 1 + 1 = (m : ℝ) + 2 from by ring]
        linear_combination (Real.sqrt ((m : ℝ) + 1) * Real.sqrt ((m : ℝ) + 1)) * hs2
          + ((m : ℝ) + 2) * hs1
      have hAc := congrArg (fun r : ℝ => (r : ℂ)) hA
      push_cast at hAc ⊢
      linear_combination z * hAc

theorem trial_quartic_form (k n : ℕ) (c : ℝ) :
    (inner ℂ (toLp (trial k n c)) (toLp (quartA k (trial k n c))) : ℂ).re
      = (n : ℝ) * ((n : ℝ) - 1) + ((n : ℝ) + 3) * ((n : ℝ) + 2) * c ^ 2 := by
  classical
  have hne : confAt k n ≠ confAt k (n + 3) := by
    intro h
    have := confAt_injective k h
    omega
  have hq : quartA k (trial k n c)
      = Finsupp.single (confAt k n) ((((n : ℝ) * ((n : ℝ) - 1) : ℝ) : ℂ) * 1)
        + Finsupp.single (confAt k (n + 3))
            (((((n : ℝ) + 3) * (((n : ℝ) + 3) - 1) : ℝ) : ℂ) * ((c : ℝ) : ℂ)) := by
    have hn3 : (((n + 3 : ℕ) : ℝ)) = (n : ℝ) + 3 := by push_cast; ring
    rw [trial, map_add, quartA_single_confAt, quartA_single_confAt, hn3]
  have hval_n : quartA k (trial k n c) (confAt k n)
      = (((n : ℝ) * ((n : ℝ) - 1) : ℝ) : ℂ) := by
    rw [hq]
    simp [Ne.symm hne]
  have hval_n3 : quartA k (trial k n c) (confAt k (n + 3))
      = ((((n : ℝ) + 3) * ((n : ℝ) + 2) : ℝ) : ℂ) * ((c : ℝ) : ℂ) := by
    rw [hq]
    simp only [Finsupp.add_apply, Finsupp.single_apply, if_neg hne]
    push_cast
    ring
  have hinner := inner_toLp_of_subset (trial_support_subset k n c) (quartA k (trial k n c))
  have hsum : (inner ℂ (toLp (trial k n c)) (toLp (quartA k (trial k n c))) : ℂ)
      = (((n : ℝ) * ((n : ℝ) - 1) + ((n : ℝ) + 3) * ((n : ℝ) + 2) * c ^ 2 : ℝ) : ℂ) := by
    rw [hinner, Finset.sum_insert (by simpa using hne), Finset.sum_singleton,
      hval_n, hval_n3, trial_at_n, trial_at_n3]
    push_cast
    simp [Complex.conj_ofReal]
    ring
  have := congrArg Complex.re hsum
  simpa [← Complex.ofReal_pow] using this

/-- **The negative result is specific to the absence of a quartic term.**  On the very
family of states that drives `dΓ(N) + lam·C_k` to `-∞`, adding the normal-ordered quartic
term `Q_k` restores a lower bound that is uniform in the occupation number `n` and in the
mixing coefficient `c`: the constant `lam⁴/4 + 2lam²` depends only on the cubic coupling.
This is the formal counterpart of the honest boundary recorded above — the failure at
degree three is a statement about the form-domination route applied to a bare cubic term,
not about a physical Hamiltonian in which a cubic vertex is accompanied by a quartic one. -/
theorem trial_cubic_quartic_bounded_below (k n : ℕ) (hn : 1 ≤ n) (lam c : ℝ) :
    -(lam ^ 4 / 4 + 2 * lam ^ 2) * ‖toLp (trial k n c)‖ ^ 2
      ≤ numberQuad (trial k n c)
        + lam * (inner ℂ (toLp (trial k n c)) (toLp (cubeA k (trial k n c))) : ℂ).re
        + (inner ℂ (toLp (trial k n c)) (toLp (quartA k (trial k n c))) : ℂ).re := by
  rw [trial_numberQuad, trial_cubic_form k n hn c, trial_quartic_form, trial_norm_sq]
  set t := Real.sqrt ((n : ℝ) + 2) with htdef
  have ht0 : 0 ≤ t := Real.sqrt_nonneg _
  have ht2 : t ^ 2 = (n : ℝ) + 2 := Real.sq_sqrt (by positivity)
  set S := Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2) * ((n : ℝ) + 3)) with hSdef
  have hS0 : 0 ≤ S := Real.sqrt_nonneg _
  have hS : S ≤ t ^ 3 := by
    have hcube : (0 : ℝ) ≤ t ^ 3 := by positivity
    have hle : ((n : ℝ) + 1) * ((n : ℝ) + 2) * ((n : ℝ) + 3) ≤ (t ^ 3) ^ 2 := by
      have : (t ^ 3) ^ 2 = ((n : ℝ) + 2) ^ 3 := by
        rw [show (t ^ 3) ^ 2 = (t ^ 2) ^ 3 from by ring, ht2]
      rw [this]; nlinarith [Nat.cast_nonneg (α := ℝ) n]
    have := Real.sqrt_le_sqrt hle
    rwa [Real.sqrt_sq hcube] at this
  -- the cubic term is dominated by the quartic term up to `lam²(n+2)`
  have key1 : -(c ^ 2 * ((n : ℝ) + 2) ^ 2 + lam ^ 2 * ((n : ℝ) + 2)) ≤ lam * (2 * c * S) := by
    rcases le_or_gt 0 (lam * c) with hsign | hsign
    · have h1 : 0 ≤ lam * (2 * c * S) := by nlinarith
      nlinarith [sq_nonneg c, sq_nonneg lam, Nat.cast_nonneg (α := ℝ) n]
    · have h2 : lam * (2 * c * t ^ 3) ≤ lam * (2 * c * S) := by nlinarith
      have h3 : 0 ≤ t ^ 2 * (c * t + lam) ^ 2 := by positivity
      have ht4 : t ^ 4 = ((n : ℝ) + 2) ^ 2 := by
        rw [show t ^ 4 = (t ^ 2) ^ 2 from by ring, ht2]
      have hexp : t ^ 2 * (c * t + lam) ^ 2
          = c ^ 2 * ((n : ℝ) + 2) ^ 2 + lam * (2 * c * t ^ 3) + lam ^ 2 * ((n : ℝ) + 2) := by
        rw [show t ^ 2 * (c * t + lam) ^ 2
          = c ^ 2 * t ^ 4 + lam * (2 * c * t ^ 3) + lam ^ 2 * t ^ 2 from by ring, ht4, ht2]
      linarith [h2, h3, hexp.symm.le, hexp.le]
  -- the quadratic-in-`n` free and quartic terms absorb the remainder
  have key2 : -(lam ^ 4 / 4 + 2 * lam ^ 2)
      ≤ (n : ℝ) + (n : ℝ) * ((n : ℝ) - 1) - lam ^ 2 * ((n : ℝ) + 2) := by
    nlinarith [sq_nonneg ((n : ℝ) - lam ^ 2 / 2)]
  have key3 : 0 ≤ c ^ 2 * ((n : ℝ) + 3) + ((n : ℝ) + 3) * ((n : ℝ) + 2) * c ^ 2
      - c ^ 2 * ((n : ℝ) + 2) ^ 2 := by
    have : c ^ 2 * ((n : ℝ) + 3) + ((n : ℝ) + 3) * ((n : ℝ) + 2) * c ^ 2
        - c ^ 2 * ((n : ℝ) + 2) ^ 2 = c ^ 2 * (2 * (n : ℝ) + 5) := by ring
    rw [this]; positivity
  have hMnn : 0 ≤ lam ^ 4 / 4 + 2 * lam ^ 2 := by positivity
  nlinarith [key1, key2, key3, hMnn, sq_nonneg c]

/-! ## 7. Axiom audit -/

section Audit

#print axioms trial_numberQuad
#print axioms trial_cubic_form
#print axioms cubic_no_relative_form_bound
#print axioms fock_gap_fails_for_cubic
#print axioms quartA_single_confAt
#print axioms trial_quartic_form
#print axioms trial_cubic_quartic_bounded_below

end Audit

end BookProof.FockCubicUnbounded

end
