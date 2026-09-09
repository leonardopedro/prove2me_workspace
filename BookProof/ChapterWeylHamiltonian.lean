import Mathlib

/-!
# Chapter "Timepiece and the Gribov ambiguity", §"Renormalization, the mass gap and the Millennium
prize"

Source: `book.tex`, chapter *"Timepiece and the Gribov ambiguity"*,
§*"Free electromagnetic field: an exact example"* / §*"Renormalization, the mass
gap and the Millennium prize"* (lines ~7480–7520), and the parallel Weyl-gauge
Hamiltonian in the chapter *"Quantization due to time-evolution: Yang-Mills and
Classical Statistical Field Theory"*, §*"Pure SU(3) Yang-Mills theory"*
(line ~7060).

The book reduces the Yang–Mills Hamiltonian, after BRST gauge fixing, to the
**Weyl-gauge Hamiltonian density**

  `H_W(x) = ½ πⁱₐ πⁱₐ + ½ Bᵢₐ Bᵢₐ`

(a sum of squares of the *self-adjoint* electric-field operators `πⁱₐ` and
magnetic-field operators `Bᵢₐ`; the sign is a convention of the classical
action). The central claim used in the mass-gap discussion is:

> "We can easily conclude that the Hamiltonian in the Weyl gauge is **positive
> definite** and thus … Yang-Mills theory can be reformulated with or without a
> mass gap without any observable consequences."

Positive-definiteness (bounded below by `0`) is exactly what makes the mass-gap
argument of §"Mass gap" applicable, so this file formalizes that self-contained
mathematical fact.

## What is proved

Work on an arbitrary complex Hilbert space `H` (the physical state space).
Model the electric-field operators `π : Fin n → H →L[ℂ] H` and the
magnetic-field operators `B : Fin m → H →L[ℂ] H` as bounded **self-adjoint**
operators (`IsSelfAdjoint`, the physical requirement that they are observables).
Define the Weyl-gauge Hamiltonian

  `weylHamiltonian π B = ½ • (∑ i, (π i)² ) + ½ • (∑ a, (B a)² )`.

* `selfAdjoint_sq_isPositive` — the square of a self-adjoint operator is a
  positive operator (its expectation values are `≥ 0`).
* `smul_nonneg_isPositive` — a nonnegative real multiple of a positive operator
  is positive.
* `weylHamiltonian_isPositive` — **the Weyl-gauge Hamiltonian is a positive
  operator** (`(weylHamiltonian π B).IsPositive`); this is the book's
  "positive definite" statement.
* `weylHamiltonian_expectation_nonneg` — every expectation value is `≥ 0`
  (`0 ≤ re ⟪weylHamiltonian π B x, x⟫`), the operational form of
  "positive definite" / "bounded below by `0`".
* `weylHamiltonian_isSelfAdjoint` — the Weyl-gauge Hamiltonian is itself
  self-adjoint (a genuine observable).
-/

namespace BookProof.WeylHamiltonian

open ContinuousLinearMap
open scoped BigOperators

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- The square of a self-adjoint operator is a positive operator. -/
theorem selfAdjoint_sq_isPositive (T : H →L[ℂ] H) (h : IsSelfAdjoint T) :
    (T ∘L T).IsPositive := by
  have hh : adjoint T = T := h
  have hp := isPositive_adjoint_comp_self T
  rwa [hh] at hp

omit [CompleteSpace H] in
/-- A nonnegative real scalar multiple of a positive operator is positive. -/
theorem smul_nonneg_isPositive (T : H →L[ℂ] H) (h : T.IsPositive)
    {c : ℝ} (hc : 0 ≤ c) : ((c : ℂ) • T).IsPositive := by
  constructor
  · intro x y
    simp only [Complex.coe_smul, coe_smul, LinearMap.smul_apply, coe_coe] 
    have hinner := h.1 x y
    simp only [coe_coe, Complex.real_smul] at hinner ⊢
    calc
      inner ℂ (c • T x) y = c * inner ℂ (T x) y := by simpa using congr_arg (fun z => c • z) hinner
      _ = c * inner ℂ x (T y) := by rw [hinner]
      _ = inner ℂ x (c • T y) := by simpa using congr_arg (fun z => c • z) hinner
  · simp only [reApplyInnerSelf, Complex.coe_smul, coe_smul', Pi.smul_apply, RCLike.re_to_complex]
    intro x
    have : (inner ℂ (c • T x) x).re = c * (inner ℂ (T x) x).re := by
      simp 
    rw [this]
    exact mul_nonneg hc (h.2 x)

/-- The Weyl-gauge Yang–Mills Hamiltonian density
`H_W = ½ Σᵢ πᵢ² + ½ Σₐ Bₐ²`, built from the self-adjoint electric-field
operators `π` and magnetic-field operators `B`. -/
noncomputable def weylHamiltonian {n m : ℕ}
    (π : Fin n → H →L[ℂ] H) (B : Fin m → H →L[ℂ] H) : H →L[ℂ] H :=
  ((1 / 2 : ℝ) : ℂ) • (∑ i, (π i ∘L π i)) + ((1 / 2 : ℝ) : ℂ) • (∑ a, (B a ∘L B a))

/-- **The Weyl-gauge Hamiltonian is positive** ("positive definite" in the
book), for self-adjoint electric and magnetic field operators. -/
theorem weylHamiltonian_isPositive {n m : ℕ}
    (π : Fin n → H →L[ℂ] H) (B : Fin m → H →L[ℂ] H)
    (hπ : ∀ i, IsSelfAdjoint (π i)) (hB : ∀ a, IsSelfAdjoint (B a)) :
    (weylHamiltonian π B).IsPositive := by
  refine ContinuousLinearMap.IsPositive.add ?_ ?_
  · refine smul_nonneg_isPositive _ ?_ (by norm_num)
    exact ContinuousLinearMap.isPositive_sum _ (fun i _ => selfAdjoint_sq_isPositive _ (hπ i))
  · refine smul_nonneg_isPositive _ ?_ (by norm_num)
    exact ContinuousLinearMap.isPositive_sum _ (fun a _ => selfAdjoint_sq_isPositive _ (hB a))

/-- Operational form of positive-definiteness: every expectation value of the
Weyl-gauge Hamiltonian is nonnegative (hence it is bounded below by `0`). -/
theorem weylHamiltonian_expectation_nonneg {n m : ℕ}
    (π : Fin n → H →L[ℂ] H) (B : Fin m → H →L[ℂ] H)
    (hπ : ∀ i, IsSelfAdjoint (π i)) (hB : ∀ a, IsSelfAdjoint (B a)) (x : H) :
    0 ≤ RCLike.re (inner ℂ ((weylHamiltonian π B) x) x) :=
  (weylHamiltonian_isPositive π B hπ hB).2 x

/-- The Weyl-gauge Hamiltonian is itself self-adjoint (a genuine observable). -/
theorem weylHamiltonian_isSelfAdjoint {n m : ℕ}
    (π : Fin n → H →L[ℂ] H) (B : Fin m → H →L[ℂ] H)
    (hπ : ∀ i, IsSelfAdjoint (π i)) (hB : ∀ a, IsSelfAdjoint (B a)) :
    IsSelfAdjoint (weylHamiltonian π B) := by
  have h_sq_selfAdjoint : ∀ i, IsSelfAdjoint ((π i) ∘L (π i)) := by
    simp_all [IsSelfAdjoint]
    simp_all [star, ContinuousLinearMap.ext_iff]
  have h_B_sq_selfAdjoint : ∀ a, IsSelfAdjoint ((B a) ∘L (B a)) := by
    simp_all [IsSelfAdjoint, ContinuousLinearMap.ext_iff]
    simp_all [star, ContinuousLinearMap.comp_apply]
  unfold weylHamiltonian
  simp_all [IsSelfAdjoint, Finset.smul_sum]

end BookProof.WeylHamiltonian
