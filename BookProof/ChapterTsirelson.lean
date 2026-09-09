import Mathlib
import BookProof.ChapterBell

/-!
# Chapter "Reconstructing the classical trajectory of any isolated quantum system",
  §"Do the Bell inequalities hold?" — **Tsirelson's bound is tight**

This file continues `BookProof.ChapterBell`.  There, the `book.tex` section *"Do the Bell
inequalities hold?"* was formalized as (A) the classical Bell/CHSH inequality
`|⟨A₀B₀⟩ + ⟨A₀B₁⟩ + ⟨A₁B₀⟩ − ⟨A₁B₁⟩| ≤ 2` for any local hidden-variable model, and (B) the
concrete two-qubit quantum model whose CHSH expectation value in the Bell state `|Φ⁺⟩`
equals the **Tsirelson value** `2√2 > 2`.

Mathlib already contains the abstract **Tsirelson inequality** (`tsirelson_inequality`):
for any CHSH tuple `A₀ A₁ B₀ B₁` (self-adjoint involutions with the `Aᵢ` commuting with the
`Bⱼ`) in an ordered `*`-algebra over `ℝ`,
`A₀ * B₀ + A₀ * B₁ + A₁ * B₀ − A₁ * B₁ ≤ √2 ^ 3 • 1`,
and its docstring flags as *future work* that this bound is **tight**: there is a CHSH tuple
of `4×4` complex matrices whose CHSH operator has `2√2` as an eigenvalue.  This file supplies
exactly that witness, tying it to the concrete `ChapterBell` model.

## Contents

* `alA0, alA1, boB0, boB1` — the two-qubit CHSH tuple as genuine elements of the *same*
  `*`-ring `Matrix (Fin 2 × Fin 2) (Fin 2 × Fin 2) ℂ`: Alice's observables `σ_z ⊗ 1`,
  `σ_x ⊗ 1`, Bob's observables `1 ⊗ (σ_z±σ_x)/√2`.
* `chshTuple_isCHSHTuple` — this quadruple **is** an `IsCHSHTuple`, i.e. it satisfies exactly
  the hypotheses of Mathlib's `tsirelson_inequality`.
* `chshOp_eq_tuple` — the `ChapterBell.chshOp` operator equals the tuple's CHSH combination
  `alA0*boB0 + alA0*boB1 + alA1*boB0 − alA1*boB1`.
* `tsirelson_value_eq` — the Tsirelson value `2√2` equals the abstract bound constant `√2 ^ 3`.
* `chshOp_eigenvector` — the tightness witness: the CHSH operator has the Bell state as an
  eigenvector with eigenvalue `2√2`, `S |Φ⁺⟩ = 2√2 |Φ⁺⟩`.
* `tsirelson_bound_tight` — headline: the concrete tuple is a CHSH tuple whose operator has
  the abstract Tsirelson bound `√2 ^ 3 = 2√2` as an eigenvalue, so the bound is saturated.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped Kronecker

namespace BookProof.ChapterTsirelson

open BookProof.ChapterBell

/-- Alice's first observable as an element of the two-qubit `*`-ring: `A₀ = σ_z ⊗ 1`. -/
noncomputable def alA0 : Matrix (Fin 2 × Fin 2) (Fin 2 × Fin 2) ℂ :=
  A0 ⊗ₖ (1 : Matrix (Fin 2) (Fin 2) ℂ)

/-- Alice's second observable: `A₁ = σ_x ⊗ 1`. -/
noncomputable def alA1 : Matrix (Fin 2 × Fin 2) (Fin 2 × Fin 2) ℂ :=
  A1 ⊗ₖ (1 : Matrix (Fin 2) (Fin 2) ℂ)

/-- Bob's first observable: `B₀ = 1 ⊗ (σ_z+σ_x)/√2`. -/
noncomputable def boB0 : Matrix (Fin 2 × Fin 2) (Fin 2 × Fin 2) ℂ :=
  (1 : Matrix (Fin 2) (Fin 2) ℂ) ⊗ₖ B0

/-- Bob's second observable: `B₁ = 1 ⊗ (σ_z−σ_x)/√2`. -/
noncomputable def boB1 : Matrix (Fin 2 × Fin 2) (Fin 2 × Fin 2) ℂ :=
  (1 : Matrix (Fin 2) (Fin 2) ℂ) ⊗ₖ B1

/-- The concrete two-qubit quadruple satisfies **exactly the hypotheses of Tsirelson's
inequality**: each observable is a self-adjoint involution and Alice's commute with Bob's. -/
theorem chshTuple_isCHSHTuple : IsCHSHTuple alA0 alA1 boB0 boB1 := by
  constructor
  all_goals
    norm_num [sq, ← Matrix.mul_kronecker_mul, alA0, alA1, boB0, boB1,
      A0, A1, B0, B1, sz, sx]
  all_goals
    norm_num [← Matrix.ext_iff, Fin.forall_fin_two, Matrix.mul_apply,
      Matrix.one_apply, kroneckerMap]
  all_goals norm_num [← sq, ← Complex.ofReal_pow]

/-- The `ChapterBell.chshOp` operator is the CHSH combination of the tuple:
`S = A₀B₀ + A₀B₁ + A₁B₀ − A₁B₁` with `Aᵢ = σ·⊗1`, `Bⱼ = 1⊗σ·`. -/
theorem chshOp_eq_tuple :
    chshOp = alA0 * boB0 + alA0 * boB1 + alA1 * boB0 - alA1 * boB1 := by
  unfold chshOp alA0 alA1 boB0 boB1;
  congr <;> ext i j;
  · fin_cases i <;> fin_cases j <;> simp only [Fin.zero_eta, Fin.isValue, kroneckerMap_apply,
      mul_apply, Fin.mk_one];
    all_goals erw [ Finset.sum_product ] ; simp [ Matrix.one_apply ] ;
  · fin_cases i <;> fin_cases j <;> simp only [Fin.zero_eta, Fin.isValue, kroneckerMap_apply,
      mul_apply, Fin.mk_one];
    all_goals erw [ Finset.sum_product ] ; simp [ Matrix.one_apply ] ;
  · fin_cases i <;> fin_cases j <;> simp only [Fin.zero_eta, Fin.isValue, kroneckerMap_apply,
      mul_apply, Fin.mk_one];
    all_goals simp only [Fin.isValue, one_apply, mul_ite, mul_one, mul_zero, ite_mul, one_mul,
        zero_mul] ;
    all_goals erw [ Finset.sum_product ] ; simp  ;
  · simp only [A1, B1, one_div, kroneckerMap_apply, smul_apply, sub_apply, smul_eq_mul, mul_apply];
    fin_cases i <;> fin_cases j <;> simp only [Fin.zero_eta, Fin.isValue, one_apply, mul_ite,
        mul_one, mul_zero, ite_mul, one_mul, zero_mul, Fin.mk_one];
    all_goals erw [ Finset.sum_product ] ; simp  ;

/-- The Tsirelson value `2√2` equals the constant `√2 ^ 3` appearing in Mathlib's abstract
bound `tsirelson_inequality`. -/
theorem tsirelson_value_eq : (2 * Real.sqrt 2 : ℝ) = Real.sqrt 2 ^ 3 := by
  have h : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  nlinarith [Real.sqrt_nonneg 2, h]

/-- **Tightness witness.**  The CHSH operator has the Bell state `|Φ⁺⟩` as an eigenvector
with eigenvalue `2√2`: `S |Φ⁺⟩ = 2√2 |Φ⁺⟩`.  Since a unit eigenvector's expectation value
is its eigenvalue, this refines `ChapterBell.chsh_quantum_value`. -/
theorem chshOp_eigenvector :
    chshOp *ᵥ bellState = ((2 * Real.sqrt 2 : ℝ) : ℂ) • bellState := by
  ext ⟨ i, j ⟩;
  fin_cases i <;> fin_cases j <;> simp only [chshOp, A0, sz, B0, one_div, sx, of_add_of, add_cons,
      head_cons, add_zero, tail_cons, zero_add, empty_add_empty, smul_of, smul_cons, smul_eq_mul,
          mul_one, smul_empty, mul_neg, B1, of_sub_of, sub_cons, sub_zero, zero_sub, sub_self,
              zero_empty, A1, Fin.zero_eta, Fin.isValue, Complex.ofReal_mul, Complex.ofReal_ofNat,
                  Pi.smul_apply, bellState, ↓reduceIte, ne_eq, Complex.ofReal_eq_zero,
                      Nat.ofNat_nonneg, Real.sqrt_eq_zero, OfNat.ofNat_ne_zero, not_false_eq_true,
                          mul_inv_cancel_right₀, Fin.mk_one, Prod.mk.injEq, one_ne_zero, and_false,
                              zero_ne_one, and_true, mul_zero, and_self];
  · simp only [mulVec, dotProduct, kroneckerMap, of_apply, cons_val', cons_val_fin_one, of_add_of,
      Fin.isValue, sub_apply, Pi.add_apply, cons_val_zero, Fintype.sum_prod_type,
      Fin.sum_univ_two, add_sub_cancel_right, cons_val_one, mul_neg, add_neg_cancel,
      zero_add, sub_neg_eq_add, one_mul, zero_mul, add_zero]
    unfold bellState; norm_num; ring; norm_num [← Complex.ofReal_pow]
  · simp only [mulVec, dotProduct, kroneckerMap, of_apply, cons_val', cons_val_fin_one, of_add_of,
      Fin.isValue, sub_apply, Pi.add_apply, cons_val_zero, cons_val_one]
    erw [Finset.sum_product]; norm_num [Fin.sum_univ_succ, bellState]
  · simp only [mulVec, dotProduct, kroneckerMap, of_apply, cons_val', cons_val_fin_one, of_add_of,
      Fin.isValue, sub_apply, Pi.add_apply, cons_val_one, cons_val_zero,
      Fintype.sum_prod_type, Fin.sum_univ_two, add_sub_cancel_right, mul_neg, add_neg_cancel,
      zero_add, sub_neg_eq_add, zero_mul, add_zero, one_mul, neg_mul]
    unfold bellState; norm_num
  · unfold bellState; norm_num [Matrix.mulVec, dotProduct, Fin.sum_univ_succ]
    erw [Finset.sum_product]; norm_num [Fin.sum_univ_succ]; ring;
      norm_num [← Complex.ofReal_pow]

/-- **Headline: Tsirelson's bound is tight.**  The concrete two-qubit model is a genuine
CHSH tuple whose CHSH operator has the abstract Tsirelson bound `√2 ^ 3 = 2√2` as an
eigenvalue (with the Bell state as eigenvector).  Hence the upper bound
`tsirelson_inequality` cannot be improved. -/
theorem tsirelson_bound_tight :
    IsCHSHTuple alA0 alA1 boB0 boB1 ∧
      chshOp *ᵥ bellState = ((Real.sqrt 2 ^ 3 : ℝ) : ℂ) • bellState := by
  refine ⟨chshTuple_isCHSHTuple, ?_⟩
  rw [chshOp_eigenvector, tsirelson_value_eq]

end BookProof.ChapterTsirelson
