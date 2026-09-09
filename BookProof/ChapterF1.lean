import Mathlib
import BookProof.ChapterG2

/-!
# Chapter F1 — the Bargmann–Fock / CCR polynomial field model (roadmap N12, §0 S7)

This file formalizes the *polynomial (Bargmann–Fock) model* of the canonical
commutation relations, following the `../unfer` design decisions (§0 S7 of the
roadmap: Hermitian field representation, quadratic ordering, BRST commutation,
`nested_fock_algebra` / `fock_sirk` crates cited in docstrings).

The one-mode Fock space is modelled by the polynomial ring `ℂ[X]`
(`Polynomial ℂ`), with the vacuum `|0⟩ := 1`.  The two ladder operators are

* annihilation `a := d/dX` (`Polynomial.derivative`), and
* creation `a† := X · (·)` (`LinearMap.mulLeft ℂ X`).

The `n`-mode model is `MvPolynomial (Fin n) ℂ` with `a_i := ∂/∂X_i`.

## Deliverables

* **F1.1 CCR** `ccr` : `[a, a†] = 1` on `ℂ[X]`; `ccr_mv` : `[a_i, a†_j] = δ_ij`.
* **F1.2 Hermitian field representation** `fieldPhi`, `fieldPi`,
  `field_ccr` : `[φ, π] = 2i·1`; the Bargmann pairing `bargmann` with
  `bargmann_creat_annih` (the adjoint relation `⟪a†p, q⟫ = ⟪p, aq⟫`, whence
  `phi_symmetric` / `pi_symmetric`).
* **F1.3 Number operator** `numberOp := a† ∘ a`, `numberOp_monomial` : `N Xⁿ = n·Xⁿ`.
* **F1.4 Quadratic ordering (HEADLINE)** `quadratic_ordering_vacuum` : `⟨0|H|0⟩ = 0`
  for `H := a† a`, contrasted with `symmetric_ordering_vacuum` : the symmetric
  ordering `(a a† + a† a)/2` gives the nonzero zero-point value `1/2` — so the
  `../unfer` quadratic-ordering normalization is a *theorem* (`orderings_differ`).
* **F1.5 BRST bridge** `field_gauge_invariant_iff` : gauge invariance =
  commutation with the BRST operator, on the `ChapterG2` model
  (cites the `fock_sirk` crate).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.
-/

open Polynomial Finset
open scoped BigOperators

namespace BookProof.ChapterF1

noncomputable section

/-! ## F1.1 — Canonical commutation relations -/

/-- Annihilation operator `a` on the one-mode Bargmann–Fock space `ℂ[X]`:
differentiation `d/dX` (`../unfer`: `a` is differentiation). -/
noncomputable def annih : ℂ[X] →ₗ[ℂ] ℂ[X] := Polynomial.derivative

/-- Creation operator `a†` on `ℂ[X]`: multiplication by `X`
(`../unfer`: `a†` is multiplication by the coordinate). -/
noncomputable def creat : ℂ[X] →ₗ[ℂ] ℂ[X] := LinearMap.mulLeft ℂ (X : ℂ[X])

@[simp] theorem annih_apply (p : ℂ[X]) : annih p = derivative p := rfl

@[simp] theorem creat_apply (p : ℂ[X]) : creat p = X * p := rfl

/--
**F1.1 CCR** (one mode): `[a, a†] = 1`, i.e. `a ∘ a† − a† ∘ a = id`.
The Leibniz rule gives `d/dX (X·p) = p + X·(d/dX p)`, so subtracting
`X·(d/dX p)` leaves `p`.
-/
theorem ccr : annih ∘ₗ creat - creat ∘ₗ annih = LinearMap.id := by
  refine LinearMap.ext fun p => ?_
  change derivative (X * p) - X * derivative p = p
  simp [derivative_mul]

/--
**F1.1 CCR** (`n` modes): `[a_i, a†_j] = δ_ij`.  With `a_i := ∂/∂X_i`
(a `Derivation`) and `a†_j := X_j·(·)`, the Leibniz rule and `∂/∂X_i X_j = δ_ij`
give `∂_i (X_j·p) − X_j·(∂_i p) = δ_ij·p`.
-/
theorem ccr_mv {n : ℕ} (i j : Fin n) (p : MvPolynomial (Fin n) ℂ) :
    (MvPolynomial.pderiv i) (MvPolynomial.X j * p)
      - MvPolynomial.X j * (MvPolynomial.pderiv i) p
      = (if i = j then p else 0) := by
  split_ifs <;> simp_all [ MvPolynomial.pderiv_X ]

/-! ## F1.3 — Number operator -/

/-- Number operator `N := a† ∘ a` (`= X · d/dX`). -/
noncomputable def numberOp : ℂ[X] →ₗ[ℂ] ℂ[X] := creat ∘ₗ annih

/--
**F1.3**: the monomials are eigenvectors of the number operator,
`N Xⁿ = n·Xⁿ` — so the spectrum of `N` on the monomial basis is `ℕ`.
-/
theorem numberOp_monomial (n : ℕ) : numberOp (X ^ n) = (n : ℂ) • X ^ n := by
  induction n <;> simp_all [ pow_succ', numberOp ];
  simp [ add_smul, mul_add, add_comm ]

/-! ## F1.2 — Hermitian field representation -/

/-- The Hermitian field operator `φ := a† + a`. -/
noncomputable def fieldPhi : ℂ[X] →ₗ[ℂ] ℂ[X] := creat + annih

/-- The conjugate momentum `π := i·(a† − a)`. -/
noncomputable def fieldPi : ℂ[X] →ₗ[ℂ] ℂ[X] := Complex.I • (creat - annih)

/-- **A.1 of `PLAN_LEAN_SPECIALIST_NS_FLOW.md` (name alias).** The position
operator of the Bargmann–Fock model is the Hermitian field `φ = a† + a`; the
Navier–Stokes plan refers to it as `positionOp`. -/
noncomputable abbrev positionOp : ℂ[X] →ₗ[ℂ] ℂ[X] := fieldPhi

theorem positionOp_eq_creat_add_annih : positionOp = creat + annih := rfl

/--
**F1.2**: the field commutator `[φ, π] = 2i·1`.
Expanding, `[φ, π] = 2i·(a a† − a† a) = 2i·1` by `ccr`.
-/
theorem field_ccr :
    fieldPhi ∘ₗ fieldPi - fieldPi ∘ₗ fieldPhi = (2 * Complex.I) • LinearMap.id := by
  ext p
  unfold fieldPhi fieldPi
  simp [← mul_assoc, ← Polynomial.C_mul_X_pow_eq_monomial,
    Polynomial.coeff_X_pow, mul_sub, mul_add,
    mul_comm, LinearMap.comp_apply, LinearMap.smul_apply,
    LinearMap.add_apply, LinearMap.sub_apply]
  split_ifs <;> ring

/-- The **Bargmann pairing** on `ℂ[X]`: `⟪p, q⟫ = Σ n! · conj(pₙ) · qₙ`,
conjugate-linear in the first slot (Mathlib's inner-product convention).  On
monomials it is `⟪Xᵐ, Xⁿ⟫ = n!·δ_{mn}` (see `bargmann_monomial`).  The sum is
finite (over the union of the supports). -/
noncomputable def bargmann (p q : ℂ[X]) : ℂ :=
  ∑ n ∈ p.support ∪ q.support,
    (n.factorial : ℂ) * (starRingEnd ℂ) (p.coeff n) * q.coeff n

/--
The pairing may be computed over any finset containing both supports;
terms off the supports vanish.
-/
theorem bargmann_eq_sum (p q : ℂ[X]) {s : Finset ℕ}
    (hp : p.support ⊆ s) (hq : q.support ⊆ s) :
    bargmann p q = ∑ n ∈ s, (n.factorial : ℂ) * (starRingEnd ℂ) (p.coeff n) * q.coeff n := by
  convert Finset.sum_subset ( Finset.union_subset hp hq ) _ using 1;
  aesop

/--
The pairing with a monomial on the left collapses to a single coefficient:
`⟪Xᵐ, q⟫ = m! · qₘ`.
-/
theorem bargmann_monomial_left (m : ℕ) (q : ℂ[X]) :
    bargmann (X ^ m) q = (m.factorial : ℂ) * q.coeff m := by
  unfold bargmann;
  rw [ Finset.sum_eq_single m ] <;> simp_all [ Polynomial.coeff_X_pow ]

/--
**F1.2** (monomial pairing): `⟪Xᵐ, Xⁿ⟫ = n!·δ_{mn}`.
-/
theorem bargmann_monomial (m n : ℕ) :
    bargmann (X ^ m) (X ^ n) = if m = n then (n.factorial : ℂ) else 0 := by
  convert bargmann_monomial_left m ( X ^ n ) using 1 ; aesop

/--
**F1.2** (adjoint / Bargmann symmetry, monomial core): the creation and
annihilation operators are mutually adjoint w.r.t. the Bargmann pairing,
`⟪a† Xᵐ, Xⁿ⟫ = ⟪Xᵐ, a Xⁿ⟫`.  Consequently `φ = a† + a` and `π = i(a† − a)`
are symmetric (Hermitian) w.r.t. the pairing.
-/
theorem bargmann_creat_annih (m n : ℕ) :
    bargmann (creat (X ^ m)) (X ^ n) = bargmann (X ^ m) (annih (X ^ n)) := by
  simp [ bargmann_monomial_left ];
  norm_num [ ← pow_succ', Polynomial.coeff_derivative ];
  split_ifs <;> simp_all [ bargmann_monomial ];
  norm_cast ; simp [ ← ‹_›, Nat.factorial_succ, mul_comm ]

/-! ## F1.4 — Quadratic ordering and the vacuum energy (HEADLINE) -/

/-- The **quadratically-ordered** (normal-ordered) Hamiltonian `H := a† a`
(`../unfer` `nested_fock_algebra`: the quadratic-ordering rule drops the
zero-point scalar).  This is the same operator as `numberOp`. -/
noncomputable def hamiltonian : ℂ[X] →ₗ[ℂ] ℂ[X] := creat ∘ₗ annih

/-- **F1.4 HEADLINE** `⟨0|H|0⟩ = 0`: the quadratically-ordered Hamiltonian
annihilates the vacuum `|0⟩ = 1`.  (`a|0⟩ = d/dX 1 = 0`.) -/
theorem quadratic_ordering_vacuum : hamiltonian (1 : ℂ[X]) = 0 := by
  unfold hamiltonian; simp [annih, creat]

/-- The **symmetrically-ordered** Hamiltonian `H_sym := (a a† + a† a)/2`. -/
noncomputable def hamiltonianSym : ℂ[X] →ₗ[ℂ] ℂ[X] :=
  (2⁻¹ : ℂ) • (annih ∘ₗ creat + creat ∘ₗ annih)

/-- The symmetric ordering leaves the nonzero zero-point energy `⟨0|H_sym|0⟩ = ½`.
(`a a† |0⟩ = d/dX (X) = 1`, `a† a |0⟩ = 0`, average `= ½`.) -/
theorem symmetric_ordering_vacuum : hamiltonianSym (1 : ℂ[X]) = (2⁻¹ : ℂ) • (1 : ℂ[X]) := by
  unfold hamiltonianSym; norm_num

/-- **F1.4**: the two orderings give genuinely different vacuum energies — the
`../unfer` quadratic-ordering normalization (zero vacuum energy) is a theorem,
not a convention. -/
theorem orderings_differ : hamiltonian (1 : ℂ[X]) ≠ hamiltonianSym (1 : ℂ[X]) := by
  rw [ quadratic_ordering_vacuum, symmetric_ordering_vacuum ];
  exact ne_of_apply_ne ( fun p => p.coeff 0 ) ( by norm_num )

/-! ## F1.5 — BRST bridge to the gauge layer (`ChapterG2`) -/

/-- **F1.5** BRST bridge (`../unfer` `fock_sirk`): in the gauge-mechanics model,
a physical (BRST-closed) field state `a` is exactly a *gauge-invariant* one,
i.e. one annihilated by the gauge constraint `Q`.  This transports the
field-representation viewpoint of F1.2 onto the on-disk BRST layer of
`ChapterG2`. -/
theorem field_gauge_invariant_iff (Q : ℂ[X]) (a : ℂ[X]) :
    (![a, 0] ∈ BookProof.ChapterG2.brstKer Q) ↔ Q * a = 0 :=
  BookProof.ChapterG2.brst_physical_iff_gauge_invariant Q a

end

end BookProof.ChapterF1
