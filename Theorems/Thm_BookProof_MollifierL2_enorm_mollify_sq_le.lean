-- Generated from ChapterMollifierL2.lean — theorem BookProof.MollifierL2.enorm_mollify_sq_le
import Mathlib
import Definitions.Def_ChapterMollifierL2
open BookProof.MollifierL2

variable {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] {μ : Measure E} [μ.IsAddHaarMeasure]
  [NormedAddCommGroup F] [NormedSpace ℝ F]



open MeasureTheory Filter ENNReal Pointwise
open scoped NNReal Topology

noncomputable section


theorem BookProof.MollifierL2.enorm_mollify_sq_le (u : E → ℂ) (ρ : E → ℝ) (hρ0 : ∀ y, 0 ≤ ρ y) (hρm : Measurable ρ)
    (hρ1 : ∫⁻ y, ENNReal.ofReal (ρ y) ∂μ = 1) (hu : StronglyMeasurable u) (x : E) :
    ‖∫ y, ρ y • (u (x - y) - u x) ∂μ‖ₑ ^ (2:ℝ)
      ≤ ∫⁻ y, ENNReal.ofReal (ρ y) * ‖u (x - y) - u x‖ₑ ^ (2:ℝ) ∂μ := by sorry
