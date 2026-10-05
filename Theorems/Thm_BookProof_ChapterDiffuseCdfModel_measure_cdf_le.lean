-- Generated from ChapterDiffuseCdfModel.lean — theorem BookProof.ChapterDiffuseCdfModel.measure_cdf_le
import Mathlib
import Definitions.Def_ChapterDiffuseCdfModel
open BookProof.ChapterDiffuseCdfModel

variable (mu : Measure ℝ)


noncomputable section

open MeasureTheory ProbabilityTheory Filter



theorem BookProof.ChapterDiffuseCdfModel.measure_cdf_le [IsProbabilityMeasure mu] [NullSingletonClass mu] {t : ℝ} (ht0 : 0 ≤ t)
    (ht1 : t < 1) : mu {x | cdf mu x ≤ t} = ENNReal.ofReal t := by sorry
