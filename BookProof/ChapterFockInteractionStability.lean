import Mathlib
import BookProof.ChapterFockNumberPreservingGap

/-!
# Chapter FockInteractionStability — how far a gap survives a number-changing interaction

`CONSOLIDATED_PLAN.md` lists, after the 2026-08-28b status update, exactly one structural
input still assumed by the `dΓ` route: the Fock Hamiltonian must **preserve particle
number**, so pair creation and other interacting terms are excluded.  That hypothesis cannot
simply be dropped — a number-changing term can close a gap outright — but it *can* be
replaced by a quantitative one, and this chapter does exactly that.

The statement proved here is the honest one: a gap of size `μ` survives any symmetric
perturbation whose quadratic form is dominated by `a · (free form) + b‖·‖²` with `a ≤ 1`,
and the surviving gap is `(1 − a)μ − b`.  The perturbation is an **arbitrary** bounded
self-adjoint operator on Fock space — nothing forces it to commute with the number operator,
so pair creation, annihilation of pairs and every other number-changing process is allowed.

## Deliverables

* `gap_persists_of_relative_form_bound` — the abstract statement: on any set `S` of vectors
  where the unperturbed form satisfies `q x ≥ μ‖x‖²`, a perturbation `v` with
  `|v x| ≤ a q x + b‖x‖²` (`a ≤ 1`) leaves `q x + v x ≥ ((1 − a)μ − b)‖x‖²`;
* `gap_persists_of_bounded_form` — the `a = 0` special case;
* `gap_persists_pos` — when `b < (1 − a)μ` the surviving gap is strictly positive;
* `interaction_form_bound` — a bounded operator's quadratic form is bounded by its norm:
  `|Re⟪x, V x⟫| ≤ ‖V‖‖x‖²`;
* **`fock_gap_of_bounded_interaction`** — the Fock statement: with a one-particle gap
  `h − μ ≥ 0` and an arbitrary bounded self-adjoint `V` on Fock space with `‖V‖ ≤ δ`, every
  vacuum-orthogonal finite-particle state has `dΓ(h) + V` energy at least `(μ − δ)‖u‖²`;
* **`fock_gap_of_one_particle_form_gap_interaction`** — the same conclusion fed directly by
  the certificate chain's output, a one-particle *form* gap on the finite-mode core.

## Honest boundary

This is a perturbative statement, and it is stated as such.  It says that a number-changing
interaction cannot destroy a gap it is quantitatively smaller than; it says nothing about an
interaction that is large, and physically relevant Yang–Mills interaction terms are **not**
bounded operators on Fock space, so the bounded corollaries do not apply to them directly.
The relatively-form-bounded version (`a` up to `1`) is the form in which such a claim could
be made for an unbounded interaction, and it is stated for a form `v` with no boundedness
assumption of its own — but supplying the required domination for the physical interaction
is not done here and is not claimed.  `1.932` remains a certified truncated number; no mass
gap of the physical Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockInteractionStability

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

/-! ## 1. Abstract gap persistence

Nothing in this section knows about Fock space: `q` is the unperturbed quadratic form, `v`
the perturbing one, and `S` the set of vectors on which the unperturbed gap is known (in the
application, the vacuum-orthogonal states). -/

section Abstract

variable {E : Type*} [NormedAddCommGroup E]

/-- **Gap persistence under a relatively form-bounded perturbation.**  If the unperturbed
form has a gap `μ` on `S`, and the perturbation is dominated by `a · q + b‖·‖²` with
`a ≤ 1`, then the perturbed form has gap `(1 − a)μ − b` on `S`.

No symmetry, boundedness or number-preservation of the perturbation is used: only the
domination hypothesis. -/
theorem gap_persists_of_relative_form_bound
    {q v : E → ℝ} {S : Set E} {mu a b : ℝ} (ha : a ≤ 1)
    (hq : ∀ x ∈ S, mu * ‖x‖ ^ 2 ≤ q x)
    (hv : ∀ x, |v x| ≤ a * q x + b * ‖x‖ ^ 2) :
    ∀ x ∈ S, ((1 - a) * mu - b) * ‖x‖ ^ 2 ≤ q x + v x := by
  intro x hx
  have h1 : mu * ‖x‖ ^ 2 ≤ q x := hq x hx
  have h2 : -(a * q x + b * ‖x‖ ^ 2) ≤ v x := (abs_le.mp (hv x)).1
  have h3 : 0 ≤ (1 - a) * (q x - mu * ‖x‖ ^ 2) :=
    mul_nonneg (by linarith) (by linarith)
  nlinarith

/-- The `a = 0` case: a perturbation bounded by `b‖·‖²` reduces the gap by at most `b`. -/
theorem gap_persists_of_bounded_form
    {q v : E → ℝ} {S : Set E} {mu b : ℝ}
    (hq : ∀ x ∈ S, mu * ‖x‖ ^ 2 ≤ q x)
    (hv : ∀ x, |v x| ≤ b * ‖x‖ ^ 2) :
    ∀ x ∈ S, (mu - b) * ‖x‖ ^ 2 ≤ q x + v x := by
  have h := gap_persists_of_relative_form_bound (q := q) (v := v) (S := S) (mu := mu)
    (a := 0) (b := b) zero_le_one hq (by simpa using hv)
  intro x hx
  have := h x hx
  simpa using this

/-- The surviving gap is strictly positive exactly when the perturbation is quantitatively
smaller than the unperturbed one. -/
theorem gap_persists_pos {mu a b : ℝ} (hmu : 0 < mu) (ha : a < 1) (hb : b < (1 - a) * mu) :
    0 < (1 - a) * mu - b := by
  have : 0 < (1 - a) * mu := mul_pos (by linarith) hmu
  linarith

/-- A bounded operator's quadratic form is controlled by its norm:
`|Re⟪x, V x⟫| ≤ ‖V‖‖x‖²`. -/
theorem interaction_form_bound [InnerProductSpace ℂ E] (V : E →L[ℂ] E) (x : E) :
    |(inner ℂ x (V x) : ℂ).re| ≤ ‖V‖ * ‖x‖ ^ 2 := by
  calc |(inner ℂ x (V x) : ℂ).re| ≤ ‖(inner ℂ x (V x) : ℂ)‖ := Complex.abs_re_le_norm _
    _ ≤ ‖x‖ * ‖V x‖ := norm_inner_le_norm _ _
    _ ≤ ‖x‖ * (‖V‖ * ‖x‖) := by
        exact mul_le_mul_of_nonneg_left (V.le_opNorm x) (norm_nonneg x)
    _ = ‖V‖ * ‖x‖ ^ 2 := by ring

end Abstract

/-! ## 2. The Fock statement

`V` below is an arbitrary bounded operator on the Fock space.  It is *not* assumed to
commute with the number operator, so it may create and destroy particles; only its size
enters. -/

/-- **A gap survives a bounded number-changing interaction.**  If the one-particle matrix
satisfies the gap condition `h − μ ≥ 0` with `μ ≥ 0`, and `V` is any bounded operator on
Fock space with `‖V‖ ≤ δ`, then every vacuum-orthogonal finite-particle state satisfies

  `Re⟪u, (dΓ(h) + V) u⟫ ≥ (μ − δ)‖u‖²`.

Pair creation is *permitted* here: `V` is unconstrained apart from its norm. -/
theorem fock_gap_of_bounded_interaction {col : ℕ → (ℕ →₀ ℂ)} {mu delta : ℝ} (hmu : 0 ≤ mu)
    (hgap : IsPosCol (shiftCol col mu)) (V : Fock →L[ℂ] Fock) (hV : ‖V‖ ≤ delta)
    {u : FockAlg} (h0 : u 0 = 0) :
    (mu - delta) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + (inner ℂ (toLp u) (V (toLp u)) : ℂ).re := by
  have hq : mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re :=
    fock_gap_of_number_preserving hmu hgap h0
  have hv : |(inner ℂ (toLp u) (V (toLp u)) : ℂ).re| ≤ delta * ‖toLp u‖ ^ 2 := by
    refine (interaction_form_bound V (toLp u)).trans ?_
    exact mul_le_mul_of_nonneg_right hV (sq_nonneg _)
  have h2 := (abs_le.mp hv).1
  nlinarith

/-- **The certificate chain, with a bounded interaction switched on.**  Given the
one-particle form gap `⟪x, h x⟫ ≥ μ‖x‖²` on the finite-mode core — the exact output of
`ChapterRitzCertificate` / `ChapterBandEnclosure` — and any bounded operator `V` on Fock
space with `‖V‖ ≤ δ`, the interacting Fock Hamiltonian still has vacuum energy `0` for its
free part and energy at least `(μ − δ)‖u‖²` on vacuum-orthogonal finite-particle states. -/
theorem fock_gap_of_one_particle_form_gap_interaction
    {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] (b : HilbertBasis ℕ ℂ F)
    (A : BookProof.HermiteGalerkin.finiteModeDomain b →ₗ[ℂ]
      BookProof.HermiteGalerkin.finiteModeDomain b)
    {mu delta : ℝ} (hmu : 0 ≤ mu)
    (hgap : ∀ x : BookProof.HermiteGalerkin.finiteModeDomain b,
      mu * ‖(x : F)‖ ^ 2 ≤
        quadForm ((BookProof.HermiteGalerkin.finiteModeDomain b).subtype.comp A) x)
    (V : Fock →L[ℂ] Fock) (hV : ‖V‖ ≤ delta) :
    dGamma (opCol b A) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (mu - delta) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b A) u)) : ℂ).re
            + (inner ℂ (toLp u) (V (toLp u)) : ℂ).re := by
  refine ⟨dGamma_vac _, fun u h0 => ?_⟩
  have hq : mu * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b A) u)) : ℂ).re :=
    (fock_gap_of_one_particle_form_gap b A hmu hgap).2 u h0
  have hv : |(inner ℂ (toLp u) (V (toLp u)) : ℂ).re| ≤ delta * ‖toLp u‖ ^ 2 := by
    refine (interaction_form_bound V (toLp u)).trans ?_
    exact mul_le_mul_of_nonneg_right hV (sq_nonneg _)
  have h2 := (abs_le.mp hv).1
  nlinarith

end BookProof.FockInteractionStability

end
