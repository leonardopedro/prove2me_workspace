import Mathlib
import BookProof.ChapterF1

/-!
# Chapter F2 — the mass gap in the Bargmann–Fock model (roadmap N7(c), §0 S7)

This file formalizes the mathematically self-contained content of the book's
**"Mass gap"** section (`book.tex` ~line 4060), continuing the polynomial
(Bargmann–Fock) field model of `BookProof.ChapterF1` and following the `../unfer`
design decisions (§0 S7: quadratic ordering, Hermitian field representation,
`nested_fock_algebra` crate).

Following the book's own definition — *"the mass gap is the eigenvalue of the
Hamiltonian which is closer to the null eigenvalue corresponding to the vacuum
state"* — the Hamiltonian is the quadratically-ordered
`H := a† a = N` (`ChapterF1.hamiltonian`, the number operator).  On the monomial
basis `H Xⁿ = n·Xⁿ` (`ChapterF1.numberOp_monomial`), so the spectrum is `ℕ`, the
vacuum `|0⟩ = 1` has energy `0`, and the mass gap is `Δ = 1`.

## Deliverables

* **F2.1 `numberOp_coeff`** — the coefficient formula `(N p)_n = n · p_n`, and
  `numberOp_support` (`N` does not enlarge the support).
* **F2.2 `hamiltonian_expectation_nonneg`** — the Hamiltonian is *bounded from
  below / positive*: `⟨ψ|H|ψ⟩ ≥ 0` for every state (the quadratic ordering makes
  the vacuum energy the infimum; book: *"the Hamiltonian can be bounded from
  below because it is defined a priori with a correct (Quadratic) ordering"*).
* **F2.3 mass-gap deformation** — `deformedHamiltonian c := c • N`
  (`= H + (c−1)·N`), `deformedHamiltonian_monomial` (`H_c Xⁿ = (c·n)·Xⁿ`, so the
  mass gap becomes `c`, an arbitrary positive number, with unchanged
  eigenstates) and `deformedHamiltonian_commutes_numberOp` (`[H_c, N] = 0`) —
  the book's claim that *"the number operator can be added to the Hamiltonian,
  modifying the mass gap without observable consequences"* (`[H, N] = 0`).
* **F2.4 HEADLINE `mass_gap`** — for any state `ψ` orthogonal to the vacuum
  (`ψ₀ = 0`), `⟨ψ|H|ψ⟩ ≥ ⟨ψ|ψ⟩`: the spectrum of `H` above the vacuum is bounded
  below by the mass gap `Δ = 1`.  The gap is *tight*: `mass_gap_attained`
  (`⟨X|H|X⟩ = ⟨X|X⟩`, the first excited state saturates it), and the vacuum
  energy is `0` (`vacuum_energy_zero`).  `massGap_smallest_excited` records the
  eigenvalue-form statement (`1` is the smallest positive eigenvalue).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.
-/

open Polynomial Finset
open scoped BigOperators

namespace BookProof.ChapterF2

open BookProof.ChapterF1

noncomputable section

/-! ## F2.1 — Coefficients of the number operator -/

/-- **F2.1**: the coefficient of `N p = a† a p = X·(d/dX p)` at degree `n`
is `n · p_n`.  (Consistent with `numberOp_monomial`: on `Xⁿ` this is `n·Xⁿ`.) -/
theorem numberOp_coeff (p : ℂ[X]) (n : ℕ) :
    (numberOp p).coeff n = (n : ℂ) * p.coeff n := by
  simp only [numberOp, LinearMap.comp_apply, creat_apply, annih_apply]
  cases n with
  | zero => simp
  | succ m => rw [Polynomial.coeff_X_mul, Polynomial.coeff_derivative]; push_cast; ring

/-- The number operator does not enlarge the support: `N p` vanishes wherever
`p` does. -/
theorem numberOp_support (p : ℂ[X]) : (numberOp p).support ⊆ p.support := by
  intro n hn
  simp only [Polynomial.mem_support_iff] at *
  intro h; apply hn; rw [numberOp_coeff, h, mul_zero]

/-! ## F2.2 — Real form of the energy expectation and positivity -/

/-- The Bargmann norm-square of `p` in real form:
`⟨p|p⟩ = Σ n!·|p_n|²` (a sum of nonnegative reals). -/
theorem bargmann_self_re (p : ℂ[X]) :
    (bargmann p p).re = ∑ n ∈ p.support, (n.factorial : ℝ) * Complex.normSq (p.coeff n) := by
  rw [bargmann_eq_sum p p (Finset.Subset.refl _) (Finset.Subset.refl _), Complex.re_sum]
  apply Finset.sum_congr rfl
  intro n hn
  have : (n.factorial : ℂ) * (starRingEnd ℂ) (p.coeff n) * p.coeff n
      = (n.factorial : ℂ) * (p.coeff n * (starRingEnd ℂ) (p.coeff n)) := by ring
  rw [this, Complex.mul_conj]; simp

/-- The energy expectation `⟨p|H|p⟩` (`H = N`) in real form:
`⟨p|N|p⟩ = Σ n·n!·|p_n|²`. -/
theorem bargmann_numberOp_re (p : ℂ[X]) :
    (bargmann p (numberOp p)).re
      = ∑ n ∈ p.support, ((n : ℝ) * n.factorial) * Complex.normSq (p.coeff n) := by
  rw [bargmann_eq_sum p (numberOp p) (Finset.Subset.refl _) (numberOp_support p), Complex.re_sum]
  apply Finset.sum_congr rfl
  intro n hn
  rw [numberOp_coeff]
  have : (n.factorial : ℂ) * (starRingEnd ℂ) (p.coeff n) * ((n : ℂ) * p.coeff n)
      = ((n : ℂ) * n.factorial) * (p.coeff n * (starRingEnd ℂ) (p.coeff n)) := by ring
  rw [this, Complex.mul_conj]; simp

/-- **F2.2**: the quadratically-ordered Hamiltonian `H = a† a` is *positive*
(bounded from below): the energy expectation of every state is nonnegative.
This is the book's *"the Hamiltonian can be bounded from below because it is
defined a priori with a correct (Quadratic) ordering"*. -/
theorem hamiltonian_expectation_nonneg (p : ℂ[X]) :
    0 ≤ (bargmann p (numberOp p)).re := by
  rw [bargmann_numberOp_re]
  apply Finset.sum_nonneg
  intro n hn
  exact mul_nonneg (by positivity) (Complex.normSq_nonneg _)

/-! ## F2.3 — Deforming the mass gap by adding the number operator -/

/-- The **deformed Hamiltonian** `H_c := c • N` (equivalently `H + (c−1)·N`,
adding a multiple of the number operator to `H = N`).  Because `[H, N] = 0`, this
modifies the mass gap without changing the observable algebra (generated by `N`)
or the eigenstates — the book's *"the number operator can be added to the
Hamiltonian, modifying the mass gap without observable consequences"*. -/
noncomputable def deformedHamiltonian (c : ℂ) : ℂ[X] →ₗ[ℂ] ℂ[X] := c • numberOp

/-- **F2.3**: the monomials remain eigenvectors of the deformed Hamiltonian,
`H_c Xⁿ = (c·n)·Xⁿ`.  For real `c > 0` the smallest positive eigenvalue — the
mass gap — is `c`, an *arbitrary* positive number, while the eigenstates `Xⁿ`
are unchanged. -/
theorem deformedHamiltonian_monomial (c : ℂ) (n : ℕ) :
    deformedHamiltonian c (X ^ n) = (c * n) • X ^ n := by
  simp only [deformedHamiltonian, LinearMap.smul_apply, numberOp_monomial, smul_smul]

/-- **F2.3**: the deformed Hamiltonian commutes with the number operator,
`[H_c, N] = 0` — the deformation preserves the algebra of observables. -/
theorem deformedHamiltonian_commutes_numberOp (c : ℂ) :
    deformedHamiltonian c ∘ₗ numberOp = numberOp ∘ₗ deformedHamiltonian c := by
  ext p; simp [deformedHamiltonian, LinearMap.smul_apply]

/-- The undeformed Hamiltonian commutes with the number operator (`H = N`). -/
theorem hamiltonian_commutes_numberOp :
    hamiltonian ∘ₗ numberOp = numberOp ∘ₗ hamiltonian := rfl

/-! ## F2.4 — The mass gap (HEADLINE) -/

/-- **F2.4 HEADLINE — the mass gap `Δ = 1`.**  For any state `ψ` orthogonal to
the vacuum `|0⟩ = 1` (i.e. with vanishing constant term `ψ₀ = 0`), the energy
expectation is at least the norm-square: `⟨ψ|H|ψ⟩ ≥ ⟨ψ|ψ⟩`.  Equivalently, on
the orthogonal complement of the vacuum, `H ≥ Δ·1` with `Δ = 1` — the spectrum
of `H` above the vacuum is bounded below by the mass gap. -/
theorem mass_gap (ψ : ℂ[X]) (hψ : ψ.coeff 0 = 0) :
    (bargmann ψ ψ).re ≤ (bargmann ψ (numberOp ψ)).re := by
  rw [bargmann_self_re, bargmann_numberOp_re]
  apply Finset.sum_le_sum
  intro n hn
  have hn1 : 1 ≤ n := by
    rcases Nat.eq_zero_or_pos n with h | h
    · subst h; simp only [Polynomial.mem_support_iff] at hn; exact absurd hψ hn
    · exact h
  have hnn : (n.factorial : ℝ) ≤ (n : ℝ) * n.factorial := by
    nlinarith [Nat.factorial_pos n, (by exact_mod_cast hn1 : (1 : ℝ) ≤ n)]
  exact mul_le_mul_of_nonneg_right hnn (Complex.normSq_nonneg _)

/-- The vacuum energy is `0`: `⟨0|H|0⟩ = 0` (the quadratic-ordering
normalization of `ChapterF1.quadratic_ordering_vacuum`). -/
theorem vacuum_energy_zero : bargmann (1 : ℂ[X]) (hamiltonian (1 : ℂ[X])) = 0 := by
  rw [show hamiltonian (1 : ℂ[X]) = 0 from quadratic_ordering_vacuum]; simp [bargmann]

/-- **F2.4**: the mass gap `Δ = 1` is *attained* by the first excited state `X`:
`⟨X|H|X⟩ = ⟨X|X⟩`.  Together with `mass_gap`, this shows `Δ = 1` is exactly the
gap, not merely a lower bound. -/
theorem mass_gap_attained : bargmann X (hamiltonian X) = bargmann X X := by
  have hX : hamiltonian (X : ℂ[X]) = X := by
    change numberOp X = X
    simpa using numberOp_monomial 1
  rw [hX]

/-- **F2.4** (eigenvalue form): `1` is the smallest *positive* eigenvalue of the
Hamiltonian on the monomial basis — `H Xⁿ = n·Xⁿ` and any excited state
(`n ≠ 0`) has eigenvalue `≥ 1`.  This is the book's definition of the mass gap
as *"the eigenvalue of the Hamiltonian which is closer to the null eigenvalue"*. -/
theorem massGap_smallest_excited (n : ℕ) (hn : n ≠ 0) :
    hamiltonian (X ^ n) = (n : ℂ) • X ^ n ∧ (1 : ℕ) ≤ n :=
  ⟨numberOp_monomial n, Nat.one_le_iff_ne_zero.mpr hn⟩

end

end BookProof.ChapterF2
