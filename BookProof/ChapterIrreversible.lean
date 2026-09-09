import Mathlib

/-!
# Chapter "Reconstructing the classical trajectory of any isolated quantum system"
— §"Symmetries as irreversible processes"

Source: `book.tex`, chapter *"Reconstructing the classical trajectory of any
isolated quantum system"*, subsection *"Symmetries as irreversible processes"*
(line ~2679).

The book argues: *"A non-deterministic symmetry transformation, when acting on a
deterministic ensemble increases the entropy of the ensemble after the
wave-function collapse and therefore must be an irreversible transformation."*
Conversely, if the symmetry is deterministic then the ensemble stays a
deterministic ensemble and the entropy is preserved (equal to `0`), so the
transformation is reversible. This is the entropy counterpart of the main
result of the chapter (*"time translation is a stochastic process if and only
if it is deterministic"*).

This file formalizes the self-contained information-theoretic core of that claim.

* A *deterministic ensemble* is a point mass (`IsPointMass`): the state of the
  system is known, so the probability vector is concentrated on one outcome.
* Acting with a Wigner symmetry `U` and collapsing the wave-function turns the
  initial basis state `e_k` into the **Born distribution** `bornDist v`, where
  `v = U e_k` is the corresponding column: `p_a = ‖v a‖²`.
* `entropy` is the Shannon entropy `∑_a negMulLog (p a) = ∑_a -p a · log (p a)`.

Headlines:

* `entropy_pointMass_zero` — a deterministic ensemble has entropy `0`.
* `entropy_nonneg` — the entropy of any probability vector is `≥ 0`.
* `entropy_pos_of_not_pointMass` — a non-deterministic ensemble has entropy `> 0`.
* `entropy_eq_zero_iff_pointMass` — entropy `0` **iff** deterministic ensemble.
* `entropy_bornDist_eq_zero_iff` — for a unit column `v`, the collapsed ensemble
  has entropy `0` **iff** `v` is a *deterministic column* (the symmetry maps the
  deterministic ensemble to a deterministic ensemble): the *reversible* case.
* `entropy_bornDist_pos_iff` — for a unit column `v`, the collapsed ensemble has
  entropy `> 0` **iff** `v` is *not* a deterministic column: the symmetry
  strictly increases the entropy — the *irreversible* case.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

open scoped BigOperators
open Finset

namespace BookProof.ChapterIrreversible

variable {n : ℕ}

/-- Shannon entropy of a finite probability vector `p : Fin n → ℝ`,
`H(p) = ∑_a -p a · log (p a)`. -/
noncomputable def entropy (p : Fin n → ℝ) : ℝ :=
  ∑ a, Real.negMulLog (p a)

/-- A probability vector is a *deterministic ensemble* (point mass) when it is
concentrated on a single outcome. -/
def IsPointMass (p : Fin n → ℝ) : Prop :=
  ∃ a, p a = 1 ∧ ∀ b, b ≠ a → p b = 0

/-- The Born distribution obtained from a wave-function column `v` after
wave-function collapse: `p_a = ‖v a‖²`. -/
noncomputable def bornDist (v : Fin n → ℂ) : Fin n → ℝ :=
  fun a => ‖v a‖ ^ 2

/-- A wave-function column is a *deterministic column* when it is supported on a
single basis vector (the symmetry sends a basis state to a basis state up to a
phase). -/
def IsDeterministicColumn (v : Fin n → ℂ) : Prop :=
  ∃ a, v a ≠ 0 ∧ ∀ b, b ≠ a → v b = 0

/-
Each coordinate of the Born distribution is nonnegative.
-/
theorem bornDist_nonneg (v : Fin n → ℂ) (a : Fin n) : 0 ≤ bornDist v a := by
  exact sq_nonneg _

/-
The Born distribution of a unit column sums to `1`.
-/
theorem bornDist_sum (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    ∑ a, bornDist v a = 1 := by
  exact hv

/-
In a probability vector (nonnegative, summing to `1`), each coordinate is
`≤ 1`.
-/
theorem le_one_of_prob (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) (a : Fin n) : p a ≤ 1 := by
  exact hsum ▸ Finset.single_le_sum ( fun a _ => hnn a ) ( Finset.mem_univ a )

/-
A deterministic ensemble has zero entropy.
-/
theorem entropy_pointMass_zero (p : Fin n → ℝ) (hp : IsPointMass p) :
    entropy p = 0 := by
  obtain ⟨ a, ha ⟩ := hp;
  exact Finset.sum_eq_zero fun i hi => by by_cases hi' : i = a <;> simp [ * ] ;

/-
The entropy of any probability vector is nonnegative.
-/
theorem entropy_nonneg (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) : 0 ≤ entropy p := by
  exact Finset.sum_nonneg fun i _ => Real.negMulLog_nonneg ( hnn i ) ( le_one_of_prob p hnn hsum i )

/-
A probability vector that is **not** a deterministic ensemble has some
coordinate strictly between `0` and `1`.
-/
theorem exists_mem_Ioo_of_not_pointMass (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) (hnp : ¬ IsPointMass p) :
    ∃ a, 0 < p a ∧ p a < 1 := by
  contrapose! hnp; simp_all only [IsPointMass, ne_eq] ;
  -- Since $p$ is not a point mass, there exists some $a$ such that $p(a) > 0$.
  obtain ⟨a, ha⟩ : ∃ a, 0 < p a := by
    refine not_forall_not.mp fun h => ?_
    have hp0 : p = fun _ => 0 := by funext a; linarith [ h a, hnn a ]
    norm_num [ hp0 ] at hsum
  exact ⟨ a,
    le_antisymm ( hsum ▸ Finset.single_le_sum ( fun x _ => hnn x ) ( Finset.mem_univ a ) )
      ( hnp a ha ),
    fun b hb => le_antisymm
      ( by
          have := hsum ▸ Finset.sum_eq_add_sum_diff_singleton ( Finset.mem_univ a ) p
          linarith [ hnp a ha, hnn b, Finset.single_le_sum ( fun x _ => hnn x )
            ( Finset.mem_sdiff.mpr ⟨ Finset.mem_univ b, by aesop ⟩ :
              b ∈ Finset.univ \ { a } ) ] )
      ( hnn b ) ⟩

/-
A non-deterministic ensemble has strictly positive entropy: a symmetry that
turns a deterministic ensemble into a non-deterministic one strictly increases
the entropy.
-/
theorem entropy_pos_of_not_pointMass (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) (hnp : ¬ IsPointMass p) : 0 < entropy p := by
  obtain ⟨ a, ha₁, ha₂ ⟩ := exists_mem_Ioo_of_not_pointMass p hnn hsum hnp;
  refine Finset.sum_pos'
    ( fun i _ => Real.negMulLog_nonneg ( hnn i ) ( le_one_of_prob p hnn hsum i ) )
    ⟨ a, Finset.mem_univ a, ?_ ⟩
  rw [ Real.negMulLog_def ] ; nlinarith [ Real.log_le_sub_one_of_pos ha₁ ]

/-
**Reversible iff deterministic (entropy form).** For a probability vector,
the entropy is `0` if and only if the ensemble is deterministic.
-/
theorem entropy_eq_zero_iff_pointMass (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) : entropy p = 0 ↔ IsPointMass p := by
  refine ⟨ fun h => ?_, fun h => ?_ ⟩;
  · contrapose! h;
    exact ne_of_gt ( entropy_pos_of_not_pointMass p hnn hsum h );
  · exact entropy_pointMass_zero p h

/-
For a unit column, the collapsed Born ensemble is deterministic (a point
mass) if and only if the column itself is deterministic.
-/
theorem isPointMass_bornDist_iff (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    IsPointMass (bornDist v) ↔ IsDeterministicColumn v := by
  constructor <;> intro h;
  · obtain ⟨ a, ha₁, ha₂ ⟩ := h;
    exact ⟨ a, by contrapose! ha₁; simp_all [ bornDist ],
      fun b hb => by specialize ha₂ b hb; simp_all [ bornDist ] ⟩;
  · obtain ⟨ a, ha₁, ha₂ ⟩ := h; use a; simp_all  ;
    simp_all [ Finset.sum_eq_single a, bornDist ]

/-
**Reversible case.** For a unit column `v`, the collapsed ensemble has
entropy `0` — the symmetry preserves the entropy of the deterministic ensemble —
if and only if `v` is a deterministic column.
-/
theorem entropy_bornDist_eq_zero_iff (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    entropy (bornDist v) = 0 ↔ IsDeterministicColumn v :=
  (entropy_eq_zero_iff_pointMass (bornDist v) (bornDist_nonneg v)
    (bornDist_sum v hv)).trans (isPointMass_bornDist_iff v hv)

/-
**Irreversible case.** For a unit column `v`, the collapsed ensemble has
strictly positive entropy — the symmetry strictly increases the entropy of the
deterministic ensemble — if and only if `v` is **not** a deterministic column.
-/
theorem entropy_bornDist_pos_iff (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    0 < entropy (bornDist v) ↔ ¬ IsDeterministicColumn v := by
  rw [ ← entropy_bornDist_eq_zero_iff v hv ];
  exact ⟨ fun h => ne_of_gt h,
    fun h => lt_of_le_of_ne
      ( entropy_nonneg _ ( fun a => sq_nonneg _ ) ( by simpa [ ← sq ] using hv ) )
      ( Ne.symm h ) ⟩

end BookProof.ChapterIrreversible
