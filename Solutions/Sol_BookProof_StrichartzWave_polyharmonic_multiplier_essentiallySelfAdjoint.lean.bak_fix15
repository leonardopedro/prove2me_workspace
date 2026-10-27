-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.polyharmonic_multiplier_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Theorems.Thm_BookProof_StrichartzWave_multiplierOp_essentiallySelfAdjoint
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (multiplierOp (fun ξ : V => (4 * Real.pi ^ 2 * ‖ξ‖ ^ 2) ^ k))) := by

  have h : Function.HasTemperateGrowth (fun ξ : V => (4 * Real.pi ^ 2 * ‖ξ‖ ^ 2) ^ k) :=
    (((Function.HasTemperateGrowth.const (4 * Real.pi ^ 2)).mul
      (Function.hasTemperateGrowth_norm_sq (H := V))).pow k)
  exact multiplierOp_essentiallySelfAdjoint _ h
