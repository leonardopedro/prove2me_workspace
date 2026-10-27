-- Generated from ChapterAbelianClassificationList.lean — solution of BookProof.ChapterAbelianClassificationList.atomSet_restrict_atomSet
import Mathlib
import Definitions.Def_ChapterAbelianClassificationList
import Theorems.Thm_BookProof_ChapterMeasureAtomicDiffuse_mem_atomSet_iff
open BookProof.ChapterAbelianClassificationList



noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterDiffuseUnitaryModel BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpRestrictSplit BookProof.ChapterLpScaleMeasure

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure α) [IsFiniteMeasure mu] :
    atomSet (mu.restrict (atomSet mu)) = atomSet mu := by

  ext x
  simp only [mem_atomSet_iff, Measure.restrict_apply (measurableSet_singleton x)]
  by_cases hx : x ∈ atomSet mu
  · have hxx : ({x} : Set α) ∩ atomSet mu = {x} :=
      Set.inter_eq_left.2 (Set.singleton_subset_iff.2 hx)
    simp [hxx, hx] at *
  · have h0 : mu {x} = 0 := by simpa [atomSet] using hx
    have hzero : mu ({x} ∩ atomSet mu) = 0 :=
      measure_mono_null Set.inter_subset_left h0
    rw [hzero]
    simp [h0]
