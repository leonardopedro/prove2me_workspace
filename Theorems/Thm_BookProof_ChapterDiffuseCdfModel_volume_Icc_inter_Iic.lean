-- Generated from ChapterDiffuseCdfModel.lean — theorem BookProof.ChapterDiffuseCdfModel.volume_Icc_inter_Iic
import Mathlib
import Definitions.Def_ChapterDiffuseCdfModel
open BookProof.ChapterDiffuseCdfModel


noncomputable section

open MeasureTheory ProbabilityTheory Filter


variable (mu : Measure ℝ)


theorem BookProof.ChapterDiffuseCdfModel.volume_Icc_inter_Iic {t : ℝ} (ht1 : t ≤ 1) :
    (volume.restrict (Set.Icc (0 : ℝ) 1)) (Set.Iic t) = ENNReal.ofReal t := by sorry
