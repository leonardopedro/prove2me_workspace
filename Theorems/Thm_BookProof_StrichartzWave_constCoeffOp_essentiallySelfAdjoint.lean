-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.constCoeffOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavineCore
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv


 = 0 := by
    rw [← MeasureTheory.Lp.norm_fourier_eq u, hg0, norm_zero]
  exact norm_eq_zero.mp hnorm

theorem BookProof.StrichartzWave.constCoeffOp_essentiallySelfAdjoint (c : ι → ℝ) (w : ι → V) (κ : ℝ) : := by sorry
