-- Generated from ChapterMollifierL2.lean — theorem BookProof.MollifierL2.eLpNorm_mollify_sub_le
import Mathlib
import Definitions.Def_ChapterMollifierL2
open BookProof.MollifierL2



open MeasureTheory Filter ENNReal Pointwise
open scoped NNReal Topology

noncomputable section

variable {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] {μ : Measure E} [μ.IsAddHaarMeasure]
  [NormedAddCommGroup F] [NormedSpace ℝ F]


theorem BookProof.MollifierL2.eLpNorm_mollify_sub_le (u : E → ℂ) (hu : StronglyMeasurable u) (ρ : E → ℝ)
    (hρ0 : ∀ y, 0 ≤ ρ y) (hρm : Measurable ρ) (hρ1 : ∫⁻ y, ENNReal.ofReal (ρ y) ∂μ = 1)
    {C : ℝ≥0∞} (hC : ∀ y : E, ρ y ≠ 0 → eLpNorm (fun x => u (x - y) - u x) 2 μ ≤ C) :
    eLpNorm (fun x => ∫ y, ρ y • (u (x - y) - u x) ∂μ) 2 μ ≤ C := by sorry
