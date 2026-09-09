import Mathlib

/-!
# Chapter "Quantization due to time-evolution: Yang-Mills and Classical Statistical Field Theory",
§"Pure SU(3) Yang-Mills theory" — the covariant derivative and the Bianchi (Jacobi) identity

Source: `book.tex`, chapter *"Quantization due to time-evolution: Yang-Mills and
Classical Statistical Field Theory"*, §*"Pure SU(3) Yang-Mills theory"*
(line ~7010).

Continuing `ChapterYangMillsSU3.lean` (the structure constants), this file
formalizes the next self-contained algebraic content of the same section: the
covariant derivative

```
D_j = ∂_j - i g T_a A_{j a},        [D_j, D_k] = -i g T_a F_{j k a}
```

and the **Jacobi (Bianchi) relation** the book states for it,

```
ε_{i j k} [D_i, [D_j, D_k]] = 0.
```

All of this is purely algebraic: the covariant derivatives `D_i` are elements of
an (arbitrary, associative, possibly non-commutative) ring `R`, and their
commutator `⁅·,·⁆ = a*b - b*a` is the ambient Lie bracket.  The field strength
`F_{j k} = ⁅D_j, D_k⁆` is antisymmetric, and the Levi-Civita contraction of the
double commutator vanishes — an immediate consequence of the Jacobi identity
`lie_jacobi`.  This is exactly the identity underlying the vanishing of the
covariant divergence of the magnetic field (`∇·B = 0` / the homogeneous
Yang-Mills equation) that the book records right after introducing `B_{i a}`.

* `eps` — the Levi-Civita symbol on `Fin 3`;
* `fieldStrength` — `F_{j k} = ⁅D_j, D_k⁆`, the commutator of covariant
  derivatives;
* `fieldStrength_antisymm` — `F_{j k} = - F_{k j}`;
* `bianchi_cyclic` — the cyclic Jacobi identity for the double commutators;
* `bianchi` — the book's `ε_{i j k} [D_i, [D_j, D_k]] = 0`;
* `bianchi_fieldStrength` — the same written with the field strength,
  `ε_{i j k} [D_i, F_{j k}] = 0`.
-/

open BigOperators

namespace BookProof.YangMillsBianchi

/-- The Levi-Civita symbol on `Fin 3`: `+1` for even permutations of `(0,1,2)`,
`-1` for odd permutations, and `0` whenever two indices coincide.  It is written
as the sign of the product of the pairwise differences. -/
def eps (i j k : Fin 3) : ℤ :=
  Int.sign (((j : ℤ) - (i : ℤ)) * ((k : ℤ) - (i : ℤ)) * ((k : ℤ) - (j : ℤ)))

variable {R : Type*} [Ring R]

/-- The (Yang-Mills) field strength as the commutator of covariant derivatives,
`F_{j k} = ⁅D_j, D_k⁆` (equal to `-i g T_a F_{j k a}` in the book's notation). -/
def fieldStrength (D : Fin 3 → R) (j k : Fin 3) : R := ⁅D j, D k⁆

/-- The field strength is antisymmetric: `F_{j k} = - F_{k j}`. -/
lemma fieldStrength_antisymm (D : Fin 3 → R) (j k : Fin 3) :
    fieldStrength D j k = - fieldStrength D k j := by
  simp only [fieldStrength]
  exact (lie_skew (D j) (D k)).symm

/-- The cyclic Jacobi identity for the double commutators of the covariant
derivatives (the source of the Bianchi identity). -/
lemma bianchi_cyclic (D : Fin 3 → R) (i j k : Fin 3) :
    ⁅D i, ⁅D j, D k⁆⁆ + ⁅D j, ⁅D k, D i⁆⁆ + ⁅D k, ⁅D i, D j⁆⁆ = 0 :=
  lie_jacobi (D i) (D j) (D k)

/-
**Bianchi (Jacobi) identity**, `ε_{i j k} [D_i, [D_j, D_k]] = 0`.
-/
theorem bianchi (D : Fin 3 → R) :
    ∑ i, ∑ j, ∑ k, (eps i j k) • ⁅D i, ⁅D j, D k⁆⁆ = 0 := by
  simp [ Fin.sum_univ_three, eps ];
  simp [ Int.sign ];
  grind +suggestions

/-- The Bianchi identity written with the field strength,
`ε_{i j k} [D_i, F_{j k}] = 0`. -/
theorem bianchi_fieldStrength (D : Fin 3 → R) :
    ∑ i, ∑ j, ∑ k, (eps i j k) • ⁅D i, fieldStrength D j k⁆ = 0 := by
  simpa only [fieldStrength] using bianchi D

end BookProof.YangMillsBianchi
