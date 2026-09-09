import Mathlib
import BookProof.ChapterReconstruct
import BookProof.ChapterTimeTranslation

/-!
# Chapter "Wave-function parametrization of a probability measure", §9
*"Deterministic transformations"* — the commutation criterion for determinism

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, §9 *"Deterministic transformations"* (`book.tex` line ~1958).

The book's headline result of that section is:

> *"We conclude that an automorphism `U` is deterministic if and only if `P_A`
> and `U P_B U†` commute for all events `A, B`."*

Here `P_A ∈ L^∞(X,μ)` is the (diagonal) projection-valued measure attached to an
event `A ⊆ X`, and `U` is a unitary automorphism.  In the finite-dimensional
measurement basis `Fin n`, `L^∞` is the algebra of diagonal matrices, a single
outcome `a` corresponds to the rank-one projection `P_a = |e_a⟩⟨e_a|`
(`ChapterTimeTranslation.proj`), a general event `A ⊆ {0,…,n-1}` to
`P_A = ∑_{a∈A} P_a`, and the transformed measurement operator is
`U P_B U†` (`ChapterTimeTranslation.measOp` for a single outcome).

`U` being *deterministic* means, exactly as in `ChapterReconstruct`, that every
column of `U` has at most one nonzero entry (a permutation matrix up to phases):
the automorphism `P_A ↦ U† P_A U` maps diagonal projections to diagonal
projections, i.e. points of the spectrum of `L^∞` one-to-one to points of the
spectrum of `L^∞`.

This file supplies the **commutation layer** on top of the off-diagonal-Born
core of `ChapterReconstruct`:

* `commute_proj_measOp_iff_isDeterministicCol` — for a fixed outcome `b`, the
  rank-one projections `P_a` commute with `U P_b U†` for **all** `a` iff column
  `b` of `U` is deterministic;
* **headline** `commute_proj_measOp_iff_isDeterministic` — `P_a` and `U P_b U†`
  commute for all single outcomes `a, b` iff `U` is deterministic;
* `projSet` / `measOpSet` — event projections `P_A = ∑_{a∈A} P_a` and the
  transformed event operator `U P_B U†`, with `measOpSet_eq_sum`;
* **headline (event form)** `commute_projSet_measOpSet_iff_isDeterministic` — the
  literal book statement: `P_A` and `U P_B U†` commute for **all events**
  `A, B ⊆ {0,…,n-1}` iff `U` is deterministic.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct BookProof.ChapterTimeTranslation

namespace BookProof.ChapterDeterministic

variable {n : ℕ}

/-
Entries of `P_a · (U P_b U†)`: nonzero only in row `a`, where it equals
`U a b · conj(U j b)`.
-/
theorem proj_mul_measOp_apply (U : Matrix (Fin n) (Fin n) ℂ) (a b i j : Fin n) :
    (proj a * measOp U b) i j =
      if i = a then U a b * (starRingEnd ℂ) (U j b) else 0 := by
  by_cases hij : i = a <;> simp only [mul_apply, ↓reduceIte, hij];
  · unfold proj measOp; simp only [of_apply, true_and, ite_mul, one_mul, zero_mul, sum_ite_eq',
      mem_univ, ↓reduceIte]  ;
    convert measOp_apply U b a j using 1;
  · exact Finset.sum_eq_zero fun k hk => by unfold proj; aesop;

/-
Entries of `(U P_b U†) · P_a`: nonzero only in column `a`, where it equals
`U i b · conj(U a b)`.
-/
theorem measOp_mul_proj_apply (U : Matrix (Fin n) (Fin n) ℂ) (a b i j : Fin n) :
    (measOp U b * proj a) i j =
      if j = a then U i b * (starRingEnd ℂ) (U a b) else 0 := by
  rw [Matrix.mul_apply];
  rw [ Finset.sum_eq_single a ] <;> simp +contextual [ proj, measOp_apply ]

/-
**Per-column criterion.** For a fixed outcome `b`, the rank-one projections
`P_a` commute with the transformed measurement operator `U P_b U†` for every
outcome `a` iff column `b` of `U` is deterministic (at most one nonzero entry).
-/
theorem commute_proj_measOp_iff_isDeterministicCol
    (U : Matrix (Fin n) (Fin n) ℂ) (b : Fin n) :
    (∀ a : Fin n, Commute (proj a) (measOp U b)) ↔ IsDeterministicCol U b := by
  constructor;
  · intro h_comm l m hlm;
    convert congr_arg (fun x : ℂ => starRingEnd ℂ x)
      (congr_fun (congr_fun (h_comm m) m) l) using 1
      <;> simp only [proj]
    · simp [Matrix.mul_apply, measOp_apply]
    · have h := measOp_mul_proj_apply U m b m l
      simp only [proj, hlm, ↓reduceIte] at h
      rw [h]
      simp
  · intro h a
    ext i j
    by_cases hi : i = a <;> by_cases hj : j = a
      <;> simp [*, proj_mul_measOp_apply, measOp_mul_proj_apply]
    · specialize h j a; aesop
    · specialize h i a; aesop

/-
**Headline (single-outcome form).** The projections `P_a` and the transformed
measurement operators `U P_b U†` commute for all outcomes `a, b` iff `U` is
deterministic (a permutation matrix up to phases).  This is the book's criterion
*"an automorphism `U` is deterministic if and only if `P_A` and `U P_B U†`
commute for all events `A, B`"* specialized to single-outcome events.
-/
theorem commute_proj_measOp_iff_isDeterministic
    (U : Matrix (Fin n) (Fin n) ℂ) :
    (∀ a b : Fin n, Commute (proj a) (measOp U b)) ↔ IsDeterministic U := by
  constructor;
  · exact fun h => fun b => ( commute_proj_measOp_iff_isDeterministicCol U b ).mp fun a => h a b;
  · intro h a b; specialize h b; exact (commute_proj_measOp_iff_isDeterministicCol U b).mpr h a;

/-- The event projection `P_A = ∑_{a∈A} P_a` for an event `A ⊆ {0,…,n-1}`
(a diagonal element of `L^∞`). -/
noncomputable def projSet (A : Finset (Fin n)) : Matrix (Fin n) (Fin n) ℂ :=
  ∑ a ∈ A, proj a

/-- The transformed event measurement operator `U P_B U†`. -/
noncomputable def measOpSet (U : Matrix (Fin n) (Fin n) ℂ) (B : Finset (Fin n)) :
    Matrix (Fin n) (Fin n) ℂ :=
  U * projSet B * Uᴴ

/-
The transformed event operator is the sum of the single-outcome ones:
`U P_B U† = ∑_{b∈B} U P_b U†`.
-/
theorem measOpSet_eq_sum (U : Matrix (Fin n) (Fin n) ℂ) (B : Finset (Fin n)) :
    measOpSet U B = ∑ b ∈ B, measOp U b := by
  unfold measOpSet measOp;    simp only [mul_assoc] ;
  unfold projSet; simp [ Finset.sum_mul, Finset.mul_sum ] ;

/-
**Headline (event form — the literal book statement).** For a unitary
automorphism `U`, the event projections `P_A` and the transformed event operators
`U P_B U†` commute for **all events** `A, B ⊆ {0,…,n-1}` iff `U` is deterministic.
This is exactly *"an automorphism `U` is deterministic if and only if `P_A` and
`U P_B U†` commute for all events `A, B`."*
-/
theorem commute_projSet_measOpSet_iff_isDeterministic
    (U : Matrix (Fin n) (Fin n) ℂ) :
    (∀ A B : Finset (Fin n), Commute (projSet A) (measOpSet U B)) ↔ IsDeterministic U := by
  refine ⟨ ?_, fun h => ?_ ⟩;
  · intro hU;
    exact BookProof.ChapterDeterministic.commute_proj_measOp_iff_isDeterministic U |>.1 fun a b =>
        by simpa [ projSet, measOpSet_eq_sum ] using hU { a } { b } ;
  · -- By the single-outcome headline, we have that for all a and b, P_a and U P_b U† commute.
    have h_single : ∀ a b : Fin n, Commute (proj a) (measOp U b) := by
      exact fun a b => ( commute_proj_measOp_iff_isDeterministic U ).mpr h a b;
    exact fun A B => by rw [ measOpSet_eq_sum, projSet ] ;      exact Commute.sum_left _ _ _ fun a _
                        => Commute.sum_right _ _ _ fun b _ => h_single a b;

end BookProof.ChapterDeterministic
