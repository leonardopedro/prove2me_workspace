-- Generated from ChapterSeparableL2Model.lean — theorem BookProof.ChapterSeparableL2Model.separable_Lp_realizes_standard_type
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterA4
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterSeparableL2Model

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [MeasurableSpace Y]
  [BorelSpace Y] (D : Set C(Y, ℂ)) [Countable D]
variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsProbabilityMeasure mu] [mu.WeaklyRegular]


noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterStandardBorelClassification

theorem BookProof.ChapterSeparableL2Model.separable_Lp_realizes_standard_type [SeparableSpace (Lp ℂ 2 mu)] :
    ∃ (Z : Type u) (_ : MeasurableSpace Z) (_ : StandardBorelSpace Z)
      (_ : MeasurableSingletonClass Z) (Phi : Y → Z) (hPhi : Measurable Phi),
      ∃ _ : IsProbabilityMeasure (Measure.map Phi mu),
        RealizesStandardType (Measure.map Phi mu) ∧
        ∃ U : Lp ℂ 2 (Measure.map Phi mu) ≃ₗᵢ[ℂ] Lp ℂ 2 mu,
          ∀ (g : Z → ℂ) (hg : MemLp g ⊤ (Measure.map Phi mu))
            (v : Lp ℂ 2 (Measure.map Phi mu)),
            U (multOp g hg v)
              = multOp (fun y => g (Phi y)) (hg.comp_measurePreserving ⟨hPhi, rfl⟩) (U v) := by sorry
