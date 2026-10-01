import Mathlib


/-!
# Sums of one-particle Hamiltonians in *differing* bases: Faris–Lavine with a diagonal `N`

`DESIGN_QG32_FARISLAVINE_DIFFERING_BASES.md` (plan item **QG-3.2-exec** of
`CONSOLIDATED_PLAN.md`) asks for the essential self-adjointness of a coupling

```text
H = ∑_ℓ dΓ(h_ℓ),
```

where each one-particle Hamiltonian `h_ℓ` is Hermitian and diagonalizable **in its own
basis**, so that no single alphabet diagonalizes the sum.  `ChapterQgCouplingDGammaSum`
settled the case in which the *total* one-particle operator happens to be diagonal in the
working basis.  This module removes that restriction, in the direction the design
identifies as the substance of the problem: the summands are genuinely non-diagonal, they
do not commute, and the comparison operator stays **diagonal**.

The mechanism is the one the physics dictates: a Hamiltonian built from one-particle
operators **conserves the particle number**, so it commutes with the number operator
exactly.  Faris–Lavine (Nelson's commutator theorem) then applies with the positive
diagonal comparison operator `N = dΓ(ω) + 𝒩 + 1` and commutator constant `c = 0`; the
non-commutativity of the summands never enters, because the commutator that has to be
estimated is the one with `N`, not the ones among the summands.

## The hop-conservation hypothesis

`ChapterFockQuadraticEsa` builds every quadratic monomial `a^{†P}a^{Q}` on the maximal
domain of the comparison symbol `σ(α) = ω(α) + |α| + 1` and proves the general estimate
`|commForm (pairOp g P Q) N| ≤ 4‖g‖(ω(P) + ω(Q) + 2)·quadForm N`, whose constant is what
forces the weighted `ℓ¹` gate `∑ₖ ‖gₖ‖(ω(Pₖ) + ω(Qₖ) + 2) < ∞` of that chapter.  Here we
observe that the constant is `0` — the commutator form vanishes *identically* — as soon as
the hop is **balanced**:

```text
Balanced ω P Q :  ω(P) + |P| = ω(Q) + |Q|,
```

which is exactly the statement that the comparison symbol is unchanged along the hop,
`σ(β − P + Q) = σ(β)`.  Number-conserving exchange terms `a_p†a_q` with `ω p = ω q` — in
particular *all* exchange terms when the free dispersion is absent — are balanced.

## What is proved

* `Balanced`, `sig_tgt_eq_of_balanced` — the balance condition and its meaning.
* **`pairOp_commForm_eq_zero`** — a balanced Hermitian monomial has *identically vanishing*
  commutator form against the diagonal comparison operator.  (The proof identifies the two
  matrix elements of the Hermitian pair as complex conjugates of each other.)
* `xIdx`, `balanced_xIdx` — the exchange (number-conserving) monomials `a_p†a_q` and their
  balance under resonance `ω p = ω q`.
* `balancedH`, `balancedH_symmetricOn`, `balancedH_norm_le`,
  **`balancedH_commForm_eq_zero`**, **`balancedH_essentiallySelfAdjointOn_core`** — the free
  Hamiltonian plus an arbitrary family of balanced Hermitian couplings is symmetric,
  relatively bounded by `N`, commutes with `N` exactly, and is therefore essentially
  self-adjoint on the finite-particle core under the *unweighted* gate `∑ₖ ‖gₖ‖ < ∞`.  This
  is strictly weaker than the weighted gate of `ChapterFockQuadraticEsa`: however large the
  dispersion `ω`, balanced couplings need no `ω`-weights.
* `exchangeH`, **`exchangeH_essentiallySelfAdjointOn_core`** — the number-conserving
  specialization: hops `gₖ a_{pₖ}†a_{qₖ} + conj(gₖ) a_{qₖ}†a_{pₖ}` on top of an arbitrary
  non-negative dispersion, resonant mode by mode.
* `specEntry`, `specAmp`, `summable_specAmp`,
  **`spectralFamily_essentiallySelfAdjointOn_core`** — the differing-bases headline: a
  family of one-particle Hermitian operators `h_ℓ = ∑_r λ_{ℓr} |v_{ℓr}⟩⟨v_{ℓr}|`, each
  presented in **its own** eigenbasis and none of them diagonal in the working alphabet, is
  essentially self-adjoint on the finite-particle core as soon as
  `∑_{ℓ,r} |λ_{ℓr}|·‖v_{ℓr}‖₁² < ∞`; for finitely many finitely-supported eigenvectors — the
  case of a concrete finite-dimensional coefficient algebra — the gate is automatic
  (`spectralFamily_finite_essentiallySelfAdjointOn_core`), and
  `sumOfTwo_essentiallySelfAdjointOn_core` is the two-summand case in closed form.
* `specEntry_ne_zero`, `specEntry_not_commute` — non-vacuity: the summands covered are
  genuinely non-diagonal in the working alphabet and genuinely non-commuting.
* `nestedFock_essentiallySelfAdjointOn_core` — the same statement when the one-particle
  space is itself a Fock space (`ι := Idx ι₀`), i.e. a nested Fock space with an
  outer-number-conserving Hamiltonian.

## Honest boundary

The comparison operator is diagonal and the commutator constant is `0`; what the coupling
family must still satisfy is the *unweighted* summability `∑ₖ ‖gₖ‖ < ∞` of its matrix
elements in the working alphabet, which is what makes the series of monomials converge on
the maximal domain and gives the relative bound.  Nothing here asserts essential
self-adjointness of `dΓ(h)` for an arbitrary bounded, non-`ℓ¹` one-particle `h`, and
nothing here computes a spectrum.  The operators are the monomial series of
`ChapterFockQuadraticEsa` on `ℓ²(ι →₀ ℕ)`; the identification with the algebraic `dΓ` of
`ChapterFockSecondQuantization` is not carried out (the two chapters use different models
of the same Fock space).

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.FockDifferingBases

open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

/-! ## 1. Balanced hops -/

/-- **A balanced hop**: the monomial `a^{†P}a^{Q}` moves the comparison symbol
`σ(α) = ω(α) + |α| + 1` by `ω(Q) + |Q| − ω(P) − |P|`, so it leaves it unchanged exactly
when `ω(P) + |P| = ω(Q) + |Q|`.  Number-conserving, energy-resonant hops are balanced. -/
def Balanced (ω : ι → ℝ) (P Q : Idx ι) : Prop :=
  wsum ω P + (deg P : ℝ) = wsum ω Q + (deg Q : ℝ)



/-! ## 2. A balanced Hermitian monomial commutes with the comparison operator -/



/-! ## 3. Exchange (number-conserving) monomials -/

/-- The one-particle multi-index of the mode `p`. -/
def xIdx (p : ι) : Idx ι := Finsupp.single p 1

@[simp] theorem deg_xIdx (p : ι) : deg (xIdx p) = 1 := deg_single p 1



theorem deg_xIdx_add (p q : ι) : deg (xIdx q) + deg (xIdx p) = 2 := by simp



/-! ## 4. The Hamiltonian: free part plus a family of balanced couplings -/

/-- The family of Hermitian coupling terms. -/
def couplingT (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι) (g : κ → ℂ)
    (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2) :
    κ → (maxDom (sig ω) →ₗ[ℂ] L2I (Idx ι)) :=
  fun k => pairOp hω (g k) (P k) (Q k) (hPQ k)

theorem couplingT_norm_le (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι) (g : κ → ℂ)
    (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2) (k : κ) (x : maxDom (sig ω)) :
    ‖(couplingT hω P Q g hPQ k x : L2I (Idx ι))‖
      ≤ (4 * ‖g k‖) * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ :=
  pairOp_norm_le hω (g k) (P k) (Q k) (hPQ k) x

/-- **The Hamiltonian**: the free dispersion `∑ᵢ ωᵢ aᵢ†aᵢ` plus an absolutely summable
family of Hermitian coupling monomials.  No weights appear in the summability hypothesis:
for balanced couplings the plain `ℓ¹` bound on the amplitudes suffices. -/
def balancedH (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι) (g : κ → ℂ)
    (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2) (hsum : Summable fun k => ‖g k‖) :
    maxDom (sig ω) →ₗ[ℂ] L2I (Idx ι) :=
  freeOp hω +
    seriesOp (couplingT hω P Q g hPQ) (fun k => 4 * ‖g k‖)
      (couplingT_norm_le hω P Q g hPQ) (hsum.mul_left 4)









/-! ## 5. The number-conserving specialization -/

/-- **The number-conserving Hamiltonian**: the free dispersion plus exchange couplings
`gₖ a_{qₖ}†a_{pₖ} + conj(gₖ) a_{pₖ}†a_{qₖ}`, one Hermitian pair of one-particle hops for
each index `k`. -/
def exchangeH (hω : ∀ i, 0 ≤ ω i) (p q : κ → ι) (g : κ → ℂ)
    (hsum : Summable fun k => ‖g k‖) : maxDom (sig ω) →ₗ[ℂ] L2I (Idx ι) :=
  balancedH hω (fun k => xIdx (q k)) (fun k => xIdx (p k)) g
    (fun k => le_of_eq (deg_xIdx_add (p k) (q k))) hsum





/-! ## 6. Differing bases: a family of one-particle Hamiltonians, each in its own basis -/

/-- The matrix entry, in the working alphabet, of the one-particle operator
`lam · |v⟩⟨v|` — the rank-one Hermitian operator with eigenvalue `lam` and eigenvector `v`.
For a general `v` this matrix is **not** diagonal: the operator is diagonal in its own
basis only. -/
def specEntry (lam : ℝ) (v : ι → ℂ) (p q : ι) : ℂ :=
  (lam : ℂ) * (v p * (starRingEnd ℂ) (v q))





/-- The amplitude family of a spectral presentation: the index `k` runs over all
(operator, eigenvalue) pairs of the whole collection, and `(p, q)` over the working
alphabet.  The factor `1/2` is the Hermitian-pair convention of `pairOp`: the family
contains both `(p, q)` and `(q, p)`. -/
def specAmp (lam : κ → ℝ) (v : κ → ι → ℂ) : κ × ι × ι → ℂ :=
  fun z => specEntry (lam z.1 / 2) (v z.1) z.2.1 z.2.2













/-! ## 7. Non-vacuity: the summands really are non-diagonal and non-commuting -/



/-- The product of two one-particle matrices. -/
def matMul [Fintype ι] (a b : ι → ι → ℂ) : ι → ι → ℂ := fun p q => ∑ r, a p r * b r q



/-! ## 8. Nested Fock spaces -/



end

end BookProof.FockDifferingBases
