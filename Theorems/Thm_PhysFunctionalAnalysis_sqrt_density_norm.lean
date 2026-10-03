-- Generated from PhysFunctionalAnalysis.lean — theorem PhysFunctionalAnalysis.sqrt_density_norm
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
import Definitions.Def_ChapterA4
open PhysFunctionalAnalysis


open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

theorem PhysFunctionalAnalysis.sqrt_density_norm {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (p : α → ℝ) (hp : Integrable p μ) (hp0 : 0 ≤ᵐ[μ] p)
    (hp1 : ∫ x, p x ∂μ = 1) :
    ‖(sqrt_density_memLp μ p hp hp0).toLp _‖ = 1 := by sorry
