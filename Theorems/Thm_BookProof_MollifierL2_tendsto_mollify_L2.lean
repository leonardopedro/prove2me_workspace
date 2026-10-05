-- Generated from ChapterMollifierL2.lean — theorem BookProof.MollifierL2.tendsto_mollify_L2
import Mathlib
import Definitions.Def_ChapterMollifierL2
open BookProof.MollifierL2

variable {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] {μ : Measure E} [μ.IsAddHaarMeasure]
  [NormedAddCommGroup F] [NormedSpace ℝ F]



open MeasureTheory Filter ENNReal Pointwise
open scoped NNReal Topology

noncomputable section


theorem BookProof.MollifierL2.tendsto_mollify_L2 {ι : Type*} {l : Filter ι} (u : E → ℂ) (hu : StronglyMeasurable u)
    (hu2 : MemLp u 2 μ) (ρ : ι → E → ℝ) (r : ι → ℝ)
    (hρ0 : ∀ i y, 0 ≤ ρ i y) (hρm : ∀ i, Measurable (ρ i))
    (hρ1 : ∀ i, ∫⁻ y, ENNReal.ofReal (ρ i y) ∂μ = 1)
    (hsupp : ∀ i, ∀ y : E, ρ i y ≠ 0 → ‖y‖ < r i) (hr : Tendsto r l (𝓝 0)) :
    Tendsto (fun i => eLpNorm (fun x => ∫ y, ρ i y • (u (x - y) - u x) ∂μ) 2 μ) l (𝓝 0) := by sorry
