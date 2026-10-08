-- Generated from ChapterWaveUnboundedPotential.lean — theorem BookProof.StrichartzWave.constCoeffOp_eq_multiplierOp
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {ι : Type*} [Fintype ι]

theorem BookProof.StrichartzWave.constCoeffOp_eq_multiplierOp (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    constCoeffOp c w κ = multiplierOp (symbolFn c w κ) := by sorry
