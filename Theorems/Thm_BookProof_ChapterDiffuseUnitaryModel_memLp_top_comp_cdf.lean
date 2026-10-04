-- Generated from ChapterDiffuseUnitaryModel.lean — theorem BookProof.ChapterDiffuseUnitaryModel.memLp_top_comp_cdf
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterDiffuseUnitaryModel
import Definitions.Def_ChapterA4
open BookProof.ChapterDiffuseUnitaryModel

variable (mu : Measure ℝ) [IsProbabilityMeasure mu] [NullSingletonClass mu]


noncomputable section

open MeasureTheory ProbabilityTheory Filter



theorem BookProof.ChapterDiffuseUnitaryModel.memLp_top_comp_cdf {g : ℝ → ℂ}
    (hg : MemLp g ⊤ (volume.restrict (Set.Icc (0 : ℝ) 1))) :
    MemLp (fun x => g (cdf mu x)) ⊤ mu := by sorry
