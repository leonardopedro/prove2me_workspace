import Mathlib
import BookProof.ChapterParity

/-!
# Chapter "On the physical parity transformation and antiparticles" — `SU(2)_L` has
trivial outer automorphism (complex conjugation is inner)

This file continues the finite algebraic core of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7522, §"Majorana spinors in
the Standard Model").  The chapter states:

  *"The outer automorphism group of `SU(3)` or `U(1)_Y` is `Z₂`, while the outer
  automorphism group of `SU(2)_L` is the trivial group."*

The relevant automorphism is **complex conjugation** `g ↦ g*` (which sends a
representation to its complex-conjugate representation).  For `SU(3)` this is a
*nontrivial* outer automorphism: entrywise conjugation of the Gell-Mann generators
negates `λ², λ⁵, λ⁷` (`ChapterParity.gellMann_conj`), and no fixed similarity undoes it.

For `SU(2)`, however, the fundamental representation is **pseudoreal**: complex conjugation
is realized by conjugation with the fixed matrix `σ₂`.  On the Lie-algebra generators
`i σ_j` this is the identity

  `conj(i σ_j) = σ₂ (i σ_j) σ₂⁻¹`   (with `σ₂⁻¹ = σ₂`),

so the complex-conjugate representation is *unitarily equivalent* to the original — i.e.
complex conjugation is an **inner** automorphism, and the outer automorphism group of
`SU(2)_L` is trivial.

## Contents

* `pauliV` — the three Pauli matrices `σ₁, σ₂, σ₃` (with `σ₂ = ChapterParity.pauli2`).
* `pauliV_pseudoreal` : `σ₂ σ_j σ₂ = -(σ_j)*` — the pseudoreality intertwiner.
* `su2gen` — the `su(2)` generators `i σ_j`.
* `su2_conj_inner` : `conj(i σ_j) = σ₂ (i σ_j) σ₂` — complex conjugation of the `su(2)`
  generators is inner (conjugation by the fixed `σ₂`, an involution `σ₂² = 1`), so
  `SU(2)_L` has trivial outer automorphism.

The surrounding physical modelling (the Standard-Model gauge structure) is left as prose.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterParitySU2

open BookProof.ChapterParity

/-- The Pauli matrix `σ₁`. -/
noncomputable def pauli1 : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]

/-- The Pauli matrix `σ₃`. -/
noncomputable def pauli3 : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

/-- The three Pauli matrices `σ₁, σ₂, σ₃`, indexed `0, 1, 2` (with `σ₂ =
`ChapterParity.pauli2`). -/
noncomputable def pauliV : Fin 3 → Matrix (Fin 2) (Fin 2) ℂ
  | 0 => pauli1
  | 1 => pauli2
  | 2 => pauli3

/-- **Pseudoreality intertwiner for `SU(2)`.**  Conjugating a Pauli matrix by `σ₂` gives
minus its complex conjugate: `σ₂ σ_j σ₂ = -(σ_j)*`.  (For the real generators `σ₁, σ₃`
this reads `σ₂ σ_j σ₂ = -σ_j`; for `σ₂` itself it reads `σ₂ σ₂ σ₂ = σ₂ = -(σ₂)*`, since
`(σ₂)* = -σ₂`.) -/
theorem pauliV_pseudoreal (j : Fin 3) :
    pauli2 * pauliV j * pauli2 = -((pauliV j).map (starRingEnd ℂ)) := by
  fin_cases j <;>
  · ext a b; fin_cases a <;> fin_cases b <;>
      simp [pauliV, pauli1, pauli3, pauli2, Matrix.mul_apply, Fin.sum_univ_two,
        Matrix.map_apply, Complex.conj_I]

/-- The `su(2)` generators `i σ_j` (`j = 1,2,3`). -/
noncomputable def su2gen (j : Fin 3) : Matrix (Fin 2) (Fin 2) ℂ := Complex.I • pauliV j

/-- **`SU(2)_L` has trivial outer automorphism.**  Complex conjugation of the `su(2)`
generators is realized by inner conjugation with the fixed involution `σ₂` (`σ₂² = 1`):

  `conj(i σ_j) = σ₂ (i σ_j) σ₂`.

Hence the complex-conjugate representation is unitarily equivalent to the original, and the
conjugation automorphism is *inner* — in contrast with `SU(3)`, whose conjugation is the
nontrivial `Z₂` outer automorphism (`ChapterParity.gellMann_conj`). -/
theorem su2_conj_inner (j : Fin 3) :
    (su2gen j).map (starRingEnd ℂ) = pauli2 * su2gen j * pauli2 := by
  fin_cases j <;>
  · ext a b; fin_cases a <;> fin_cases b <;>
      simp [su2gen, pauliV, pauli1, pauli3, pauli2, Matrix.mul_apply, Fin.sum_univ_two,
        Matrix.map_apply, Complex.conj_I, Complex.I_mul_I]

end BookProof.ChapterParitySU2
