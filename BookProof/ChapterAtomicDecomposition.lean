import Mathlib

/-!
# The atomic / continuous classification of a probability measure

`BookProof.ChapterSelectingEvents` proves that every probability measure on a
space with measurable singletons splits into a continuous (atomless) part and a
part carried by the countable set of atoms
(`exists_continuous_atomic_decomposition`).  The book's chapter *"Selecting
events is not rewriting the history of events"* uses that splitting to state von
Neumann's classification of abelian von Neumann algebras into **five** types
(`book.tex` lines 8789–8800):

`ℓ∞({1,…,n})`, `ℓ∞(ℕ)`, `L∞([0,1])`, `L∞([0,1] ∪ {1,…,n})`, `L∞([0,1] ∪ ℕ)`.

The full `*`-isomorphism classification is von Neumann's theorem and is not
formalized here.  What *is* formalized is its exact measure-theoretic skeleton,
which is what the book's argument actually uses:

* `atoms_countable` — the set of atoms is countable;
* `atomicPart_eq_sum_dirac` — the atomic part of `μ` is literally a countable
  sum of point masses `∑ₓ μ{x}·δₓ`;
* `noAtoms_continuousPart` — the complementary part is atomless;
* `eq_continuousPart_add_atomicPart` — `μ` is the sum of the two;
* `not_continuousPart_zero_and_atoms_empty` — a probability measure cannot have
  both parts trivial;
* HEADLINE `probability_measure_five_types` — consequently every probability
  measure falls into exactly one of **five** mutually exclusive classes, indexed
  by (continuous part present or not) × (atoms: none / finitely many / countably
  infinitely many), matching the five types of the book's list one for one.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory

namespace BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

/-- The set of **atoms** of a measure: the points carrying positive mass. -/
def atoms (mu : Measure X) : Set X := {x | 0 < mu {x}}

/-- The set of atoms of a measure is countable (`Measure.countable_meas_pos_of_disjoint_iUnion`). -/
theorem atoms_countable (mu : Measure X) [SFinite mu] : (atoms mu).Countable := by
  have := Measure.countable_meas_pos_of_disjoint_iUnion (μ := mu)
    (As := fun x : X => ({x} : Set X)) (fun x => measurableSet_singleton x)
    (by intro x y hxy; simpa [Function.onFun] using hxy)
  simpa [atoms] using this

theorem measurableSet_atoms (mu : Measure X) [SFinite mu] : MeasurableSet (atoms mu) :=
  (atoms_countable mu).measurableSet

/-- The **continuous part** of `mu`: its restriction to the complement of the atoms. -/
noncomputable def continuousPart (mu : Measure X) : Measure X := mu.restrict (atoms mu)ᶜ

/-- The **atomic part** of `mu`: its restriction to the set of atoms. -/
noncomputable def atomicPart (mu : Measure X) : Measure X := mu.restrict (atoms mu)

/-- The continuous part is atomless: no point carries positive mass for it. -/
theorem noAtoms_continuousPart (mu : Measure X) [SFinite mu] : NoAtoms (continuousPart mu) := by
  constructor
  intro x
  rcases eq_or_ne (mu {x}) 0 with h | h
  · exact le_antisymm ((Measure.restrict_apply_le _ _).trans (le_of_eq h)) (zero_le _)
  · have hxA : x ∈ atoms mu := pos_iff_ne_zero.mpr h
    rw [continuousPart, Measure.restrict_apply (measurableSet_singleton x)]
    have hempty : ({x} : Set X) ∩ (atoms mu)ᶜ = ∅ := by
      ext y
      simp only [Set.mem_inter_iff, Set.mem_singleton_iff, Set.mem_compl_iff,
        Set.mem_empty_iff_false, iff_false, not_and, not_not]
      rintro rfl; exact hxA
    simp [hempty]

/-- **The atomic part is a countable sum of point masses.**  This is the precise
form of "the discrete part of a probability measure is `∑ pᵢ δₓᵢ`", the
measure-theoretic content of the `ℓ∞`-summands in von Neumann's list. -/
theorem atomicPart_eq_sum_dirac (mu : Measure X) [SFinite mu] :
    atomicPart mu = Measure.sum (fun x : atoms mu => mu {(x : X)} • Measure.dirac (x : X)) := by
  ext s hs
  rw [atomicPart, Measure.restrict_apply hs, Measure.sum_apply _ hs]
  have hcover : s ∩ atoms mu = ⋃ x ∈ atoms mu, (s ∩ {x}) := by
    ext y
    simp only [Set.mem_inter_iff, Set.mem_iUnion, Set.mem_singleton_iff, exists_prop]
    constructor
    · rintro ⟨hy, hyA⟩; exact ⟨y, hyA, hy, rfl⟩
    · rintro ⟨x, hxA, hy, rfl⟩; exact ⟨hy, hxA⟩
  rw [hcover, measure_biUnion (atoms_countable mu) ?_ ?_]
  · refine tsum_congr fun x => ?_
    rw [Measure.smul_apply, Measure.dirac_apply' _ hs, smul_eq_mul]
    by_cases hx : (x : X) ∈ s
    · simp [hx, Set.inter_eq_right.mpr (Set.singleton_subset_iff.mpr hx)]
    · simp [hx, Set.inter_singleton_eq_empty.mpr hx]
  · intro x _ y _ hxy
    exact ((Set.disjoint_singleton.2 hxy).mono Set.inter_subset_right Set.inter_subset_right)
  · exact fun x _ => hs.inter (measurableSet_singleton x)

/-- `mu` is the sum of its continuous and its atomic part. -/
theorem eq_continuousPart_add_atomicPart (mu : Measure X) [SFinite mu] :
    mu = continuousPart mu + atomicPart mu := by
  rw [continuousPart, atomicPart, add_comm]
  exact (Measure.restrict_add_restrict_compl (measurableSet_atoms mu)).symm

/-- A probability measure cannot be trivial on both sides of the splitting: if it
has no atoms *and* a vanishing continuous part it would be the zero measure. -/
theorem not_continuousPart_zero_and_atoms_empty (mu : Measure X) [IsProbabilityMeasure mu] :
    ¬ (continuousPart mu = 0 ∧ atoms mu = ∅) := by
  rintro ⟨hc, ha⟩
  have hzero : mu = 0 := by
    rw [eq_continuousPart_add_atomicPart mu, hc, atomicPart, ha]
    simp
  have : (1 : ENNReal) = 0 := by
    rw [← measure_univ (μ := mu), hzero]; simp
  exact one_ne_zero this

/-- **Headline: the five types.**  Every probability measure on a space with
measurable singletons belongs to exactly one of five mutually exclusive classes,
determined by whether its continuous part vanishes and by whether its atom set is
empty, finite and nonempty, or infinite.  These five classes correspond one for
one to the five types of abelian von Neumann algebras listed in the book:

1. purely atomic with finitely many atoms — `ℓ∞({1,…,n})`;
2. purely atomic with infinitely many atoms — `ℓ∞(ℕ)`;
3. purely continuous — `L∞([0,1])`;
4. continuous plus finitely many atoms — `L∞([0,1] ∪ {1,…,n})`;
5. continuous plus infinitely many atoms — `L∞([0,1] ∪ ℕ)`.

The combination "no continuous part and no atoms" is excluded by
`not_continuousPart_zero_and_atoms_empty`. -/
theorem probability_measure_five_types (mu : Measure X) [IsProbabilityMeasure mu] :
    (continuousPart mu = 0 ∧ (atoms mu).Finite ∧ (atoms mu).Nonempty) ∨
    (continuousPart mu = 0 ∧ (atoms mu).Infinite) ∨
    (continuousPart mu ≠ 0 ∧ atoms mu = ∅) ∨
    (continuousPart mu ≠ 0 ∧ (atoms mu).Finite ∧ (atoms mu).Nonempty) ∨
    (continuousPart mu ≠ 0 ∧ (atoms mu).Infinite) := by
  by_cases hc : continuousPart mu = 0
  · rcases Set.finite_or_infinite (atoms mu) with hfin | hinf
    · have hne : (atoms mu).Nonempty := by
        rcases Set.eq_empty_or_nonempty (atoms mu) with he | hne
        · exact absurd ⟨hc, he⟩ (not_continuousPart_zero_and_atoms_empty mu)
        · exact hne
      exact Or.inl ⟨hc, hfin, hne⟩
    · exact Or.inr (Or.inl ⟨hc, hinf⟩)
  · rcases Set.eq_empty_or_nonempty (atoms mu) with he | hne
    · exact Or.inr (Or.inr (Or.inl ⟨hc, he⟩))
    · rcases Set.finite_or_infinite (atoms mu) with hfin | hinf
      · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨hc, hfin, hne⟩)))
      · exact Or.inr (Or.inr (Or.inr (Or.inr ⟨hc, hinf⟩)))

omit [MeasurableSingletonClass X] in
/-- The five classes are mutually exclusive: no probability measure satisfies two
of the descriptions in `probability_measure_five_types`. -/
theorem five_types_pairwise_exclusive (mu : Measure X) :
    ¬ ((atoms mu).Finite ∧ (atoms mu).Infinite) ∧
      ¬ ((atoms mu = ∅) ∧ (atoms mu).Nonempty) ∧
      ¬ ((atoms mu = ∅) ∧ (atoms mu).Infinite) ∧
      ¬ (continuousPart mu = 0 ∧ continuousPart mu ≠ 0) := by
  refine ⟨fun h => h.2 h.1, fun h => ?_, fun h => ?_, fun h => h.2 h.1⟩
  · obtain ⟨x, hx⟩ := h.2
    rw [h.1] at hx
    exact hx
  · exact h.2 (by rw [h.1]; exact Set.finite_empty)

end BookProof.ChapterAtomicDecomposition
