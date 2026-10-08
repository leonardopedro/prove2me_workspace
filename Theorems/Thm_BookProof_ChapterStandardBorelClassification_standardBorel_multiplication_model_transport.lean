-- Generated from ChapterStandardBorelClassification.lean — theorem BookProof.ChapterStandardBorelClassification.standardBorel_multiplication_model_transport
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterAtomicDiagonalModel
import Definitions.Def_ChapterAbelianClassificationList
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterUnitaryTransport
open BookProof.ChapterStandardBorelClassification


noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianClassificationList

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y] (e : X ≃ᵐ Y)
  (mu : Measure X)
variable {X : Type*} [MeasurableSpace X] [StandardBorelSpace X]
  (mu : Measure X) [IsProbabilityMeasure mu]

theorem BookProof.ChapterStandardBorelClassification.standardBorel_multiplication_model_transport :
    (Countable X ∧ ∃ B : HilbertBasis (atomSet mu) ℂ (Lp ℂ 2 mu),
        ∀ (g : X → ℂ) (hg : MemLp g ⊤ mu) (a : atomSet mu),
          multOp g hg (B a) = g (a : X) • B a) ∨
      (∃ e : X ≃ᵐ ℝ, IsProbabilityMeasure (Measure.map e mu) ∧
        ∃ U : Lp ℂ 2 (Measure.map e mu) ≃ₗᵢ[ℂ] Lp ℂ 2 mu,
          ∀ (g : ℝ → ℂ) (hg : MemLp g ⊤ (Measure.map e mu))
            (v : Lp ℂ 2 (Measure.map e mu)),
            U (multOp g hg v)
              = multOp (fun x => g (e x)) (memLp_top_comp_equiv e mu hg) (U v)) := by sorry
