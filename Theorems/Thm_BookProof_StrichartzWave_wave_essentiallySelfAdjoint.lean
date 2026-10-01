-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.wave_essentiallySelfAdjoint
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

Lavine.SymmetricOn (schwartzDomain (SpaceTime n)) (opL2 (waveOp n κ)) :=
  constCoeffOp_symmetric _ _ _

theorem BookProof.StrichartzWave.wave_essentiallySelfAdjoint (n : ℕ) (κ : ℝ) : := by sorry
