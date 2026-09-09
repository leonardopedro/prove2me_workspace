import Mathlib

/-!
# Chapter "Quantization due to time-evolution: Yang-Mills and Classical Statistical Field Theory",
§"Pure SU(3) Yang-Mills theory" — the non-abelian field strength and the magnetic field

Source: `book.tex`, chapter *"Quantization due to time-evolution: Yang-Mills and
Classical Statistical Field Theory"*, §*"Pure SU(3) Yang-Mills theory"*
(line ~7020).

Continuing `ChapterYangMillsSU3.lean` (the structure constants) and
`ChapterYangMillsBianchi.lean` (the covariant derivative and the Bianchi/Jacobi
identity), this file formalizes the next self-contained algebraic content of the
same section: the explicit **non-abelian field strength formula** that the book
records right after the covariant derivative,

```
D_j = ∂_j - i g T_a A_{j a},        [D_j, D_k] = -i g T_a F_{j k a}
B_{i a} = ½ ε_{i j k} (∂_j A_{k a} - ∂_k A_{j a} - g f_{a b c} A_{j b} A_{k c}).
```

The key algebraic identity is that the commutator of two covariant derivatives
is a *zeroth-order* (multiplication) operator, whose multiplier is the field
strength.  We model this abstractly: the covariant derivative acts on an
associative ring `R` (the "field values", e.g. matrices acting on the left) as

```
D_j x = δ_j x + a_j * x,
```

where `δ : Fin 3 → R → R` is a family of **commuting Leibniz derivations**
(the partial derivatives `∂_j`) and `a_j ∈ R` is the connection
(`a_j = -i g A_j` in the book).  Then

```
[D_j, D_k] x = F_{j k} * x,    F_{j k} = δ_j a_k - δ_k a_j + (a_j a_k - a_k a_j),
```

i.e. the double derivative terms cancel by commutativity of the `δ`'s and the
mixed first-order terms cancel identically, leaving a pure multiplication
operator (`nonabelian_fieldStrength`).  Specializing to the book's connection
`a_j = -i g A_j` in a complex algebra recovers exactly the book's magnetic
field-strength combination

```
[D_j, D_k] x = (-i g • F^{book}_{j k}) * x,
F^{book}_{j k} = (∂_j A_k - ∂_k A_j) - i g (A_j A_k - A_k A_j)
```

(`commutator_eq_coupling`), where the non-abelian correction `-i g [A_j, A_k]`
expands, via `[T_a, T_b] = i f_{a b c} T_c` (see `ChapterYangMillsSU3.lean`),
into the book's `+ g f_{a b c} A_{j b} A_{k c}` term.

* `Dcov` — the covariant derivative `D_j x = δ_j x + a_j * x`;
* `fieldStrengthMul` — the abstract field strength `F_{j k} = δ_j a_k - δ_k a_j + [a_j, a_k]`;
* `nonabelian_fieldStrength` — `[D_j, D_k] x = F_{j k} * x` (the commutator of
  covariant derivatives is multiplication by the field strength);
* `fieldStrengthMul_antisymm` — `F_{j k} = - F_{k j}`;
* `Fbook` — the book's field-strength combination `(∂_j A_k - ∂_k A_j) - i g [A_j, A_k]`;
* `commutator_eq_coupling` — `[D_j, D_k] x = (-i g • F^{book}_{j k}) * x` for the
  book's connection `a_j = -i g A_j`;
* `Fbook_antisymm` — `F^{book}_{j k} = - F^{book}_{k j}`.
-/

open Complex

namespace BookProof.YangMillsFieldStrength

section Abstract

variable {R : Type*} [Ring R]

/-- The covariant derivative acting on the ring of field values,
`D_j x = δ_j x + a_j * x`, where `δ_j` is the partial derivative `∂_j` and `a_j`
is the connection (`a_j = -i g A_j` in the book, with `A_j` acting by left
multiplication). -/
def Dcov (δ : Fin 3 → R → R) (a : Fin 3 → R) (j : Fin 3) (x : R) : R := δ j x + a j * x

/-- The (abstract) non-abelian field strength, the multiplier appearing in the
commutator of two covariant derivatives:
`F_{j k} = δ_j a_k - δ_k a_j + (a_j a_k - a_k a_j)`. -/
def fieldStrengthMul (δ : Fin 3 → R → R) (a : Fin 3 → R) (j k : Fin 3) : R :=
  (δ j (a k) - δ k (a j)) + (a j * a k - a k * a j)

/-- **The commutator of two covariant derivatives is multiplication by the field
strength.**  For commuting Leibniz derivations `δ` (the partial derivatives
`∂_j`), the second-order terms cancel by commutativity of the `δ`'s and the
mixed first-order terms cancel identically, so

```
[D_j, D_k] x = D_j (D_k x) - D_k (D_j x) = F_{j k} * x
```

is a pure multiplication (zeroth-order) operator.  This is the algebraic content
of the book's `[D_j, D_k] = -i g T_a F_{j k a}`. -/
theorem nonabelian_fieldStrength
    (δ : Fin 3 → R → R) (a : Fin 3 → R)
    (hadd : ∀ j x y, δ j (x + y) = δ j x + δ j y)
    (hleib : ∀ j x y, δ j (x * y) = δ j x * y + x * δ j y)
    (hcomm : ∀ j k x, δ j (δ k x) = δ k (δ j x))
    (j k : Fin 3) (x : R) :
    Dcov δ a j (Dcov δ a k x) - Dcov δ a k (Dcov δ a j x) = fieldStrengthMul δ a j k * x := by
  simp only [Dcov, fieldStrengthMul]
  rw [hadd, hadd, hleib, hleib, hcomm k j]
  noncomm_ring

/-- The field strength is antisymmetric: `F_{j k} = - F_{k j}`. -/
theorem fieldStrengthMul_antisymm (δ : Fin 3 → R → R) (a : Fin 3 → R) (j k : Fin 3) :
    fieldStrengthMul δ a j k = - fieldStrengthMul δ a k j := by
  simp only [fieldStrengthMul]; noncomm_ring

end Abstract

section Coupling

variable {R : Type*} [Ring R] [Algebra ℂ R]

/-- The book's field-strength combination
`F^{book}_{j k} = (∂_j A_k - ∂_k A_j) - i g (A_j A_k - A_k A_j)`, with `A_j` the
matrix-valued gauge potential `A_j = T_a A_{j a}` and `g` the coupling constant.
Its non-abelian term `-i g [A_j, A_k]` expands, via `[T_a, T_b] = i f_{a b c} T_c`
(see `ChapterYangMillsSU3.lean`), into the book's `+ g f_{a b c} A_{j b} A_{k c}`. -/
def Fbook (δ : Fin 3 → R → R) (g : ℝ) (A : Fin 3 → R) (j k : Fin 3) : R :=
  (δ j (A k) - δ k (A j)) - (I * (g : ℂ)) • (A j * A k - A k * A j)

/-- **Bridge between the two normalizations.**  Substituting the book's
connection `a_j = -i g A_j` into the abstract field strength `fieldStrengthMul`
yields exactly `-i g` times the book's field-strength combination `Fbook`.  So
the abstract and the physical normalizations agree up to the coupling. -/
theorem fieldStrengthMul_eq_Fbook
    (δ : Fin 3 → R → R) (g : ℝ) (A : Fin 3 → R)
    (hsmul : ∀ (j : Fin 3) (c : ℂ) x, δ j (c • x) = c • δ j x) (j k : Fin 3) :
    fieldStrengthMul δ (fun j => (-(I * (g : ℂ))) • A j) j k
      = (-(I * (g : ℂ))) • Fbook δ g A j k := by
  simp only [fieldStrengthMul, Fbook]
  rw [hsmul, hsmul, smul_mul_smul_comm, smul_mul_smul_comm]
  module

/-- **The book's non-abelian field strength.**  Specializing the connection to
`a_j = -i g A_j` (the book's `D_j = ∂_j - i g T_a A_{j a}`), the commutator of
covariant derivatives is multiplication by `-i g F^{book}_{j k}`:

```
[D_j, D_k] x = (-i g • F^{book}_{j k}) * x,
F^{book}_{j k} = (∂_j A_k - ∂_k A_j) - i g (A_j A_k - A_k A_j),
```

exactly the book's `[D_j, D_k] = -i g T_a F_{j k a}`. -/
theorem commutator_eq_coupling
    (δ : Fin 3 → R → R) (g : ℝ) (A : Fin 3 → R)
    (hadd : ∀ j x y, δ j (x + y) = δ j x + δ j y)
    (hleib : ∀ j x y, δ j (x * y) = δ j x * y + x * δ j y)
    (hsmul : ∀ (j : Fin 3) (c : ℂ) x, δ j (c • x) = c • δ j x)
    (hcomm : ∀ j k x, δ j (δ k x) = δ k (δ j x))
    (j k : Fin 3) (x : R) :
    Dcov δ (fun j => (-(I * (g : ℂ))) • A j) j (Dcov δ (fun j => (-(I * (g : ℂ))) • A j) k x)
      - Dcov δ (fun j => (-(I * (g : ℂ))) • A j) k (Dcov δ (fun j => (-(I * (g : ℂ))) • A j) j x)
      = ((-(I * (g : ℂ))) • Fbook δ g A j k) * x := by
  rw [nonabelian_fieldStrength δ _ hadd hleib hcomm,
    fieldStrengthMul_eq_Fbook δ g A hsmul j k]

/-- The book's field strength is antisymmetric: `F^{book}_{j k} = - F^{book}_{k j}`. -/
theorem Fbook_antisymm (δ : Fin 3 → R → R) (g : ℝ) (A : Fin 3 → R) (j k : Fin 3) :
    Fbook δ g A j k = - Fbook δ g A k j := by
  simp only [Fbook, smul_sub]; abel

end Coupling

end BookProof.YangMillsFieldStrength
