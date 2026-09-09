import Mathlib

/-!
# Finite arithmetic with a Bayesian prior beyond the truncation

This module gives a precise finite model of the book's proposal.  Arithmetic
results inside a bound `B` are stored exactly; results outside the finite table
are represented by a normalized nonnegative prior on a finite hypothesis space.
-/

namespace BookProof.ChapterFiniteArithmeticPrior

/-- A finite table for a binary arithmetic operation below a bound. -/
structure BoundedArithmetic (B : ℕ) where
  result : Fin B → Fin B → Fin B

/-- A Bayesian extension of bounded arithmetic by a finite hypothesis space. -/
structure BayesianArithmeticExtension (B : ℕ) (H : Type*) [Fintype H] where
  known : BoundedArithmetic B
  prior : H → ℝ
  prior_nonneg : ∀ h, 0 ≤ prior h
  prior_sum_one : ∑ h, prior h = 1

/-- The unknown part of a Bayesian arithmetic extension is a genuine finite
probability distribution. -/
theorem prior_is_probability {B : ℕ} {H : Type*} [Fintype H]
    (E : BayesianArithmeticExtension B H) :
    (∀ h, 0 ≤ E.prior h) ∧ ∑ h, E.prior h = 1 := by
  exact ⟨E.prior_nonneg, E.prior_sum_one⟩

/-- Every exact bounded arithmetic table admits the degenerate one-hypothesis
Bayesian extension. -/
def certainExtension {B : ℕ} (A : BoundedArithmetic B) :
    BayesianArithmeticExtension B PUnit where
  known := A
  prior := fun _ => 1
  prior_nonneg := by intro; norm_num
  prior_sum_one := by simp

/-- The extension preserves every result in the finite exact table. -/
theorem certainExtension_known {B : ℕ} (A : BoundedArithmetic B) :
    (certainExtension A).known = A := by
  rfl

/-- The **truncated multiplication table** below the bound `B`: the exact product
whenever it still fits below `B`, and the largest representable value `B - 1`
otherwise.  This is the finite computation the book proposes to carry out
exactly, with everything beyond the truncation handled by a prior. -/
def truncMul (B : ℕ) [NeZero B] : BoundedArithmetic B where
  result a b :=
    if h : (a : ℕ) * (b : ℕ) < B then ⟨(a : ℕ) * (b : ℕ), h⟩
    else ⟨B - 1, Nat.sub_lt (Nat.pos_of_neZero B) Nat.one_pos⟩

/-- **Consistency of the truncation with exact arithmetic.**  On the range where
the exact product is representable, the finite table returns exactly the product
of the two integers. -/
theorem truncMul_eq_mul {B : ℕ} [NeZero B] (a b : Fin B) (h : (a : ℕ) * (b : ℕ) < B) :
    (((truncMul B).result a b : Fin B) : ℕ) = (a : ℕ) * (b : ℕ) := by
  simp [truncMul, h]

/-- Outside the representable range the table saturates at the largest value. -/
theorem truncMul_saturates {B : ℕ} [NeZero B] (a b : Fin B)
    (h : ¬ (a : ℕ) * (b : ℕ) < B) :
    (((truncMul B).result a b : Fin B) : ℕ) = B - 1 := by
  simp [truncMul, h]

/-- The truncated multiplication table, extended by a Bayesian prior over the
unknown results, is a genuine probability model: the known part is the exact
table on `[0, B)` and the unknown part is a normalized distribution. -/
theorem truncMul_extension_consistent {B : ℕ} [NeZero B] {H : Type*} [Fintype H]
    (E : BayesianArithmeticExtension B H) (hE : E.known = truncMul B)
    (a b : Fin B) (h : (a : ℕ) * (b : ℕ) < B) :
    ((E.known.result a b : Fin B) : ℕ) = (a : ℕ) * (b : ℕ) ∧
      (∀ x, 0 ≤ E.prior x) ∧ ∑ x, E.prior x = 1 := by
  refine ⟨?_, E.prior_nonneg, E.prior_sum_one⟩
  rw [hE]
  exact truncMul_eq_mul a b h

end BookProof.ChapterFiniteArithmeticPrior
