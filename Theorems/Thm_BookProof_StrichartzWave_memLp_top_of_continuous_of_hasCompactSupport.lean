-- Generated from ChapterWaveUnboundedPotential.lean — theorem BookProof.StrichartzWave.memLp_top_of_continuous_of_hasCompactSupport
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal


theorem BookProof.StrichartzWave.memLp_top_of_continuous_of_hasCompactSupport {W : V → ℝ} (hW : Continuous W)
    (hWc : HasCompactSupport W) :
    MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure V) := by sorry
