-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.polynomialPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Theorems.Thm_BookProof_StrichartzWave_potentialOp_essentiallySelfAdjoint
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (potentialOp (fun x : V => ‖x‖ ^ (2 * k)))) := by

  have h : Function.HasTemperateGrowth (fun x : V => ‖x‖ ^ (2 * k)) := by
    have := (Function.hasTemperateGrowth_norm_sq (H := V)).pow k
    simp only [pow_mul]
    exact this
  exact potentialOp_essentiallySelfAdjoint _ h
