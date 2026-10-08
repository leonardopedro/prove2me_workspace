-- Generated from ChapterWaveUnboundedPotential.lean — theorem BookProof.StrichartzWave.multiplierOp_deficiencyTrivial
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


theorem BookProof.StrichartzWave.multiplierOp_deficiencyTrivial (m : V → ℝ) (hm : Function.HasTemperateGrowth m)
    {z : ℂ} (hz : z.im ≠ 0) :
    BookProof.FarisLavine.DeficiencyTrivialAt (schwartzDomain V) (opL2 (multiplierOp m)) z := by sorry
