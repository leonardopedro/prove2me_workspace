-- Generated from PhysFunctionalAnalysis.lean — solution of PhysFunctionalAnalysis.hilbert_classification
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
import Theorems.Thm_PhysFunctionalAnalysis_exists_l2_iso
open PhysFunctionalAnalysis



open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

set_option maxHeartbeats 1000000 in
theorem solution (E F : Type*)
    [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    [TopologicalSpace.SeparableSpace E]
    [NormedAddCommGroup F] [InnerProductSpace ℝ F] [CompleteSpace F]
    [TopologicalSpace.SeparableSpace F]
    (hE : ¬ FiniteDimensional ℝ E) (hF : ¬ FiniteDimensional ℝ F) :
    Nonempty (E ≃ₗᵢ[ℝ] F) := ⟨(exists_l2_iso E hE).some.trans (exists_l2_iso F hF).some.symm⟩
