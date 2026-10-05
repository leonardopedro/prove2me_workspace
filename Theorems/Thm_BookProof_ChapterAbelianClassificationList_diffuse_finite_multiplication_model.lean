-- Generated from ChapterAbelianClassificationList.lean — theorem BookProof.ChapterAbelianClassificationList.diffuse_finite_multiplication_model
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterAtomicDiagonalModel
import Definitions.Def_ChapterDiffuseUnitaryModel
import Definitions.Def_ChapterLpRestrictSplit
import Mathlib
import Definitions.Def_ChapterAbelianClassificationList
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterLpScaleMeasure
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpScaleMeasure
open BookProof.ChapterAbelianClassificationList

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
variable (nu : Measure ℝ) [IsFiniteMeasure nu] [NullSingletonClass nu]


noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterDiffuseUnitaryModel BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpRestrictSplit BookProof.ChapterLpScaleMeasure

theorem BookProof.ChapterAbelianClassificationList.diffuse_finite_multiplication_model (hne : nu Set.univ ≠ 0) :
    ∃ U : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1)) ≃ₗᵢ[ℂ] Lp ℂ 2 nu,
      ∀ (g : ℝ → ℂ) (hg : MemLp g ⊤ (volume.restrict (Set.Icc (0 : ℝ) 1)))
        (u : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1))),
        (U (multOp g hg u) : ℝ → ℂ)
          =ᵐ[nu] fun x => g (cdf (normalized nu) x) * (U u : ℝ → ℂ) x := by sorry
