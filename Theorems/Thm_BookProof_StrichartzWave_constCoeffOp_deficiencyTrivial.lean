-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.constCoeffOp_deficiencyTrivial
import Mathlib
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

onst_mul, h1]
    ring
  rw [← hcomb]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  ring

theorem BookProof.StrichartzWave.constCoeffOp_deficiencyTrivial (c : ι → ℝ) (w : ι → V) (κ : ℝ) {z : ℂ} (hz : := by sorry
