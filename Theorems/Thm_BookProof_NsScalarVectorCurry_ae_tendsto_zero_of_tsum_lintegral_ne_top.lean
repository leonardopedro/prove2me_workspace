-- Generated from ChapterNsScalarVectorCurry.lean — theorem BookProof.NsScalarVectorCurry.ae_tendsto_zero_of_tsum_lintegral_ne_top
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
open BookProof.NsScalarVectorCurry

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]


open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section


theorem BookProof.NsScalarVectorCurry.ae_tendsto_zero_of_tsum_lintegral_ne_top {X : Type*} [MeasurableSpace X] {ρ : Measure X}
    (ψ : ℕ → X → ℝ≥0∞) (hmeas : ∀ k, AEMeasurable (ψ k) ρ)
    (h : ∑' k, ∫⁻ x, ψ k x ∂ρ ≠ ∞) :
    ∀ᵐ x ∂ρ, Filter.Tendsto (fun k => ψ k x) Filter.atTop (nhds 0) := by sorry
