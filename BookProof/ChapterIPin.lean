import Mathlib

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"Real unitary representations of the Poincaré group", **Definition 77** (the `IPin(3,1)`
/ Poincaré group as a semidirect product)

`book.tex` (§"Real unitary representations of the Poincaré group", line ~6144):

> **Definition 77.** The `IPin(3,1)` group is defined as the semi-direct product
> `Pin(3,1) ⋉ ℝ⁴`, with the group's product defined as
> `(A,a)(B,b) = (A B, a + Λ(A) b)`, for `A,B ∈ Pin(3,1)` and `a,b ∈ ℝ⁴` and
> `Λ(A)` is the Lorentz transformation corresponding to `A`.

We formalize the **group-theoretic content**, which needs only:

* an abstract group `P` (the role of `Pin(3,1)` / `SL(2,ℂ)`),
* the translation module `V` (the role of `ℝ⁴`, any `AddCommGroup`),
* the linear action `Λ : P →* AddAut V` (`Λ(A)` is the additive automorphism of `V`
  given by the Lorentz transformation attached to `A`).

The Poincaré group `IPin` is then the Mathlib **semidirect product**
`Multiplicative V ⋊[φ] P`, where `φ : P →* MulAut (Multiplicative V)` is the action
`Λ` transported through the `Multiplicative` type-tag (`AddEquiv.toMultiplicative`).
An element is a pair with `left : Multiplicative V` (the translation `a`, as
`toAdd left : V`) and `right : P` (the group element `A`).  The two headline lemmas
reproduce the book's product formula `(A,a)(B,b) = (A B, a + Λ(A) b)`:

* `ipin_right` — the `P` component multiplies: `(x·y).right = x.right · y.right`
  (i.e. `A B`);
* `ipin_left` — the translation component twists by `Λ`:
  `toAdd (x·y).left = toAdd x.left + Λ x.right (toAdd y.left)` (i.e. `a + Λ(A) b`).

The restriction to `ISL(2,ℂ)` (Definition 77's second paragraph) is the same
construction with `P` restricted to `Spin⁺(1,3)`; that restriction and the concrete
`Pin(3,1)`/`ℝ⁴` model are left as prose, matching the roadmap constraints (off the
gravity line, off the Hankel-transform line).

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ChapterIPin

open Multiplicative

variable {P V : Type*} [Group P] [AddCommGroup V] (Λ : P →* AddAut V)

/-- The semidirect-product action `φ : P →* MulAut (Multiplicative V)` obtained from
the Lorentz action `Λ : P →* AddAut V` by transport through the `Multiplicative`
type-tag. -/
noncomputable def phiHom : P →* MulAut (Multiplicative V) where
  toFun p := (Λ p).toMultiplicative
  map_one' := by ext v; simp [AddEquiv.toMultiplicative]
  map_mul' p q := by ext v; simp [AddEquiv.toMultiplicative]

/-- **Definition 77.** The `IPin(3,1)` / Poincaré group `Pin(3,1) ⋉ ℝ⁴`, formalized as
the semidirect product `Multiplicative V ⋊[φ] P`. -/
noncomputable def IPin := Multiplicative V ⋊[phiHom Λ] P

noncomputable instance : Group (IPin Λ) := by unfold IPin; infer_instance

/-- Product formula, `Pin(3,1)` component: `(A,a)(B,b)` has group part `A B`. -/
theorem ipin_right (x y : IPin Λ) : (x * y).right = x.right * y.right :=
  SemidirectProduct.mul_right x y

/-- Product formula, `ℝ⁴` component: `(A,a)(B,b)` has translation part `a + Λ(A) b`. -/
theorem ipin_left (x y : IPin Λ) :
    toAdd (x * y).left = toAdd x.left + Λ x.right (toAdd y.left) := by
  rw [SemidirectProduct.mul_left]
  simp [phiHom, AddEquiv.toMultiplicative]

end BookProof.ChapterIPin
