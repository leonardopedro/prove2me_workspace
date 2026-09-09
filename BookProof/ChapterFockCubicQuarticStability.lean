import Mathlib
import BookProof.ChapterFockCubicUnbounded

/-!
# Chapter FockCubicQuarticStability — the cubic vertex is stabilised by its quartic partner

`ChapterFockCubicUnbounded` proves two facts about a *bare* single-mode cubic term
`C_k = (a_k†)³ + (a_k)³`: it admits no relative form bound against the number form
(`cubic_no_relative_form_bound`), and consequently `dΓ(N) + lam·C_k` is unbounded below on
the vacuum-orthogonal sector for every coupling strength (`fock_gap_fails_for_cubic`).  The
complementary positive statement proved there, `trial_cubic_quartic_bounded_below`, only
covers the explicit two-term trial family `|n⟩ + c|n+3⟩`.

This chapter removes that restriction: the sum of the free form, the cubic term and its
normal-ordered quartic partner `Q_k = (a_k†)²(a_k)²` is bounded below **on all finite
states**, with an explicit constant depending only on the coupling and on the one-particle
gap.  No vacuum-orthogonality and no restriction to a trial family is needed.

## Method

Everything is reduced to four norms of `u`:

* `‖a_k u‖`, `‖a_k² u‖`, `‖a_k† u‖`, `‖a_k† a_k u‖`,

through the identities

* `quart_form_eq` — `Re⟪u, Q_k u⟫ = ‖a_k² u‖²`;
* `cubic_form_eq` — `Re⟪u, C_k u⟫ = 2 Re⟪a_k² u, a_k† u⟫`;
* `norm_creA_sq` — `‖a_k† v‖² = ‖a_k v‖² + ‖v‖²` (the canonical commutation relation);
* `sq_norm_annA_le_mul` — `‖a_k u‖² ≤ ‖u‖ ‖a_k† a_k u‖` (Cauchy–Schwarz for the
  mode-number operator).

The Cauchy–Schwarz step is what replaces the explicit trial computation: it says that a
state carrying a large mode occupation *must* also carry a large quartic form, and the
quartic form grows one power faster than the cubic form.

## Deliverables

* **`mode_cubic_quartic_bounded_below`** — for every mode `k`, all reals `mu`, `lam` and
  every finite state `u`,
  `mu‖a_k u‖² + lam·Re⟪u, C_k u⟫ + Re⟪u, Q_k u⟫ ≥ -(2lam² + (2lam² + ½ − mu)²/2)‖u‖²`;
* **`numberForm_cubic_quartic_bounded_below`** — the same with the number form `⟪u, N u⟫` in
  place of the single mode occupation;
* **`multiMode_cubic_quartic_bounded_below`** — the sum over a finite set `S` of modes,
  paid for by one copy of the free form, at the cost of a constant growing linearly in
  `|S|`;
* **`dGamma_cubic_quartic_bounded_below`** — the same with the free form `⟪u, dΓ(h) u⟫` of a
  one-particle operator with form gap `mu > 0` in place of `mu⟪u, N u⟫`;
* `trial_cubic_quartic_bounded_below_general` — the statement of
  `ChapterFockCubicUnbounded.trial_cubic_quartic_bounded_below` (free form `dΓ(N)`,
  i.e. `mu = 1`) for arbitrary finite states.

## Honest boundary

`C_k` and `Q_k` are single-mode terms, not the full Yang–Mills cubic and quartic vertices,
and semiboundedness is not a mass gap: the constant `-(2lam² + (2lam² + ½ − mu)²/2)‖u‖²` is
negative, so what is proved is stability (the energy cannot run to `-∞`), not positivity of
the non-vacuum spectrum.  All gap statements elsewhere in this development remain
conditional on the one-particle form gap.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockCubicQuarticStability

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

/-! ## 1. The three quadratic forms as norms -/

/-- **The quartic form is a square norm**: `Re⟪u, Q_k u⟫ = ‖a_k² u‖²`.  In particular it is
nonnegative — the normal-ordered quartic term is a positive operator. -/
theorem quart_form_eq (k : ℕ) (u : FockAlg) :
    (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re = ‖toLp (annA k (annA k u))‖ ^ 2 := by
  have hq : quartA k u = creA k (creA k (annA k (annA k u))) := rfl
  have h : (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ)
      = inner ℂ (toLp (annA k (annA k u))) (toLp (annA k (annA k u))) := by
    rw [hq, inner_creA_right, inner_creA_right]
  rw [h, inner_self_eq_norm_sq_to_K]
  simp [← Complex.ofReal_pow]

/-- The nonnegativity of the normal-ordered quartic form. -/
theorem quart_form_nonneg (k : ℕ) (u : FockAlg) :
    0 ≤ (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re := by
  rw [quart_form_eq]; positivity

/-- **The cubic form as an off-diagonal pairing**: `Re⟪u, C_k u⟫ = 2 Re⟪a_k² u, a_k† u⟫`.
This is the identity that lets Cauchy–Schwarz play the cubic term off against the quartic
one. -/
theorem cubic_form_eq (k : ℕ) (u : FockAlg) :
    (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
      = 2 * (inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u)) : ℂ).re := by
  have hadd : ∀ a b : FockAlg, toLp (a + b) = toLp a + toLp b := fun a b => map_add toLpL a b
  have hcre : (inner ℂ (toLp u) (toLp (creA k (creA k (creA k u)))) : ℂ)
      = inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u)) := by
    rw [inner_creA_right, inner_creA_right]
  have hann : (inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u)) : ℂ)
      = inner ℂ (toLp (annA k (annA k (annA k u)))) (toLp u) := by
    rw [inner_creA_right]
  have hann' : (inner ℂ (toLp u) (toLp (annA k (annA k (annA k u)))) : ℂ)
      = (starRingEnd ℂ) (inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u))) := by
    rw [hann, inner_conj_symm]
  rw [cubeA_apply, hadd, inner_add_right, Complex.add_re, hcre, hann', Complex.conj_re]
  ring

/-! ## 2. The canonical commutation relation as a norm identity -/

/-- **`‖a_k† v‖² = ‖a_k v‖² + ‖v‖²`**, the single-mode form of the canonical commutation
relation. -/
theorem norm_creA_sq (k : ℕ) (v : FockAlg) :
    ‖toLp (creA k v)‖ ^ 2 = ‖toLp (annA k v)‖ ^ 2 + ‖toLp v‖ ^ 2 := by
  have hadd : ∀ a b : FockAlg, toLp (a + b) = toLp a + toLp b := fun a b => map_add toLpL a b
  have hccr : annA k (creA k v) = creA k (annA k v) + v := by
    have h := ccr_annA_creA k v
    have := sub_eq_iff_eq_add.mp h
    simpa [add_comm] using this
  have key : (inner ℂ (toLp (creA k v)) (toLp (creA k v)) : ℂ)
      = inner ℂ (toLp (annA k v)) (toLp (annA k v)) + inner ℂ (toLp v) (toLp v) := by
    rw [inner_creA_left, hccr, hadd, inner_add_right, inner_creA_right]
  rw [inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K] at key
  exact_mod_cast key

/-- **Cauchy–Schwarz for the mode-number operator**: `‖a_k u‖² ≤ ‖u‖ ‖a_k† a_k u‖`. -/
theorem sq_norm_annA_le_mul (k : ℕ) (u : FockAlg) :
    ‖toLp (annA k u)‖ ^ 2 ≤ ‖toLp u‖ * ‖toLp (creA k (annA k u))‖ := by
  have h1 : (inner ℂ (toLp u) (toLp (creA k (annA k u))) : ℂ)
      = inner ℂ (toLp (annA k u)) (toLp (annA k u)) := by
    rw [inner_creA_right]
  have h2 : ‖(inner ℂ (toLp u) (toLp (creA k (annA k u))) : ℂ)‖
      ≤ ‖toLp u‖ * ‖toLp (creA k (annA k u))‖ := norm_inner_le_norm _ _
  rw [h1, inner_self_eq_norm_sq_to_K] at h2
  simpa [abs_of_nonneg (sq_nonneg ‖toLp (annA k u)‖)] using h2

/-- The mode-`k` occupation is bounded by the total number form. -/
theorem sq_norm_annA_le_numberQuad (k : ℕ) (u : FockAlg) :
    ‖toLp (annA k u)‖ ^ 2 ≤ numberQuad u := by
  have h := sum_sq_annA_le u {k}
  rwa [Finset.sum_singleton] at h

/-! ## 3. The lower bound on arbitrary finite states -/

/-- **The cubic term is stabilised by its quartic partner, on every finite state.**  For
every mode `k`, all reals `mu`, `lam` and every finite state `u`,

`mu‖a_k u‖² + lam·Re⟪u, C_k u⟫ + Re⟪u, Q_k u⟫ ≥ -(2lam² + (2lam² + ½ − mu)²/2)‖u‖²`.

Only the occupation `‖a_k u‖²` of the mode `k` is used on the left, not the whole number
form; that is what makes the bound additive over modes, as in
`multiMode_cubic_quartic_bounded_below`.  It is the exact counterpart of
`FockCubicUnbounded.fock_gap_fails_for_cubic`: a *bare* cubic term destroys even
semiboundedness, while the physical cubic-plus-quartic pair keeps the form bounded below,
uniformly in the state. -/
theorem mode_cubic_quartic_bounded_below (k : ℕ) (mu lam : ℝ) (u : FockAlg) :
    -(2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2) * ‖toLp u‖ ^ 2
      ≤ mu * ‖toLp (annA k u)‖ ^ 2
        + lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re := by
  set nu := ‖toLp u‖ with hnudef
  set an := ‖toLp (annA k u)‖ with handef
  set a2 := ‖toLp (annA k (annA k u))‖ with ha2def
  set ac := ‖toLp (creA k u)‖ with hacdef
  set xc := ‖toLp (creA k (annA k u))‖ with hxcdef
  have hnu0 : 0 ≤ nu := norm_nonneg _
  have han0 : 0 ≤ an := norm_nonneg _
  have ha20 : 0 ≤ a2 := norm_nonneg _
  have hac0 : 0 ≤ ac := norm_nonneg _
  have hxc0 : 0 ≤ xc := norm_nonneg _
  have hquart : (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re = a2 ^ 2 := quart_form_eq k u
  have hcubic : (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
      = 2 * (inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u)) : ℂ).re := cubic_form_eq k u
  set R := (inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u)) : ℂ).re with hRdef
  have hR : |R| ≤ a2 * ac := by
    have h1 : |R| ≤ ‖(inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u)) : ℂ)‖ :=
      Complex.abs_re_le_norm _
    exact h1.trans (norm_inner_le_norm _ _)
  have hcc : ac ^ 2 = an ^ 2 + nu ^ 2 := norm_creA_sq k u
  have hxx : xc ^ 2 = a2 ^ 2 + an ^ 2 := norm_creA_sq k (annA k u)
  have hcs : an ^ 2 ≤ nu * xc := sq_norm_annA_le_mul k u
  -- the cubic term is dominated by half the quartic term plus `2lam²‖a†u‖²`
  have hRbound : -(a2 ^ 2 / 2 + 2 * lam ^ 2 * ac ^ 2) ≤ lam * (2 * R) := by
    obtain ⟨hR1, hR2⟩ := abs_le.mp hR
    rcases le_or_gt 0 lam with hl | hl
    · nlinarith [sq_nonneg (a2 - 2 * lam * ac)]
    · nlinarith [sq_nonneg (a2 + 2 * lam * ac)]
  -- the quartic term dominates the remainder, by Cauchy–Schwarz
  have hkey : 0 ≤ mu * an ^ 2 + a2 ^ 2 / 2 - 2 * lam ^ 2 * (an ^ 2 + nu ^ 2)
      + (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2) * nu ^ 2 := by
    rcases eq_or_lt_of_le hnu0 with hnu | hnu
    · -- the degenerate case `‖u‖ = 0`: Cauchy–Schwarz forces `‖a_k u‖ = 0` too
      have hz : nu = 0 := hnu.symm
      have han2 : an ^ 2 = 0 :=
        le_antisymm (by rw [hz] at hcs; simpa using hcs) (sq_nonneg an)
      rw [hz, han2]
      nlinarith [sq_nonneg a2]
    · have hnu2 : (0 : ℝ) < 2 * nu ^ 2 := by positivity
      have hA : an ^ 4 - nu ^ 2 * an ^ 2 ≤ nu ^ 2 * a2 ^ 2 := by
        have h1 : an ^ 4 ≤ nu ^ 2 * xc ^ 2 := by
          nlinarith [hcs, sq_nonneg an, mul_nonneg hnu0 hxc0]
        have h2 : nu ^ 2 * xc ^ 2 = nu ^ 2 * (a2 ^ 2 + an ^ 2) := by rw [hxx]
        linarith
      have hmul : 2 * nu ^ 2 * 0 ≤ 2 * nu ^ 2 * (mu * an ^ 2 + a2 ^ 2 / 2
          - 2 * lam ^ 2 * (an ^ 2 + nu ^ 2)
          + (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2) * nu ^ 2) := by
        have hsq := sq_nonneg (an ^ 2 - (2 * lam ^ 2 + 1 / 2 - mu) * nu ^ 2)
        nlinarith [hA, hsq]
      exact le_of_mul_le_mul_left hmul hnu2
  have hcc' : 2 * lam ^ 2 * ac ^ 2 = 2 * lam ^ 2 * (an ^ 2 + nu ^ 2) := by rw [hcc]
  rw [hquart, hcubic]
  linarith [hkey, hRbound, hcc']

/-- **The same bound against the full number form.**  Since the mode occupation is bounded
by the number form, `mode_cubic_quartic_bounded_below` gives
`mu⟪u, N u⟫ + lam·Re⟪u, C_k u⟫ + Re⟪u, Q_k u⟫ ≥ -(2lam² + (2lam² + ½ − mu)²/2)‖u‖²` on
every finite state — the general-state form of
`FockCubicUnbounded.trial_cubic_quartic_bounded_below`, which only covered the two-term
trial family. -/
theorem numberForm_cubic_quartic_bounded_below (k : ℕ) {mu lam : ℝ} (hmu : 0 ≤ mu)
    (u : FockAlg) :
    -(2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2) * ‖toLp u‖ ^ 2
      ≤ mu * numberQuad u
        + lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re := by
  have hmode := mode_cubic_quartic_bounded_below k mu lam u
  have hnq := mul_le_mul_of_nonneg_left (sq_norm_annA_le_numberQuad k u) hmu
  linarith

/-- **The bound is additive over modes.**  For a finite set `S` of modes, the free form and
the sum over `S` of the cubic-plus-quartic mode interactions satisfy

`mu⟪u, N u⟫ + ∑_{k ∈ S} (lam·Re⟪u, C_k u⟫ + Re⟪u, Q_k u⟫)
   ≥ -|S|(2lam² + (2lam² + ½ − mu)²/2)‖u‖²`.

The per-mode occupations add up to at most the number form, so a single copy of the free
form pays for all the modes at once; only the constant grows, linearly in the number of
interacting modes. -/
theorem multiMode_cubic_quartic_bounded_below (S : Finset ℕ) {mu lam : ℝ} (hmu : 0 ≤ mu)
    (u : FockAlg) :
    -(S.card * (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2)) * ‖toLp u‖ ^ 2
      ≤ mu * numberQuad u
        + ∑ k ∈ S, (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
            + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) := by
  classical
  set K := 2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2 with hKdef
  have hterm : ∀ k ∈ S, -(K * ‖toLp u‖ ^ 2) ≤
      mu * ‖toLp (annA k u)‖ ^ 2
        + (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) := by
    intro k _
    have h := mode_cubic_quartic_bounded_below k mu lam u
    rw [hKdef]
    linarith
  have hsum : ∑ _k ∈ S, -(K * ‖toLp u‖ ^ 2)
      ≤ ∑ k ∈ S, (mu * ‖toLp (annA k u)‖ ^ 2
        + (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re)) :=
    Finset.sum_le_sum hterm
  rw [Finset.sum_const, nsmul_eq_mul] at hsum
  rw [Finset.sum_add_distrib, ← Finset.mul_sum] at hsum
  rw [hKdef] at hsum
  have hocc : ∑ k ∈ S, ‖toLp (annA k u)‖ ^ 2 ≤ numberQuad u := sum_sq_annA_le u S
  have hmul := mul_le_mul_of_nonneg_left hocc hmu
  rw [hKdef]
  linarith

/-- The `mu = 1` case: the free Fock Hamiltonian `dΓ(N)` plus the cubic term plus its
quartic partner is bounded below by `-(2lam⁴ + lam² + ⅛)‖u‖²` on every finite state.  This
generalises `FockCubicUnbounded.trial_cubic_quartic_bounded_below` from the two-term trial
family to arbitrary states. -/
theorem trial_cubic_quartic_bounded_below_general (k : ℕ) (lam : ℝ) (u : FockAlg) :
    -(2 * lam ^ 4 + lam ^ 2 + 1 / 8) * ‖toLp u‖ ^ 2
      ≤ numberQuad u
        + lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re := by
  have h := numberForm_cubic_quartic_bounded_below k (mu := 1) (lam := lam) zero_le_one u
  have hconst : (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - 1) ^ 2 / 2)
      = 2 * lam ^ 4 + lam ^ 2 + 1 / 8 := by ring
  rw [hconst] at h
  simpa using h

/-! ## 4. The same bound for a one-particle operator with a form gap -/

/-- **The cubic-plus-quartic stability of the second-quantised Hamiltonian.**  If the
one-particle operator `col` has form gap `mu > 0` — the same hypothesis that drives the
gap chain of `ChapterFockNumberPreservingGap` — then `dΓ(col) + lam·C_k + Q_k` is bounded
below on all finite states, with the explicit constant
`-(2lam² + (2lam² + ½ − mu)²/2)‖u‖²`. -/
theorem dGamma_cubic_quartic_bounded_below (k : ℕ) {col : ℕ → (ℕ →₀ ℂ)} {mu lam : ℝ}
    (hmu : 0 < mu) (hgap : IsPosCol (shiftCol col mu)) (u : FockAlg) :
    -(2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re := by
  have hbase := numberForm_cubic_quartic_bounded_below k (mu := mu) (lam := lam) hmu.le u
  have hfree : mu * numberQuad u ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re :=
    number_le_dGamma_quadForm hgap u
  linarith

/-- **The multi-mode version for a one-particle operator with a form gap.**  With the same
hypothesis `mu > 0` on the one-particle operator, `dΓ(col)` plus the cubic-plus-quartic
interaction of every mode in a finite set `S` is bounded below by
`-|S|(2lam² + (2lam² + ½ − mu)²/2)‖u‖²` on all finite states. -/
theorem dGamma_multiMode_cubic_quartic_bounded_below (S : Finset ℕ) {col : ℕ → (ℕ →₀ ℂ)}
    {mu lam : ℝ} (hmu : 0 < mu) (hgap : IsPosCol (shiftCol col mu)) (u : FockAlg) :
    -(S.card * (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2)) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + ∑ k ∈ S, (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
            + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) := by
  have hbase := multiMode_cubic_quartic_bounded_below S (mu := mu) (lam := lam) hmu.le u
  have hfree : mu * numberQuad u ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re :=
    number_le_dGamma_quadForm hgap u
  linarith

/-! ## 5. Axiom audit -/

section Audit

#print axioms quart_form_eq
#print axioms cubic_form_eq
#print axioms norm_creA_sq
#print axioms sq_norm_annA_le_mul
#print axioms mode_cubic_quartic_bounded_below
#print axioms numberForm_cubic_quartic_bounded_below
#print axioms multiMode_cubic_quartic_bounded_below
#print axioms trial_cubic_quartic_bounded_below_general
#print axioms dGamma_cubic_quartic_bounded_below
#print axioms dGamma_multiMode_cubic_quartic_bounded_below

end Audit

end BookProof.FockCubicQuarticStability

end
