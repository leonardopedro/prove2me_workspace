-- Generated from ChapterDiffuseCdfModel.lean — theorem BookProof.ChapterDiffuseCdfModel.continuous_cdf_of_noAtoms
import Mathlib
import Definitions.Def_ChapterDiffuseCdfModel
open BookProof.ChapterDiffuseCdfModel


noncomputable section

open MeasureTheory ProbabilityTheory Filter


variable (mu : Measure ℝ)


theorem BookProof.ChapterDiffuseCdfModel.continuous_cdf_of_noAtoms [IsProbabilityMeasure mu] [NullSingletonClass mu] :
    Continuous (cdf mu) := by sorry
