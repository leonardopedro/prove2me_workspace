-- Generated from PhysFunctionalAnalysis.lean — theorem PhysFunctionalAnalysis.exists_l2_iso
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
import Definitions.Def_ChapterA4
open PhysFunctionalAnalysis


open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

theorem PhysFunctionalAnalysis.exists_l2_iso (E : Type*)
    [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    [TopologicalSpace.SeparableSpace E] (hE : ¬ FiniteDimensional ℝ E) :
    Nonempty (E ≃ₗᵢ[ℝ] ℓ²(ℕ, ℝ)) := by sorry
