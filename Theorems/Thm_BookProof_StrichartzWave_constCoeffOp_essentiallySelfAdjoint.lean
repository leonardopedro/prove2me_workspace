-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.constCoeffOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.StrichartzWave










open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

theorem BookProof.StrichartzWave.constCoeffOp_essentiallySelfAdjoint (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (constCoeffOp c w κ)) := by sorry
