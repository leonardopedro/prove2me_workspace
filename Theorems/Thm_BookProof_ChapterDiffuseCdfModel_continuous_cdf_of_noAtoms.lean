-- Generated from ChapterDiffuseCdfModel.lean — theorem BookProof.ChapterDiffuseCdfModel.continuous_cdf_of_noAtoms
import Mathlib
import Definitions.Def_ChapterDiffuseCdfModel
open BookProof.ChapterDiffuseCdfModel

variable (mu : Measure ℝ)


noncomputable section

open MeasureTheory ProbabilityTheory Filter



theorem BookProof.ChapterDiffuseCdfModel.continuous_cdf_of_noAtoms [IsProbabilityMeasure mu] [NullSingletonClass mu] :
    Continuous (cdf mu) := by sorry
