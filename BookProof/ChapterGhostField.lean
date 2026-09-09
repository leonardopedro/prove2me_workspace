import Mathlib

/-!
# Chapter "Free field parametrization … Navier-Stokes", §"Free field parametrization in
Navier-Stokes equations" — the fermionic ghost field and BRST charge

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier-Stokes equations"*, §*"Free field parametrization in
Navier-Stokes equations"* (line ~4134).

The book builds the Navier–Stokes Hilbert space as a tensor product of symmetric
and antisymmetric Fock spaces, giving a graded Lie superalgebra of bosonic and
fermionic creation/annihilation operators.  The **divergence constraint** is
imposed via a single fermionic *ghost* field `ψ` (with its space derivatives
`ψ_j`), and the **BRST charge** is

```
Ω = ∫ d³x …  a†(x,…) [ u_{j,j} ψ† ] a(x,…).
```

The book specifies the ghost's canonical *anti*commutation relations and its
concrete action on the two–dimensional `ℤ₂` Fock factor:

```
{ψ, ψ†} = ψ ψ† + ψ† ψ = 1
ψ†{a}(j) = a(1) δ_{j0}          ψ{a}(j) = a(0) δ_{j1}
```

This file formalizes the self-contained mathematical content of that
construction:

* the single fermionic mode as the concrete `2×2` matrix model on the `ℤ₂` Fock
  factor `ℂ²`, its **canonical anticommutation relations** (CAR)
  `{ψ,ψ†} = 1`, `ψ² = 0`, `ψ†² = 0`, and `ψ† = ψᴴ`;
* the ghost **number operator** `N = ψ†ψ` is an orthogonal projection
  (`N² = N`, `N = Nᴴ`) — the fermionic occupation is `0` or `1` (Pauli
  exclusion), and `N + ψψ† = 1`;
* the abstract **nilpotency of the BRST charge** `Ω² = 0`, which is the reason
  the BRST cohomology is defined: for any operator `b` that commutes with a
  square-zero ghost factor `f` (`f² = 0`), the composite `Ω = b·f` satisfies
  `Ω² = 0`.
-/

namespace BookProof.GhostField

open Matrix

/-! ### The single fermionic mode on the `ℤ₂` Fock factor `ℂ²`

We index the two–dimensional `ℤ₂` Fock factor by `Fin 2`: index `0` is the
empty (vacuum) ghost state, index `1` the occupied ghost state.  A vector
`a : Fin 2 → ℂ` has components `a 0`, `a 1`. -/

/-- The ghost annihilation operator `ψ`: `ψ{a}(j) = a(0) δ_{j1}`, i.e. it maps
`(a₀, a₁) ↦ (0, a₀)`. -/
def psi : Matrix (Fin 2) (Fin 2) ℂ := !![0, 0; 1, 0]

/-- The ghost creation operator `ψ†`: `ψ†{a}(j) = a(1) δ_{j0}`, i.e. it maps
`(a₀, a₁) ↦ (a₁, 0)`. -/
def psiDag : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 0, 0]

/-- `ψ†` is the (conjugate) transpose of `ψ`: it really is the adjoint. -/
theorem psiDag_eq_conjTranspose : psiDag = psiᴴ := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [psi, psiDag, Matrix.conjTranspose_apply]

/-- The ghost annihilation operator is nilpotent: `ψ² = 0` (a ghost cannot be
annihilated twice). -/
theorem psi_sq : psi * psi = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [psi, Matrix.mul_apply, Fin.sum_univ_two]

/-- The ghost creation operator is nilpotent: `ψ†² = 0` (Pauli exclusion — a
fermionic mode cannot be occupied twice). -/
theorem psiDag_sq : psiDag * psiDag = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [psiDag, Matrix.mul_apply, Fin.sum_univ_two]

/-- The **canonical anticommutation relation** `{ψ, ψ†} = ψ ψ† + ψ† ψ = 1`. -/
theorem car : psi * psiDag + psiDag * psi = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [psi, psiDag]

/-! ### The ghost number operator -/

/-- The ghost number operator `N = ψ† ψ` (`= |1⟩⟨1|`, the occupied-state
projector). -/
noncomputable def numberOp : Matrix (Fin 2) (Fin 2) ℂ := psiDag * psi

/-- The number operator explicitly. With the book's convention (`ψ†` sends the
component at index `1` to index `0`), `N = ψ†ψ = |0⟩⟨0|` is the projector onto
the index-`0` occupation state. -/
theorem numberOp_eq : numberOp = !![1, 0; 0, 0] := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [numberOp, psi, psiDag, Matrix.mul_apply, Fin.sum_univ_two]

/-- The number operator is idempotent: `N² = N`. Together with self-adjointness
this says `N` is an **orthogonal projection**, so the ghost occupation number is
`0` or `1`. -/
theorem numberOp_idempotent : numberOp * numberOp = numberOp := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [numberOp, psi, psiDag, Matrix.mul_apply, Fin.sum_univ_two]

/-- The number operator is self-adjoint: `N = Nᴴ`. -/
theorem numberOp_selfAdjoint : numberOp = numberOpᴴ := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [numberOp, psi, psiDag, Matrix.conjTranspose_apply, Matrix.mul_apply, Fin.sum_univ_two]

/-- Completeness of the two occupation projectors: `ψ†ψ + ψψ† = 1`
(occupied plus empty exhaust the ghost factor). -/
theorem numberOp_add_hole : numberOp + psi * psiDag = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [numberOp, psi, psiDag]

/-! ### Nilpotency of the BRST charge

The book's BRST charge is `Ω = ∫ … [u_{j,j} ψ†]`.  The single essential
algebraic property that makes the BRST construction work is `Ω² = 0`.  Abstractly
this holds in *any* (possibly noncommutative) ring: if the ghost factor `f` is
square-zero and the bosonic factor `b` commutes with it, then `Ω = b·f`
satisfies `Ω² = 0`.  Here `f = ψ†` (square-zero by `psiDag_sq`) and `b`
represents the number-conserving field factor `u_{j,j}`. -/

/-- **Nilpotency of the BRST charge.** In any ring, if `f² = 0` and `b`
commutes with `f`, then `(b·f)² = 0`.  With `f = ψ†` and `b` the (commuting)
divergence field factor `u_{j,j}`, this is `Ω² = 0`. -/
theorem brst_charge_nilpotent {R : Type*} [Ring R] (b f : R)
    (hf : f * f = 0) (hbf : Commute b f) : (b * f) * (b * f) = 0 := by
  have h : b * f * (b * f) = b * b * (f * f) := by
    rw [mul_assoc, ← mul_assoc f b f, ← hbf.eq, mul_assoc, mul_assoc]
  rw [h, hf, mul_zero]

/-- The concrete ghost-factor instance of BRST nilpotency: for any field factor
`b` (a `2×2` operator) commuting with `ψ†`, the charge `b·ψ†` squares to zero. -/
theorem brst_charge_nilpotent_ghost (b : Matrix (Fin 2) (Fin 2) ℂ)
    (hb : Commute b psiDag) : (b * psiDag) * (b * psiDag) = 0 :=
  brst_charge_nilpotent b psiDag psiDag_sq hb

end BookProof.GhostField
