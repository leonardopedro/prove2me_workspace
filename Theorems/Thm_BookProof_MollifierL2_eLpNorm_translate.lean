-- Generated from ChapterMollifierL2.lean — theorem BookProof.MollifierL2.eLpNorm_translate
import Mathlib
import Definitions.Def_ChapterMollifierL2
open BookProof.MollifierL2

variable {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] {μ : Measure E} [μ.IsAddHaarMeasure]
  [NormedAddCommGroup F] [NormedSpace ℝ F]



open MeasureTheory Filter ENNReal Pointwise
open scoped NNReal Topology

noncomputable section


theorem BookProof.MollifierL2.eLpNorm_translate {p : ℝ≥0∞} {f : E → F} (hf : AEStronglyMeasurable f μ) (a : E) :
    eLpNorm (fun x => f (x - a)) p μ = eLpNorm f p μ := by sorry
