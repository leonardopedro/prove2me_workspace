-- Generated from ChapterMollifierL2.lean — theorem BookProof.MollifierL2.tendsto_translate_Lp
import Mathlib
import Definitions.Def_ChapterMollifierL2
open BookProof.MollifierL2



open MeasureTheory Filter ENNReal Pointwise
open scoped NNReal Topology

noncomputable section

variable {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] {μ : Measure E} [μ.IsAddHaarMeasure]
  [NormedAddCommGroup F] [NormedSpace ℝ F]


theorem BookProof.MollifierL2.tendsto_translate_Lp {p : ℝ≥0∞} (hp0 : p ≠ 0) (hp : p ≠ ⊤) (hp1 : 1 ≤ p) {f : E → F}
    (hf : MemLp f p μ) :
    Tendsto (fun a : E => eLpNorm (fun x => f (x - a) - f x) p μ) (𝓝 0) (𝓝 0) := by sorry
