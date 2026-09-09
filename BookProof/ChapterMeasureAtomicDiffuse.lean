import Mathlib
import BookProof.ChapterAbelianDirectSum

/-!
# Atomic and diffuse parts of a measure (plan GAP-2, the classification bookkeeping)

`ChapterAbelianDirectSum` shows that every abelian algebra of operators on a complex
Hilbert space is a direct sum of multiplication algebras `L∞(μₓ)` on `L²(μₓ)`, for
Borel probability measures `μₓ`.  The manuscript's classification list is phrased in
terms of the *type* of each measure — purely atomic (`Iₙ` or `ℓ∞(ℕ)`), diffuse
(`L∞[0,1]`) or a mixture of the two.  This module supplies the measure-theoretic
bookkeeping that sorts a summand into those classes:

* `atomSet` — the set of atoms `{x : μ{x} ≠ 0}`;
* `countable_atomSet` — it is **countable** (the singletons are disjoint and the
  measure is finite);
* `measurableSet_atomSet`, `restrict_atomSet_add_restrict_compl` — the induced
  splitting `μ = μ|atoms + μ|non-atoms`;
* `noAtoms_restrict_compl_atomSet` — the second summand is **diffuse** (it has no
  atoms at all);
* `restrict_atomSet_eq_sum_dirac` — the first summand is **purely atomic**: a
  countable sum of point masses `μ{x} · δₓ`;
* HEADLINE `exists_atomic_diffuse_decomposition` — every finite measure (on a space
  whose singletons are measurable) is the sum of a countable sum of point masses and
  an atomless measure;
* `abelian_multiplication_model_atomic_diffuse` — the two statements combined: every
  abelian algebra of operators is a direct sum of multiplication algebras whose
  measures each split into a purely atomic and a diffuse part.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory Complex

namespace BookProof.ChapterMeasureAtomicDiffuse

section AtomSet

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)

/-- **The set of atoms** of a measure. -/
def atomSet : Set α := {x : α | mu {x} ≠ 0}

omit [MeasurableSingletonClass α] in
theorem mem_atomSet_iff (x : α) : x ∈ atomSet mu ↔ mu {x} ≠ 0 := Iff.rfl

omit [MeasurableSingletonClass α] in
theorem measure_singleton_eq_zero_of_notMem_atomSet {x : α} (hx : x ∉ atomSet mu) :
    mu {x} = 0 := by
  simpa [atomSet] using hx

/-- **The atoms of a finite measure are countable**: the singletons are pairwise
disjoint, so only countably many can have positive measure. -/
theorem countable_atomSet [IsFiniteMeasure mu] : (atomSet mu).Countable := by
  have h := Measure.countable_meas_pos_of_disjoint_iUnion (μ := mu)
    (As := fun x : α => ({x} : Set α)) (fun x => measurableSet_singleton x)
    (by intro i j hij; simpa [Function.onFun] using hij)
  simpa [atomSet, pos_iff_ne_zero] using h

theorem measurableSet_atomSet [IsFiniteMeasure mu] : MeasurableSet (atomSet mu) :=
  (countable_atomSet mu).measurableSet

/-- The splitting of the measure into its atomic and its diffuse part. -/
theorem restrict_atomSet_add_restrict_compl [IsFiniteMeasure mu] :
    mu.restrict (atomSet mu) + mu.restrict (atomSet mu)ᶜ = mu :=
  Measure.restrict_add_restrict_compl (measurableSet_atomSet mu)

/-- **The complementary part is diffuse**: off the atoms the measure has no atoms. -/
instance noAtoms_restrict_compl_atomSet : NoAtoms (mu.restrict (atomSet mu)ᶜ) := by
  constructor
  intro x
  by_cases hx : x ∈ atomSet mu
  · rw [Measure.restrict_apply (measurableSet_singleton x)]
    have hempty : ({x} : Set α) ∩ (atomSet mu)ᶜ = ∅ := by
      ext y
      simp only [Set.mem_inter_iff, Set.mem_singleton_iff, Set.mem_compl_iff,
        Set.mem_empty_iff_false, iff_false, not_and, not_not]
      rintro rfl
      exact hx
    simp [hempty]
  · refine le_antisymm ?_ (zero_le _)
    exact le_trans (Measure.restrict_apply_le _ _)
      (le_of_eq (measure_singleton_eq_zero_of_notMem_atomSet mu hx))

/-- **The atomic part is a countable sum of point masses.** -/
theorem restrict_eq_sum_dirac {A : Set α} (hc : A.Countable) :
    mu.restrict A = Measure.sum (fun x : A => mu {(x : α)} • Measure.dirac (x : α)) := by
  ext s hs
  rw [Measure.restrict_apply hs, Measure.sum_apply _ hs]
  have hunion : s ∩ A = ⋃ x ∈ A, ({x} ∩ s) := by
    ext y
    simp only [Set.mem_inter_iff, Set.mem_iUnion, Set.mem_singleton_iff, exists_prop]
    constructor
    · rintro ⟨hys, hyA⟩
      exact ⟨y, hyA, rfl, hys⟩
    · rintro ⟨x, hxA, rfl, hys⟩
      exact ⟨hys, hxA⟩
  rw [hunion, measure_biUnion hc (fun x _ y _ hxy => by
      simp only [Function.onFun]
      exact Set.disjoint_of_subset Set.inter_subset_left Set.inter_subset_left
        (by simpa using hxy))
    (fun x _ => (measurableSet_singleton x).inter hs)]
  refine tsum_congr fun x => ?_
  by_cases hx : (x : α) ∈ s
  · simp [hx, Set.inter_eq_left.2 (Set.singleton_subset_iff.2 hx)]
  · have hempty : ({(x : α)} : Set α) ∩ s = ∅ := by
      ext y
      simp only [Set.mem_inter_iff, Set.mem_singleton_iff, Set.mem_empty_iff_false,
        iff_false, not_and]
      rintro rfl
      exact hx
    simp [hx, hempty]

theorem restrict_atomSet_eq_sum_dirac [IsFiniteMeasure mu] :
    mu.restrict (atomSet mu)
      = Measure.sum (fun x : atomSet mu => mu {(x : α)} • Measure.dirac (x : α)) :=
  restrict_eq_sum_dirac mu (countable_atomSet mu)

/-- **HEADLINE (atomic ⊕ diffuse decomposition).**  Every finite measure on a space
whose singletons are measurable is the sum of a *purely atomic* measure — a countable
sum of point masses, carried by the countable set of atoms — and a *diffuse*
(atomless) measure.  This is the classification of a single summand of the abelian
multiplication model into the manuscript's atomic, diffuse and mixed types. -/
theorem exists_atomic_diffuse_decomposition [IsFiniteMeasure mu] :
    ∃ (A : Set α) (mua mud : Measure α), A.Countable ∧ MeasurableSet A ∧
      mu = mua + mud ∧
      mua = Measure.sum (fun x : A => mu {(x : α)} • Measure.dirac (x : α)) ∧
      mua Aᶜ = 0 ∧ NoAtoms mud := by
  refine ⟨atomSet mu, mu.restrict (atomSet mu), mu.restrict (atomSet mu)ᶜ,
    countable_atomSet mu, measurableSet_atomSet mu,
    (restrict_atomSet_add_restrict_compl mu).symm, restrict_atomSet_eq_sum_dirac mu, ?_,
    noAtoms_restrict_compl_atomSet mu⟩
  rw [Measure.restrict_apply (measurableSet_atomSet mu).compl]
  simp

end AtomSet

/-! ## The abelian model with its summands classified -/

section Model

open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterAbelianDirectSum

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- **The abelian multiplication model with its summands classified.**  Every abelian
algebra of operators on a complex Hilbert space — a unital `*`-representation `π` of
`C(X, ℂ)` — is a direct sum of multiplication algebras on `L²(μₓ)`, and each `μₓ`
splits as a purely atomic measure (a countable sum of point masses) plus a diffuse
one.  That is the manuscript's three-way alternative — atomic, diffuse, mixed — for
every summand of the decomposition. -/
theorem abelian_multiplication_model_atomic_diffuse
    (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure X) (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (g : C(X, ℂ)) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) g u) = pi g (V x u)) ∧
      (∀ x : S, ∃ (A : Set X) (mua mud : Measure X), A.Countable ∧ MeasurableSet A ∧
        mu x = mua + mud ∧
        mua = Measure.sum (fun y : A => (mu x) {(y : X)} • Measure.dirac (y : X)) ∧
        mua Aᶜ = 0 ∧ NoAtoms mud) := by
  obtain ⟨S, mu, V, hprob, hsum, hint⟩ := abelian_multiplication_model_general pi
  refine ⟨S, mu, V, hprob, hsum, hint, fun x => ?_⟩
  haveI : IsProbabilityMeasure (mu x) := hprob x
  exact exists_atomic_diffuse_decomposition (mu x)

end Model

end BookProof.ChapterMeasureAtomicDiffuse

end
