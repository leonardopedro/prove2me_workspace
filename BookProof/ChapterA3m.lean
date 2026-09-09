import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3k
import BookProof.ChapterA3l

/-!
# Chapter A, §A.3 — Note 51 / Lemma 52: the threefold braiding (`S₃`) structure

Source: `book.tex` §A.3, Notes 50–51 and Lemma 52 (line ~5560).

`ChapterA3l` introduced the **braiding (swap) operator** `τ` on the *two-fold*
tensor product `V ⊗ V` and the symmetric / antisymmetric decomposition it
induces (`projSym = ½(1+τ)`), showing that the symmetric tensor *square* is a
full-Lorentz subrepresentation — the Lemma-52 mechanism at the first symmetric
tensor power.

This file takes the **next step** toward the *arbitrary* `N`-fold symmetric
powers of Note 51: the **three-fold tensor product** `V ⊗ V ⊗ V`, carrier of the
symmetric cube `V ⊙ V ⊙ V` (which contains the top irrep `V⁺_{3/2}`), together
with the action of the symmetric group `S₃` by braidings.  On the
`4×4 ⊗ 4×4 ⊗ 4×4` Kronecker model (index type `((Fin 4 × Fin 4) × Fin 4)`,
left-associated) we build the two adjacent transposition operators
`τ₁₂, τ₂₃` and the long transposition `τ₁₃`, and prove:

* **Braiding relations** `swap12_kronecker`, `swap23_kronecker`,
  `swap13_kronecker`: each transposition conjugates a Kronecker product into the
  correspondingly permuted product.
* **`S₃` presentation**: involutivity `swap12_sq`, `swap23_sq`, `swap13_sq`
  (`τ² = 1`) and the **braid relation**
  `swap12*swap23*swap12 = swap13 = swap23*swap12*swap23` (`braid_left`,
  `braid_right`, `braid_rel`) — the Coxeter presentation of `S₃`.
* **Full-Lorentz invariance of the diagonal action**: the three transpositions
  each commute with the diagonal `Spin⁺` generator
  `A⊗1⊗1 + 1⊗A⊗1 + 1⊗1⊗A` (`swap12_spinGenDiag_comm`, …) and with the diagonal
  parity `γ⁰⊗γ⁰⊗γ⁰` (`swap12_parityDiag_comm`, …), because the totally
  symmetric diagonal action is invariant under any permutation of the slots.
* **Lemma 52 payoff for the symmetric cube**: the total symmetrizer
  `projSym3 = (1/6)·Σ_{g∈S₃} ρ(g)` is a **full-Lorentz** subrepresentation —
  `projSym3_spinGenDiag_comm` (diagonal `Spin⁺`-invariant) and
  `projSym3_parityDiag_comm` (parity-invariant) — so the *real* symmetric-cube
  construction is automatically a representation of the full Lorentz group,
  exactly as at the symmetric-square level in `ChapterA3l`.

Everything is a Kronecker-algebra consequence of `ChapterA3l`/`ChapterA3k` and is
`sorry`-free / `axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`),
with **no `EXTERNAL` hypothesis** (Note 50 / Weyl complete reducibility and the
extension to *all* `N`-fold symmetric powers remain the cited backbone).
-/

open Matrix
open scoped Kronecker

namespace BookProof.ChapterA3m

open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

/-- The `64`-dimensional carrier space `V ⊗ V ⊗ V` of three Dirac spinors,
modeled as `(4×4 ⊗ 4×4) ⊗ 4×4` matrices (left-associated Kronecker product,
index type `((Fin 4 × Fin 4) × Fin 4)`). -/
abbrev M3 := Matrix ((Fin 4 × Fin 4) × Fin 4) ((Fin 4 × Fin 4) × Fin 4) ℂ

/-! ## The three transposition (braiding) operators -/

/-- The transposition `τ₁₂` swapping the **first two** tensor slots,
`u ⊗ v ⊗ w ↦ v ⊗ u ⊗ w`.  Built as `τ ⊗ 1` from the two-fold braiding
`ChapterA3l.swap`. -/
noncomputable def swap12 : M3 := BookProof.ChapterA3l.swap ⊗ₖ 1

/-- The transposition `τ₂₃` swapping the **last two** tensor slots,
`u ⊗ v ⊗ w ↦ u ⊗ w ⊗ v`.  Entrywise the permutation matrix
`[b = (a₁, a₃, a₂)]`. -/
noncomputable def swap23 : M3 :=
  Matrix.of fun a b => if b.1.1 = a.1.1 ∧ b.1.2 = a.2 ∧ b.2 = a.1.2 then (1 : ℂ) else 0

/-- The long transposition `τ₁₃` swapping the **outer** slots,
`u ⊗ v ⊗ w ↦ w ⊗ v ⊗ u`.  Entrywise `[b = (a₃, a₂, a₁)]`. -/
noncomputable def swap13 : M3 :=
  Matrix.of fun a b => if b.1.1 = a.2 ∧ b.1.2 = a.1.2 ∧ b.2 = a.1.1 then (1 : ℂ) else 0

/-! ## Braiding relations -/

/-
Braiding relation for `τ₁₂`: `τ₁₂ · ((A⊗B)⊗C) = ((B⊗A)⊗C) · τ₁₂`.
-/
theorem swap12_kronecker (A B C : Matrix (Fin 4) (Fin 4) ℂ) :
    swap12 * ((A ⊗ₖ B) ⊗ₖ C) = ((B ⊗ₖ A) ⊗ₖ C) * swap12 := by
  -- By definition of swap12, we have swap12 = swap ⊗ₖ 1.
  have h_swap12 : swap12 = BookProof.ChapterA3l.swap ⊗ₖ 1 := by
    exact?;
  rw [ h_swap12, ← Matrix.mul_kronecker_mul ];
  rw [ ← Matrix.mul_kronecker_mul ];
  rw [ BookProof.ChapterA3l.swap_kronecker ] ; norm_num

/-
Braiding relation for `τ₂₃`: `τ₂₃ · ((A⊗B)⊗C) = ((A⊗C)⊗B) · τ₂₃`.
-/
theorem swap23_kronecker (A B C : Matrix (Fin 4) (Fin 4) ℂ) :
    swap23 * ((A ⊗ₖ B) ⊗ₖ C) = ((A ⊗ₖ C) ⊗ₖ B) * swap23 := by
  ext a col;
  simp only [swap23, mul_apply, of_apply, kroneckerMap_apply, ite_mul, one_mul, zero_mul, mul_ite,
      mul_one, mul_zero];
  rw [ Finset.sum_eq_single ( ( a.1.1, a.2 ), a.1.2 ), Finset.sum_eq_single ( ( col.1.1, col.2 ),
      col.1.2 ) ] <;> simp +contextual [ eq_comm ];
  · ring;
  · aesop

/-
Braiding relation for `τ₁₃`: `τ₁₃ · ((A⊗B)⊗C) = ((C⊗B)⊗A) · τ₁₃`.
-/
theorem swap13_kronecker (A B C : Matrix (Fin 4) (Fin 4) ℂ) :
    swap13 * ((A ⊗ₖ B) ⊗ₖ C) = ((C ⊗ₖ B) ⊗ₖ A) * swap13 := by
  unfold swap13;
  ext ⟨ ⟨ i, j ⟩, k ⟩ ⟨ ⟨ l, m ⟩, n ⟩ ; simp only [mul_apply, of_apply, kroneckerMap_apply, ite_mul,
      one_mul, zero_mul, Finset.sum_ite, not_and, Finset.sum_const_zero, add_zero, mul_ite, mul_one,
          mul_zero] ; ring;
  refine Finset.sum_bij ( fun x hx => ( ⟨ n, m ⟩, l ) ) ?_ ?_ ?_ ?_ <;> simp;
  · aesop;
  · grind

/-! ## The `S₃` presentation: involutivity and the braid relation -/

/-
`τ₁₂² = 1`.
-/
theorem swap12_sq : swap12 * swap12 = 1 := by
  have h_swap12_sq : swap12 * swap12 = (swap ⊗ₖ 1) * (swap ⊗ₖ 1) := by
    rfl;
  rw [ h_swap12_sq, ← Matrix.mul_kronecker_mul ];
  rw [ BookProof.ChapterA3l.swap_sq ] ; norm_num

/-
`τ₂₃² = 1`.
-/
theorem swap23_sq : swap23 * swap23 = 1 := by
  ext a b;
  rw [ Matrix.mul_apply ];
  simp only [swap23, of_apply, mul_ite, mul_one, mul_zero, one_apply];
  rw [ Finset.sum_eq_single ( ( b.1.1, b.2 ), b.1.2 ) ] <;> aesop

/-
`τ₁₃² = 1`.
-/
theorem swap13_sq : swap13 * swap13 = 1 := by
  ext a b; simp only [swap13] ;
  simp only [mul_apply, of_apply, mul_ite, mul_one, mul_zero, one_apply];
  rw [ Finset.sum_eq_single ( ( b.2, b.1.2 ), b.1.1 ) ] <;> aesop

/-
Braid relation, left form: `τ₁₂ τ₂₃ τ₁₂ = τ₁₃`.
-/
theorem braid_left : swap12 * swap23 * swap12 = swap13 := by
  ext a b; simp only [mul_apply] ;
  unfold swap12 swap23 swap13;
  simp only [kroneckerMap, ChapterA3l.swap, of_apply, ite_mul, one_mul, zero_mul, mul_ite, mul_one,
      mul_zero];
  simp only [one_apply, Finset.sum_ite, not_and, Finset.sum_const_zero, add_zero, mul_ite, mul_one,
      mul_zero];
  split_ifs <;> simp_all only [Finset.filter_filter, Finset.sum_const, nsmul_eq_mul, mul_one,
      not_and];
  · rw [ Finset.sum_eq_single ( ( a.1.2, a.2 ), a.1.1 ) ]
    · simp only [Nat.cast_eq_one]
      rw [ Finset.card_eq_one ] ; use ( ( a.1.2, a.1.1 ), a.2 ) ; ext ; aesop
    · simp [ * ]
      aesop
    · simp [ * ]
  · rw [ Finset.sum_eq_zero ] ; aesop

/-
Braid relation, right form: `τ₂₃ τ₁₂ τ₂₃ = τ₁₃`.
-/
theorem braid_right : swap23 * swap12 * swap23 = swap13 := by
  unfold swap12 swap23 swap13;
  ext a b; simp only [kroneckerMap, mul_apply, of_apply, ite_mul, one_mul, zero_mul, mul_ite,
      mul_one, mul_zero] ;
  simp only [ChapterA3l.swap, of_apply, one_apply, mul_ite, mul_one, mul_zero];
  rw [ Finset.sum_eq_single ( ( b.1.1, b.2 ), b.1.2 ) ] <;> simp only [and_self, ↓reduceIte,
      Finset.mem_univ, ne_eq, ite_eq_right_iff, and_imp, forall_const, Prod.forall, Prod.mk.injEq,
          not_and, not_true_eq_false, IsEmpty.forall_iff];
  · rw [ Finset.sum_eq_single ( ( b.2, b.1.1 ), b.1.2 ) ] <;> aesop;
  · aesop

/-- The Coxeter braid relation of `S₃`: `τ₁₂ τ₂₃ τ₁₂ = τ₂₃ τ₁₂ τ₂₃`. -/
theorem braid_rel : swap12 * swap23 * swap12 = swap23 * swap12 * swap23 := by
  rw [braid_left, braid_right]

/-! ## The diagonal Lorentz / parity action on `V ⊗ V ⊗ V` -/

/-- The **diagonal** `Spin⁺(3,1)` generator on `V ⊗ V ⊗ V`:
`γ^μγ^ν ⊗ 1 ⊗ 1 + 1 ⊗ γ^μγ^ν ⊗ 1 + 1 ⊗ 1 ⊗ γ^μγ^ν`. -/
noncomputable def spinGenDiag3 (μ ν : Fin 4) : M3 :=
  (spinGen μ ν ⊗ₖ 1) ⊗ₖ 1 + (1 ⊗ₖ spinGen μ ν) ⊗ₖ 1 + (1 ⊗ₖ 1) ⊗ₖ spinGen μ ν

/-- The **diagonal** parity operator on `V ⊗ V ⊗ V`: `γ⁰ ⊗ γ⁰ ⊗ γ⁰`. -/
noncomputable def parityDiag3 : M3 := (mgamma 0 ⊗ₖ mgamma 0) ⊗ₖ mgamma 0

/-! ## Each transposition commutes with the diagonal action -/

theorem swap12_spinGenDiag_comm (μ ν : Fin 4) :
    swap12 * spinGenDiag3 μ ν = spinGenDiag3 μ ν * swap12 := by
  -- Applying the identity for `swap12` to each term in `spinGenDiag3`.
  have step1 : ∀ (μ ν : Fin 4),    (swap12 * (spinGen μ ν ⊗ₖ 1) ⊗ₖ 1 = ((1 ⊗ₖ spinGen μ ν) ⊗ₖ 1) *
      swap12) := by
    intro μ ν;
    convert swap12_kronecker ( spinGen μ ν ) 1 1 using 1;
  convert congr_arg₂ ( fun x y => x + y ) ( congr_arg₂ ( fun x y => x + y ) ( step1 μ ν ) (
      swap12_kronecker ( 1 : Matrix ( Fin 4 ) ( Fin 4 ) ℂ ) ( spinGen μ ν ) ( 1 : Matrix ( Fin 4 ) (
          Fin 4 ) ℂ ) ) ) ( swap12_kronecker ( 1 : Matrix ( Fin 4 ) ( Fin 4 ) ℂ ) ( 1 : Matrix ( Fin
              4 ) ( Fin 4 ) ℂ ) ( spinGen μ ν ) ) using 1;
  · unfold spinGenDiag3; simp [ Matrix.mul_add ] ;
  · unfold spinGenDiag3; simp only [zero_mul, implies_true, mul_zero, mul_one, kroneckerMap_one_one,
      add_assoc, add_mul] ;
    abel1

theorem swap23_spinGenDiag_comm (μ ν : Fin 4) :
    swap23 * spinGenDiag3 μ ν = spinGenDiag3 μ ν * swap23 := by
  unfold spinGenDiag3;
  simp only [mul_add];
  rw [ swap23_kronecker, swap23_kronecker, swap23_kronecker ];
  rw [ add_mul, add_mul ] ; abel_nf;

theorem swap13_spinGenDiag_comm (μ ν : Fin 4) :
    swap13 * spinGenDiag3 μ ν = spinGenDiag3 μ ν * swap13 := by
  unfold spinGenDiag3;
  simp only [zero_mul, implies_true, mul_zero, mul_one, kroneckerMap_one_one, Matrix.mul_add,
      Matrix.add_mul];
  have := swap13_kronecker ( spinGen μ ν ) 1 1;    ( have := swap13_kronecker 1 ( spinGen μ ν ) 1; (
      have := swap13_kronecker 1 1 ( spinGen μ ν ) ; simp_all only [zero_mul, implies_true,
          mul_zero, mul_one, kroneckerMap_one_one]  ; ) );
  abel1

theorem swap12_parityDiag_comm : swap12 * parityDiag3 = parityDiag3 * swap12 := by
  exact swap12_kronecker _ _ _

theorem swap23_parityDiag_comm : swap23 * parityDiag3 = parityDiag3 * swap23 := by
  convert swap23_kronecker ( BookProof.ChapterA3.mgamma 0 ) ( BookProof.ChapterA3.mgamma 0 ) (
      BookProof.ChapterA3.mgamma 0 ) using 1

theorem swap13_parityDiag_comm : swap13 * parityDiag3 = parityDiag3 * swap13 := by
  have := @swap13_kronecker;
  exact this _ _ _

/-! ## The total symmetrizer and its full-Lorentz invariance -/

/-- The total symmetrizer `projSym3 = (1/6)·Σ_{g∈S₃} ρ(g)` onto the symmetric
cube `V ⊙ V ⊙ V`.  The six group elements are realized as
`1, τ₁₂, τ₂₃, τ₁₂τ₂₃, τ₂₃τ₁₂, τ₁₃`. -/
noncomputable def projSym3 : M3 :=
  (6 : ℂ)⁻¹ • (1 + swap12 + swap23 + swap12 * swap23 + swap23 * swap12 + swap13)

/-
**Lemma 52 payoff (symmetric-cube step).** The symmetric cube is a diagonal
`Spin⁺` subrepresentation: `projSym3` commutes with every diagonal Lorentz
generator.
-/
theorem projSym3_spinGenDiag_comm (μ ν : Fin 4) :
    projSym3 * spinGenDiag3 μ ν = spinGenDiag3 μ ν * projSym3 := by
  unfold projSym3;
  simp [ Matrix.mul_add, add_mul, Matrix.mul_assoc, swap12_spinGenDiag_comm,
      swap23_spinGenDiag_comm, swap13_spinGenDiag_comm ];
  simp only [← mul_assoc, swap12_spinGenDiag_comm, swap23_spinGenDiag_comm]

/-
**Lemma 52 payoff (symmetric-cube step).** The symmetric cube is also
parity-invariant: `projSym3` commutes with diagonal parity `γ⁰⊗γ⁰⊗γ⁰`.  Thus the
real symmetric-cube construction is automatically a representation of the full
Lorentz group.
-/
theorem projSym3_parityDiag_comm :
    projSym3 * parityDiag3 = parityDiag3 * projSym3 := by
  rw [ show projSym3 = ( 6 : ℂ ) ⁻¹ • ( 1 + swap12 + swap23 + swap12 * swap23 + swap23 * swap12 +
      swap13 ) from rfl ];
  simp [ Matrix.add_mul, Matrix.mul_add, mul_assoc ];
  simp only [swap12_parityDiag_comm, swap23_parityDiag_comm, ← Matrix.mul_assoc,
      swap13_parityDiag_comm]

/-
`projSym3` is idempotent — a genuine projector onto the symmetric cube.
This encodes the group identity `(Σ_{g∈S₃} g)² = 6·Σ_{g∈S₃} g`: the six braiding
operators `1, τ₁₂, τ₂₃, τ₁₂τ₂₃, τ₂₃τ₁₂, τ₁₃` are exactly the image of `S₃` under
the permutation representation, closed under multiplication.
-/
theorem projSym3_idem : projSym3 * projSym3 = projSym3 := by
  unfold projSym3;
  -- Expand the product using the distributive property.
  simp only [smul_add, Matrix.mul_add, Algebra.mul_smul_comm, mul_one, Matrix.add_mul,
      Algebra.smul_mul_assoc, one_mul, Matrix.mul_assoc] at *;
  rw [ show swap13 = swap12 * swap23 * swap12 from braid_left.symm ];
  simp_all only [mul_assoc, swap12_sq, mul_one, swap23_sq];
  simp_all only [← mul_assoc, braid_rel, swap12_sq, one_mul, swap23_sq, mul_one];
  rw [ show swap23 * swap12 * swap23 * swap23 = swap23 * swap12 by
        rw [ mul_assoc, swap23_sq, mul_one ] ]
  rw [ show swap12 * swap23 * swap23 = swap12 by
        rw [ mul_assoc, swap23_sq, mul_one ] ]
  abel_nf
  norm_num [ ← smul_assoc ]

end BookProof.ChapterA3m
