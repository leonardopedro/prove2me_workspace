-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.wave_symmetric
import Mathlib
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.StrichartzWave










open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

theorem BookProof.StrichartzWave.wave_symmetric (n : ℕ) (κ : ℝ) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain (SpaceTime n)) (opL2 (waveOp n κ)) := by sorry
