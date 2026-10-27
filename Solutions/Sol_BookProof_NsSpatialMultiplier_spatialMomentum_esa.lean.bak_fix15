-- Generated from ChapterNsSpatialMomentumMultiplier.lean — solution of BookProof.NsSpatialMultiplier.spatialMomentum_esa
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Theorems.Thm_BookProof_FourierMultiplierEsa_firstOrderOp_essentiallySelfAdjoint
open BookProof.NsSpatialMultiplier




open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]
variable (V) in

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℝ) (w : ι → V) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (firstOrderOp c w)) := firstOrderOp_essentiallySelfAdjoint c w
