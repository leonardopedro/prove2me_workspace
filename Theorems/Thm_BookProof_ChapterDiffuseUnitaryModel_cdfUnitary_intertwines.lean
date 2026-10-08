-- Generated from ChapterDiffuseUnitaryModel.lean — theorem BookProof.ChapterDiffuseUnitaryModel.cdfUnitary_intertwines
import Definitions.Def_ChapterDiffuseCdfModel
import Mathlib
import Definitions.Def_ChapterDiffuseUnitaryModel
import Definitions.Def_ChapterLinftyMultiplication
import Theorems.Thm_BookProof_ChapterDiffuseUnitaryModel_memLp_top_comp_cdf
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterDiffuseUnitaryModel


noncomputable section

open MeasureTheory ProbabilityTheory Filter


open BookProof.ChapterDiffuseCdfModel BookProof.ChapterLinftyMultiplication

variable (mu : Measure ℝ) [IsProbabilityMeasure mu] [NullSingletonClass mu]

theorem BookProof.ChapterDiffuseUnitaryModel.cdfUnitary_intertwines {g : ℝ → ℂ}
    (hg : MemLp g ⊤ (volume.restrict (Set.Icc (0 : ℝ) 1)))
    (u : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1))) :
    cdfUnitary mu (multOp g hg u) =
      multOp (fun x => g (cdf mu x)) (memLp_top_comp_cdf mu hg) (cdfUnitary mu u) := by sorry
