-- Generated from ChapterMollifierL2.lean — solution of BookProof.MollifierL2.eLpNorm_translate
import Mathlib
import Definitions.Def_ChapterMollifierL2
open BookProof.MollifierL2




open MeasureTheory Filter ENNReal Pointwise
open scoped NNReal Topology

noncomputable section

variable {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] {μ : Measure E} [μ.IsAddHaarMeasure]
  [NormedAddCommGroup F] [NormedSpace ℝ F]

variable {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] {μ : Measure E} [μ.IsAddHaarMeasure]
  [NormedAddCommGroup F] [NormedSpace ℝ F]

set_option maxHeartbeats 1000000 in
theorem solution {p : ℝ≥0∞} {f : E → F} (hf : AEStronglyMeasurable f μ) (a : E) :
    eLpNorm (fun x => f (x - a)) p μ = eLpNorm f p μ := eLpNorm_comp_measurePreserving hf (measurePreserving_sub_right μ a)
