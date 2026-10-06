-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.opL2_potentialOp_eq_mulL2
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Theorems.Thm_BookProof_StrichartzWave_opL2_potentialOp_apply_eq_mulL2
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution (W : V → ℝ) (hW : Function.HasTemperateGrowth W)
    (hmem : MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure V)) :
    opL2 (potentialOp W)
      = (mulL2 (hmem.toLp _)).toLinearMap ∘ₗ (schwartzDomain V).subtype := by

  refine LinearMap.ext fun v => ?_
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective v
  simpa using opL2_potentialOp_apply_eq_mulL2 W hW hmem f
