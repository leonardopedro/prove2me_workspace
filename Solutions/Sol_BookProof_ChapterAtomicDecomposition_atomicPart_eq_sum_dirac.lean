-- Generated from ChapterAtomicDecomposition.lean — solution of BookProof.ChapterAtomicDecomposition.atomicPart_eq_sum_dirac
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
import Theorems.Thm_BookProof_ChapterAtomicDecomposition_atoms_countable
open BookProof.ChapterAtomicDecomposition



open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [SFinite mu] :
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
