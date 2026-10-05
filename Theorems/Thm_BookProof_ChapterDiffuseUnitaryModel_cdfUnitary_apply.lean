-- Generated from ChapterDiffuseUnitaryModel.lean — theorem BookProof.ChapterDiffuseUnitaryModel.cdfUnitary_apply
import Definitions.Def_ChapterDiffuseCdfModel
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterDiffuseUnitaryModel
open BookProof.ChapterDiffuseUnitaryModel

variable (mu : Measure ℝ) [IsProbabilityMeasure mu] [NullSingletonClass mu]


noncomputable section

open MeasureTheory ProbabilityTheory Filter


open BookProof.ChapterDiffuseCdfModel BookProof.ChapterLinftyMultiplication

theorem BookProof.ChapterDiffuseUnitaryModel.cdfUnitary_apply (f : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1))) :
    cdfUnitary mu f = cdfComp mu f := by sorry
