-- Generated from ChapterDiffuseCdfModel.lean — theorem BookProof.ChapterDiffuseCdfModel.map_cdf_eq_volume_Icc
import Mathlib
import Definitions.Def_ChapterDiffuseCdfModel
open BookProof.ChapterDiffuseCdfModel


noncomputable section

open MeasureTheory ProbabilityTheory Filter


variable (mu : Measure ℝ)


theorem BookProof.ChapterDiffuseCdfModel.map_cdf_eq_volume_Icc [IsProbabilityMeasure mu] [NullSingletonClass mu] :
    Measure.map (cdf mu) mu = volume.restrict (Set.Icc (0 : ℝ) 1) := by sorry
