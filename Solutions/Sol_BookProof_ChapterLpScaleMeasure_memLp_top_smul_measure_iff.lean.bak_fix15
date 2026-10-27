-- Generated from ChapterLpScaleMeasure.lean — solution of BookProof.ChapterLpScaleMeasure.memLp_top_smul_measure_iff
import Mathlib
import Definitions.Def_ChapterLpScaleMeasure
open BookProof.ChapterLpScaleMeasure



noncomputable section

open MeasureTheory ENNReal


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}

set_option maxHeartbeats 1000000 in
theorem solution (hc0 : c ≠ 0) {f : α → ℂ} :
    MemLp f ⊤ (c • nu) ↔ MemLp f ⊤ nu := by

  constructor
  · rintro ⟨hm, hlt⟩
    refine ⟨(aestronglyMeasurable_smul_measure_iff hc0).1 hm, ?_⟩
    rwa [eLpNorm_exponent_top, eLpNormEssSup_ennreal_smul_measure hc0] at hlt
  · rintro ⟨hm, hlt⟩
    refine ⟨(aestronglyMeasurable_smul_measure_iff hc0).2 hm, ?_⟩
    rwa [eLpNorm_exponent_top, eLpNormEssSup_ennreal_smul_measure hc0]
