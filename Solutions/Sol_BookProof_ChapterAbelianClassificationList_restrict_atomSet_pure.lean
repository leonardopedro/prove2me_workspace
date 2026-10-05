-- Generated from ChapterAbelianClassificationList.lean — solution of BookProof.ChapterAbelianClassificationList.restrict_atomSet_pure
import Mathlib
import Definitions.Def_ChapterAbelianClassificationList
import Theorems.Thm_BookProof_ChapterAbelianClassificationList_atomSet_restrict_atomSet
import Theorems.Thm_BookProof_ChapterMeasureAtomicDiffuse_measurableSet_atomSet
open BookProof.ChapterAbelianClassificationList



noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterDiffuseUnitaryModel BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpRestrictSplit BookProof.ChapterLpScaleMeasure

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure α) [IsFiniteMeasure mu] :
    (mu.restrict (atomSet mu)) (atomSet (mu.restrict (atomSet mu)))ᶜ = 0 := by

  rw [atomSet_restrict_atomSet mu,
    Measure.restrict_apply (measurableSet_atomSet mu).compl]
  simp
