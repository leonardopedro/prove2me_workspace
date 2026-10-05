-- Generated from ChapterDiffuseUnitaryModel.lean — solution of BookProof.ChapterDiffuseUnitaryModel.cdfUnitary_apply
import Mathlib
import Definitions.Def_ChapterDiffuseUnitaryModel
open BookProof.ChapterDiffuseUnitaryModel



noncomputable section

open MeasureTheory ProbabilityTheory Filter


open BookProof.ChapterDiffuseCdfModel BookProof.ChapterLinftyMultiplication

variable (mu : Measure ℝ) [IsProbabilityMeasure mu] [NullSingletonClass mu]

set_option maxHeartbeats 1000000 in
theorem solution (f : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1))) :
    cdfUnitary mu f = cdfComp mu f := rfl
