import Mathlib

/-!
# Chapter — Yang–Mills / Classical Statistical Field Theory: the ℤ₂-graded
(super) commutator that unifies the bosonic and fermionic canonical relations

Source: `book.tex`, chapter *"Timepiece and the Gribov ambiguity"*, §*"Pure
Yang-Mills theory"* (line ~7300) and the parent chapter *"Quantization due to
time-evolution: Yang-Mills and Classical Statistical Field Theory"*.

For `SU(3)` Yang–Mills the author builds the Hilbert space as a tensor product
of a symmetric (bosonic) and an antisymmetric (fermionic) Fock space, obtaining
*"a graded Lie superalgebra of creation and annihilation operators, of both
bosonic and fermionic types"*.  The unified canonical (anti)commutation relation
displayed there carries the sign `(-1)^{(α mod 2)(β mod 2)}`:

```
[a(x,…,α), a†(y,…,β)} = a(x,…,α) a†(y,…,β) + (-1)^{(α mod 2)(β mod 2)} a†(y,…,β) a(x,…,α)
```

so that two *bosonic* (even) operators obey the **commutator** relation while two
*fermionic* (odd) operators obey the **anticommutator** relation.  This is the
defining sign of a ℤ₂-graded (super) Lie algebra.

This file isolates that self-contained algebraic content.  In an arbitrary
associative (unital) ring `R` — the algebra of operators — we model the ℤ₂-parity
of a homogeneous element by a `Bool` (`false` = even/bosonic, `true` =
odd/fermionic) and define

* `eps p q = (-1)^{p·q}` (`= -1` iff both `p` and `q` are odd) — the Koszul sign;
* `sbracket p q a b = a·b − ε(p,q)·(b·a)` — the **super-bracket** `⟦a,b⟧`.

We prove:

* `sbracket_even_even` — for two even elements `⟦a,b⟧ = ab − ba` is the ordinary
  **commutator** (bosonic CCR side);
* `sbracket_odd_odd` — for two odd elements `⟦a,b⟧ = ab + ba` is the
  **anticommutator** (fermionic CAR side): this is the single formula unifying
  the two canonical relations of the book;
* `eps_comm`, `eps_mul_self`, `eps_even_left`/`eps_even_right` — the Koszul sign
  is symmetric, squares to `1`, and is trivial against an even element;
* `sbracket_graded_antisymm` — **graded antisymmetry** `⟦a,b⟧ = −ε(p,q)⟦b,a⟧`;
* `super_jacobi` — **headline**: the graded Jacobi identity
  `ε(p,r)⟦a,⟦b,c⟧⟧ + ε(q,p)⟦b,⟦c,a⟧⟧ + ε(r,q)⟦c,⟦a,b⟧⟧ = 0`,
  which makes `(R, ⟦·,·⟧)` a **Lie superalgebra** — exactly the "graded Lie
  superalgebra" structure the book asserts for the creation/annihilation
  operators.  (The inner bracket `⟦b,c⟧` carries parity `xor q r`.)

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterSuperBracket

variable {R : Type*} [Ring R]

/-- The Koszul sign `ε(p,q) = (-1)^{p·q}`, valued in `ℤ`: it is `-1` exactly when
both parities are odd (`true`), and `+1` otherwise.  `false` models an even
(bosonic) degree, `true` an odd (fermionic) degree. -/
def eps (p q : Bool) : ℤ := if (p && q) then -1 else 1

@[simp] lemma eps_false_left (q : Bool) : eps false q = 1 := rfl
@[simp] lemma eps_false_right (p : Bool) : eps p false = 1 := by
  cases p <;> rfl
@[simp] lemma eps_true_true : eps true true = -1 := rfl

/-- The Koszul sign is symmetric: `ε(p,q) = ε(q,p)`. -/
lemma eps_comm (p q : Bool) : eps p q = eps q p := by
  cases p <;> cases q <;> rfl

/-- The Koszul sign is a genuine sign: `ε(p,q)² = 1`. -/
lemma eps_mul_self (p q : Bool) : eps p q * eps p q = 1 := by
  cases p <;> cases q <;> rfl

/-- The super-bracket `⟦a,b⟧ = a·b − ε(p,q)·(b·a)` of two homogeneous elements
`a` (parity `p`) and `b` (parity `q`) of the operator algebra `R`. -/
def sbracket (p q : Bool) (a b : R) : R := a * b - (eps p q : R) * (b * a)

/-- For two **even** (bosonic) elements the super-bracket is the ordinary
**commutator** `⟦a,b⟧ = a·b − b·a`. -/
lemma sbracket_even_even (a b : R) : sbracket false false a b = a * b - b * a := by
  simp [sbracket]

/-- For two **odd** (fermionic) elements the super-bracket is the
**anticommutator** `⟦a,b⟧ = a·b + b·a`: the single formula unifying the bosonic
CCR and fermionic CAR of the book. -/
lemma sbracket_odd_odd (a b : R) : sbracket true true a b = a * b + b * a := by
  simp only [sbracket, eps_true_true]
  push_cast
  noncomm_ring

/-- Against an even element the super-bracket is always the commutator
(the sign is trivial): `⟦a,b⟧ = a·b − b·a` when `b` is even. -/
lemma sbracket_even_right (p : Bool) (a b : R) :
    sbracket p false a b = a * b - b * a := by
  simp [sbracket]

/-- Against an even element on the left the super-bracket is the commutator. -/
lemma sbracket_even_left (q : Bool) (a b : R) :
    sbracket false q a b = a * b - b * a := by
  simp [sbracket]

/-- **Graded antisymmetry**: `⟦a,b⟧ = −ε(p,q)·⟦b,a⟧`.  For even/even this is the
usual antisymmetry `[a,b] = −[b,a]`; for odd/odd it is the symmetry of the
anticommutator `{a,b} = {b,a}`. -/
lemma sbracket_graded_antisymm (p q : Bool) (a b : R) :
    sbracket p q a b = - (eps p q : R) * sbracket q p b a := by
  cases p <;> cases q <;>
    · simp only [sbracket, eps, Bool.and_true, Bool.and_false]
      push_cast
      noncomm_ring

/-- **Headline — the graded Jacobi identity.**  With the Koszul signs, the
super-bracket satisfies

`ε(p,r)·⟦a,⟦b,c⟧⟧ + ε(q,p)·⟦b,⟦c,a⟧⟧ + ε(r,q)·⟦c,⟦a,b⟧⟧ = 0`,

where `a,b,c` have parities `p,q,r` and the inner bracket `⟦b,c⟧` carries parity
`xor q r`.  This is precisely the axiom (beyond graded antisymmetry) that makes
`(R, ⟦·,·⟧)` a **Lie superalgebra**, i.e. the "graded Lie superalgebra of
creation and annihilation operators" the book attaches to the Yang–Mills Fock
space.  For all-even parities it specializes to the ordinary Jacobi identity of
the commutator. -/
theorem super_jacobi (p q r : Bool) (a b c : R) :
    (eps p r : R) * sbracket p (xor q r) a (sbracket q r b c)
  + (eps q p : R) * sbracket q (xor r p) b (sbracket r p c a)
  + (eps r q : R) * sbracket r (xor p q) c (sbracket p q a b) = 0 := by
  cases p <;> cases q <;> cases r <;>
    · simp only [sbracket, eps, Bool.and_true, Bool.and_false, Bool.xor_true,
        Bool.xor_false, Bool.not_true, Bool.not_false]
      push_cast
      noncomm_ring

/-- The all-even specialization of `super_jacobi` is the ordinary Jacobi identity
of the commutator `[a,b] = a·b − b·a`. -/
lemma commutator_jacobi (a b c : R) :
    sbracket false false a (sbracket false false b c)
  + sbracket false false b (sbracket false false c a)
  + sbracket false false c (sbracket false false a b) = 0 := by
  have h := super_jacobi (R := R) false false false a b c
  simpa using h

end BookProof.ChapterSuperBracket
