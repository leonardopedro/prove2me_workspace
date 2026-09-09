import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterParity

/-!
# Chapter "On the physical parity transformation and antiparticles" — the Standard-Model
quark-doublet parity is order four

This file continues the finite algebraic core of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7522, §"Majorana spinors in
the Standard Model") begun in `ChapterParity`.

The chapter's generalized-parity (`ℤ₄`) transformation acts on the fields as

* Higgs doublet:  `φ(t,x⃗) ↦ i σ₂ φ(t,-x⃗)`  — internal part `i σ₂`, order four
  (`ChapterParity.higgsParity_order_four`);
* right-handed quarks:  `u_R, d_R ↦ i γ⁰ …(t,-x⃗)`  — internal part `i γ⁰ = mgamma 0`,
  order four (`ChapterParity.fermionParity_order_four`);
* left-handed quark doublet:  `Q_L(t,x⃗) ↦ -σ₂ γ⁰ Q_L(t,-x⃗)`.

The `Q_L` field carries **both** an `SU(2)_L` doublet index (on which `σ₂` acts) and a
Majorana spinor index (on which the parity `i γ⁰ = mgamma 0` acts), so the internal part of
its parity transformation is the Kronecker product `-(σ₂ ⊗ i γ⁰)` acting on
`ℂ² ⊗ ℂ⁴ ≅ ℂ⁸`.  This file proves that this operator is again **order exactly four**:

* `QLParity_sq`      : `(-σ₂ ⊗ iγ⁰)² = -1`  (using `σ₂² = 1` and `(iγ⁰)² = -1`);
* `QLParity_pow_four`: `(-σ₂ ⊗ iγ⁰)⁴ = 1`;
* `QLParity_order_four`: it is not an involution but `(…)⁴ = 1`.

Because the square is `-1` (and not `+1`), the parity of the right- and left-handed quarks
alike selects the double cover `Pin(3,1)` (rather than `Pin(1,3)`), the chapter's
conclusion.  The surrounding physical modelling (the full Standard-Model Lagrangian, the
`SU(2)_L × (SU(3)_C × U(1)_Y) ⋊ ℤ₄` background symmetry) is left as prose.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped Kronecker

namespace BookProof.ChapterParityQL

open BookProof.ChapterA3
open BookProof.ChapterParity

/-- The internal (matrix) part of the generalized-parity transformation of the
left-handed quark doublet `Q_L ↦ -σ₂ γ⁰ Q_L(t,-x⃗)`.  The `SU(2)_L` factor `σ₂` acts on
the doublet index (`ℂ²`) and the Majorana parity `i γ⁰ = mgamma 0` acts on the spinor
index (`ℂ⁴`), so the whole operator is the Kronecker product `-(σ₂ ⊗ i γ⁰)` on
`ℂ² ⊗ ℂ⁴ ≅ ℂ⁸`. -/
noncomputable def QLParity : Matrix (Fin 2 × Fin 4) (Fin 2 × Fin 4) ℂ :=
  -(pauli2 ⊗ₖ mgamma 0)

/-- Squaring the `Q_L` parity gives `-1`: the sign of the doublet factor drops out
(`σ₂² = 1`) and the whole `-1` comes from the Majorana spinor factor `(i γ⁰)² = -1`. -/
theorem QLParity_sq : QLParity * QLParity = -1 := by
  unfold QLParity
  rw [neg_mul_neg, ← Matrix.mul_kronecker_mul, pauli2_sq, mgamma0_sq,
    show (-1 : Matrix (Fin 4) (Fin 4) ℂ) = (-1 : ℂ) • 1 from by simp,
    Matrix.kronecker_smul, Matrix.one_kronecker_one]
  simp

/-- The `Q_L` parity is order (at most) four: `(-σ₂ ⊗ iγ⁰)⁴ = 1`. -/
theorem QLParity_pow_four : QLParity * QLParity * (QLParity * QLParity) = 1 := by
  rw [QLParity_sq]; simp

/-- The `Q_L` parity has order exactly four: `(-σ₂ ⊗ iγ⁰)² = -1 ≠ 1`, so it is not an
involution, while `(-σ₂ ⊗ iγ⁰)⁴ = 1`.  The value `-1` (rather than `+1`) is the invariant
selecting the double cover `Pin(3,1)` over `Pin(1,3)` for the left-handed quarks, matching
the right-handed quark result `ChapterParity.fermionParity_order_four`. -/
theorem QLParity_order_four :
    QLParity * QLParity ≠ 1 ∧
      QLParity * QLParity * (QLParity * QLParity) = 1 := by
  refine ⟨?_, QLParity_pow_four⟩
  rw [QLParity_sq]
  intro h
  have := congrArg (fun M => M (0, 0) (0, 0)) h
  norm_num [Matrix.one_apply] at this

end BookProof.ChapterParityQL
