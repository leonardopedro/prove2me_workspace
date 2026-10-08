import Definitions.Def_ChapterGhostField
import Mathlib

/-
Copyright (c) 2026. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Aristotle
-/

/-!
# The two presentations of the ghost algebra: fermionic (`ψ, ψ†`) and self-adjoint (Majorana)

Source: `book.tex`, §*"Relation with the BRST formalism"* of the Yang–Mills
chapter (lines 6940–6960):

> "there are two representations of the ghost algebra: one degenerate where
> the ghost fields are self-adjoint and another non-degenerate where the ghost
> fields are not self-adjoint and behave like standard fermionic [fields] …
> the ghosts are as consistent as a Schrödinger field."

This file formalizes the relation between the two presentations on the `ℤ₂`
ghost fibre of `BookProof.ChapterGhostField`:

* the **fermionic** presentation `ψ, ψ†` with `{ψ, ψ†} = 1`, `ψ² = (ψ†)² = 0`,
  where `ψ` is *not* self-adjoint;
* the **self-adjoint (Majorana)** presentation `χ₁ = ψ + ψ†`,
  `χ₂ = i (ψ − ψ†)`, whose generators *are* self-adjoint and satisfy the
  Clifford relations `χ_a χ_b + χ_b χ_a = 2 δ_{ab}`.

The change of basis is invertible, so the two presentations generate the same
operator algebra: nothing physical distinguishes them, which is the book's
point that the ghost sector is as consistent as an ordinary fermionic field.

## Main results

* `psi_not_selfAdjoint` — the fermionic generator is not self-adjoint.
* `chi1_selfAdjoint`, `chi2_selfAdjoint` — the Majorana generators are.
* `chi1_sq`, `chi2_sq`, `chi_anticomm` — the Clifford relations.
* `psi_of_chi`, `psiDag_of_chi` — the inverse change of basis, so the two
  presentations generate the same algebra.
-/

namespace BookProof.ChapterGhostMajoranaRep

open Matrix BookProof.GhostField



/-- The first Majorana (self-adjoint) ghost generator `χ₁ = ψ + ψ†`. -/
def chi1 : Matrix (Fin 2) (Fin 2) ℂ := psi + psiDag

/-- The second Majorana (self-adjoint) ghost generator `χ₂ = i (ψ − ψ†)`. -/
noncomputable def chi2 : Matrix (Fin 2) (Fin 2) ℂ := Complex.I • (psi - psiDag)











file LICENSE.
Authors: Aristotle
-/

/-!
# The two presentations of the ghost algebra: fermionic (`ψ, ψ†`) and self-adjoint (Majorana)

Source: `book.tex`, §*"Relation with the BRST formalism"* of the Yang–Mills
chapter (lines 6940–6960):

> "there are two representations of the ghost algebra: one degenerate where
> the ghost fields are self-adjoint and another non-degenerate where the ghost
> fields are not self-adjoint and behave like standard fermionic [fields] …
> the ghosts are as consistent as a Schrödinger field."

This file formalizes the relation between the two presentations on the `ℤ₂`
ghost fibre of `BookProof.ChapterGhostField`:

* the **fermionic** presentation `ψ, ψ†` with `{ψ, ψ†} = 1`, `ψ² = (ψ†)² = 0`,
  where `ψ` is *not* self-adjoint;
* the **self-adjoint (Majorana)** presentation `χ₁ = ψ + ψ†`,
  `χ₂ = i (ψ − ψ†)`, whose generators *are* self-adjoint and satisfy the
  Clifford relations `χ_a χ_b + χ_b χ_a = 2 δ_{ab}`.

The change of basis is invertible, so the two presentations generate the same
operator algebra: nothing physical distinguishes them, which is the book's
point that the ghost sector is as consistent as an ordinary fermionic field.

## Main results

* `psi_not_selfAdjoint` — the fermionic generator is not self-adjoint.
* `chi1_selfAdjoint`, `chi2_selfAdjoint` — the Majorana generators are.
* `chi1_sq`, `chi2_sq`, `chi_anticomm` — the Clifford relations.
* `psi_of_chi`, `psiDag_of_chi` — the inverse change of basis, so the two
  presentations generate the same algebra.
-/

namespace BookProof.ChapterGhostMajoranaRep

open Matrix BookProof.GhostField

/-- **The fermionic presentation is not self-adjoint**: `ψ ≠ ψ†`. -/
theorem psi_not_selfAdjoint : psi ≠ psiᴴ := by
  intro h
  have h10 := congrFun (congrFun h 1) 0
  simp [psi, Matrix.conjTranspose_apply] at h10

/-- The first Majorana (self-adjoint) ghost generator `χ₁ = ψ + ψ†`. -/
def chi1 : Matrix (Fin 2) (Fin 2) ℂ := psi + psiDag

/-- The second Majorana (self-adjoint) ghost generator `χ₂ = i (ψ − ψ†)`. -/
noncomputable def chi2 : Matrix (Fin 2) (Fin 2) ℂ := Complex.I • (psi - psiDag)

/-- The first Majorana generator is self-adjoint. -/
theorem chi1_selfAdjoint : chi1ᴴ = chi1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi1, psi, psiDag, Matrix.conjTranspose_apply]

/-- The second Majorana generator is self-adjoint. -/
theorem chi2_selfAdjoint : chi2ᴴ = chi2 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi2, psi, psiDag, Matrix.conjTranspose_apply]

/-- The Clifford relation `χ₁² = 1`. -/
theorem chi1_sq : chi1 * chi1 = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi1, psi, psiDag, Matrix.mul_apply, Fin.sum_univ_two]

/-- The Clifford relation `χ₂² = 1`. -/
theorem chi2_sq : chi2 * chi2 = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi2, psi, psiDag, Matrix.mul_apply, Fin.sum_univ_two, Complex.I_mul_I]

/-- The Clifford anticommutation relation `χ₁ χ₂ + χ₂ χ₁ = 0`. -/
theorem chi_anticomm : chi1 * chi2 + chi2 * chi1 = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi1, chi2, psi, psiDag]

/-- The inverse change of basis: `ψ = (χ₁ − i χ₂)/2`. -/
theorem psi_of_chi : psi = (2 : ℂ)⁻¹ • (chi1 - Complex.I • chi2) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi1, chi2, psi, psiDag, Complex.I_mul_I] ; norm_num

/-- The inverse change of basis: `ψ† = (χ₁ + i χ₂)/2`. -/
theorem psiDag_of_chi : psiDag = (2 : ℂ)⁻¹ • (chi1 + Complex.I • chi2) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi1, chi2, psi, psiDag, Complex.I_mul_I] ; norm_num

end BookProof.ChapterGhostMajoranaRep
