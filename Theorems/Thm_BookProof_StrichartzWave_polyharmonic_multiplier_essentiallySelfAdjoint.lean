-- Generated from ChapterWaveUnboundedPotential.lean — theorem BookProof.StrichartzWave.polyharmonic_multiplier_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {ι : Type*} [Fintype ι]

theorem BookProof.StrichartzWave.polyharmonic_multiplier_essentiallySelfAdjoint (k : ℕ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (multiplierOp (fun ξ : V => (4 * Real.pi ^ 2 * ‖ξ‖ ^ 2) ^ k))) := by sorry
