-- Generated from ChapterDiffuseUnitaryModel.lean — theorem BookProof.ChapterDiffuseUnitaryModel.memLp_top_comp_cdf
import Definitions.Def_ChapterDiffuseCdfModel
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterDiffuseUnitaryModel
open BookProof.ChapterDiffuseUnitaryModel

variable (mu : Measure ℝ) [IsProbabilityMeasure mu] [NullSingletonClass mu]


noncomputable section

open MeasureTheory ProbabilityTheory Filter


open BookProof.ChapterDiffuseCdfModel BookProof.ChapterLinftyMultiplication

theorem BookProof.ChapterDiffuseUnitaryModel.memLp_top_comp_cdf {g : ℝ → ℂ}
    (hg : MemLp g ⊤ (volume.restrict (Set.Icc (0 : ℝ) 1))) :
    MemLp (fun x => g (cdf mu x)) ⊤ mu := by sorry
