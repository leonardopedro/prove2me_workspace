-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.memLp_top_of_continuous_of_hasCompactSupport
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution {W : V → ℝ} (hW : Continuous W)
    (hWc : HasCompactSupport W) :
    MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure V) := by

  have hc : Continuous (fun x => (W x : ℂ)) := Complex.continuous_ofReal.comp hW
  have hcs : HasCompactSupport (fun x => (W x : ℂ)) := by
    exact hWc.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)
  exact hc.memLp_top_of_hasCompactSupport hcs (volume : Measure V)
