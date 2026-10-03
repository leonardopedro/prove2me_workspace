-- Generated from PhysFunctionalAnalysis.lean — theorem PhysFunctionalAnalysis.hilbert_classification
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
import Definitions.Def_ChapterA4
open PhysFunctionalAnalysis


open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

theorem PhysFunctionalAnalysis.hilbert_classification (E F : Type*)
    [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    [TopologicalSpace.SeparableSpace E]
    [NormedAddCommGroup F] [InnerProductSpace ℝ F] [CompleteSpace F]
    [TopologicalSpace.SeparableSpace F]
    (hE : ¬ FiniteDimensional ℝ E) (hF : ¬ FiniteDimensional ℝ F) :
    Nonempty (E ≃ₗᵢ[ℝ] F) := by sorry
