import Mathlib

/-!
# Chapter "Free field parametrization in Classical Statistical Field Theory and
Navier-Stokes equations" — the momentum-constraint commutation identity

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier-Stokes equations"*, section *"Free field parametrization
in Statistical Field Theory"* (displayed equation at line ~3948).

For a Hamiltonian depending on the fields up to first-order derivatives, the book
imposes the *momentum constraint* `i D_x = 0`.  It then states that, **because the
Hamiltonian commutes with the constraint**, the following two commutator
identities hold (for the field `φ⁽⁰⁾` and the momentum `p₍₁₎`):

```
[[i D_x, φ⁽⁰⁾], H] = -[i D_x, [H, φ⁽⁰⁾]]
[[i D_x, p₍₁₎], H] = -[i D_x, [H, p₍₁₎]]
```

Both are instances of a single, purely algebraic fact about the commutator
bracket `⁅a, b⁆ = a·b − b·a` in any (non-commutative, associative) ring: **if the
constraint `D` commutes with the Hamiltonian `H`, then for every operator `A`**

```
⁅⁅D, A⁆, H⁆ = -⁅D, ⁅H, A⁆⁆.
```

This is a direct consequence of the Jacobi identity together with `⁅D, H⁆ = 0`.
This file formalizes:

* `bracket` — the ring commutator, with `bracket_antisymm` and `bracket_self`;
* `bracket_jacobi` — the Jacobi identity for the commutator bracket;
* `constraint_commute_symm` — `⁅D, H⁆ = 0 ↔ ⁅H, D⁆ = 0`;
* `constraint_commutation_identity` — the headline `⁅⁅D, A⁆, H⁆ = -⁅D, ⁅H, A⁆⁆`
  (book.tex ~3948), stated for a general operator `A`;
* `constraint_commutation_identity_field` / `constraint_commutation_identity_momentum`
  — the two literal book instances (`A = φ⁽⁰⁾` and `A = p₍₁₎`);
* `constraint_preserved_under_bracket` — if the constraint commutes with both `H`
  and `A`, it commutes with `⁅H, A⁆` (the constraint is conserved by the
  Hamiltonian flow of a compatible operator).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.FreeFieldConstraint

variable {R : Type*} [Ring R]

/-- The commutator bracket `⁅a, b⁆ = a·b − b·a` on a (non-commutative) ring; this
is the algebraic form of the commutator of operators used throughout the free-field
chapter. -/
def bracket (a b : R) : R := a * b - b * a

@[simp] theorem bracket_self (a : R) : bracket a a = 0 := by
  simp [bracket]

/-- The commutator bracket is antisymmetric: `⁅a, b⁆ = -⁅b, a⁆`. -/
theorem bracket_antisymm (a b : R) : bracket a b = - bracket b a := by
  simp only [bracket]; abel

/-- `⁅a, 0⁆ = 0`. -/
@[simp] theorem bracket_zero_right (a : R) : bracket a (0 : R) = 0 := by
  simp [bracket]

/-- `⁅0, a⁆ = 0`. -/
@[simp] theorem bracket_zero_left (a : R) : bracket (0 : R) a = 0 := by
  simp [bracket]

/-- The **Jacobi identity** for the commutator bracket. -/
theorem bracket_jacobi (a b c : R) :
    bracket (bracket a b) c + bracket (bracket b c) a + bracket (bracket c a) b = 0 := by
  simp only [bracket]; noncomm_ring

/-- The constraint commutes with the Hamiltonian iff the Hamiltonian commutes with
the constraint. -/
theorem constraint_commute_symm (D H : R) : bracket D H = 0 ↔ bracket H D = 0 := by
  constructor <;> intro h
  · rw [bracket_antisymm, h, neg_zero]
  · rw [bracket_antisymm, h, neg_zero]

/-- **The momentum-constraint commutation identity** (`book.tex` ~3948).

If the constraint `D` commutes with the Hamiltonian `H` (`⁅D, H⁆ = 0`), then for
every operator `A`,

```
⁅⁅D, A⁆, H⁆ = -⁅D, ⁅H, A⁆⁆.
```
-/
theorem constraint_commutation_identity (D H A : R) (hDH : bracket D H = 0) :
    bracket (bracket D A) H = - bracket D (bracket H A) := by
  have key : bracket (bracket D A) H + bracket D (bracket H A)
      = - bracket A (bracket D H) := by
    simp only [bracket]; noncomm_ring
  rw [hDH] at key
  simp only [bracket_zero_right, neg_zero] at key
  exact eq_neg_of_add_eq_zero_left key

/-- The first literal book instance, for the field `φ⁽⁰⁾`:
`⁅⁅D, φ⁰⁆, H⁆ = -⁅D, ⁅H, φ⁰⁆⁆`. -/
theorem constraint_commutation_identity_field (D H φ0 : R) (hDH : bracket D H = 0) :
    bracket (bracket D φ0) H = - bracket D (bracket H φ0) :=
  constraint_commutation_identity D H φ0 hDH

/-- The second literal book instance, for the momentum `p₍₁₎`:
`⁅⁅D, p₁⁆, H⁆ = -⁅D, ⁅H, p₁⁆⁆`. -/
theorem constraint_commutation_identity_momentum (D H p1 : R) (hDH : bracket D H = 0) :
    bracket (bracket D p1) H = - bracket D (bracket H p1) :=
  constraint_commutation_identity D H p1 hDH

/-- **Conservation of the constraint.**  If the constraint `D` commutes with both
the Hamiltonian `H` and an operator `A`, then it commutes with `⁅H, A⁆` — i.e. the
class of `D`-invariant operators is closed under the Hamiltonian bracket. -/
theorem constraint_preserved_under_bracket (D H A : R)
    (hDH : bracket D H = 0) (hDA : bracket D A = 0) :
    bracket D (bracket H A) = 0 := by
  have h := constraint_commutation_identity D H A hDH
  rw [hDA, bracket_zero_left] at h
  rw [eq_comm, neg_eq_zero] at h
  exact h

end BookProof.FreeFieldConstraint
