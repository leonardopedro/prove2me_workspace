-- Generated from ChapterLpScaleMeasure.lean — theorem BookProof.ChapterLpScaleMeasure.isProbabilityMeasure_inv_smul
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLpScaleMeasure
open BookProof.ChapterLpScaleMeasure


noncomputable section

open MeasureTheory ENNReal


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}


theorem BookProof.ChapterLpScaleMeasure.isProbabilityMeasure_inv_smul [IsFiniteMeasure nu] (hne : nu Set.univ ≠ 0) :
    IsProbabilityMeasure ((nu Set.univ)⁻¹ • nu) := by sorry
