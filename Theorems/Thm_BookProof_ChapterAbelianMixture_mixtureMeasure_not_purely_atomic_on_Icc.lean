-- Generated from ChapterAbelianMixture.lean — theorem BookProof.ChapterAbelianMixture.mixtureMeasure_not_purely_atomic_on_Icc
import Mathlib
import Definitions.Def_ChapterAbelianMixture
open BookProof.ChapterAbelianMixture


noncomputable section

open MeasureTheory ENNReal

theorem BookProof.ChapterAbelianMixture.mixtureMeasure_not_purely_atomic_on_Icc :
    0 < mixtureMeasure (Set.Icc (0 : ℝ) 1) ∧
      ∀ x ∈ Set.Icc (0 : ℝ) 1, mixtureMeasure {x} = 0 := by sorry
