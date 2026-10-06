-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.opL2_potentialOp_apply_eq_mulL2
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Theorems.Thm_BookProof_StrichartzWave_mulL2_coeFn
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
    (hmem : MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure V)) (f : 𝓢(V, ℂ)) :
    opL2 (potentialOp W) (schwartzEquiv V f)
      = mulL2 (hmem.toLp _) (f.toLp 2 (volume : Measure V)) := by

  rw [opL2_apply]
  refine MeasureTheory.Lp.ext ?_
  filter_upwards [(potentialOp W f).coeFn_toLp 2 (volume : Measure V),
    mulL2_coeFn (hmem.toLp _) (f.toLp 2 (volume : Measure V)),
    hmem.coeFn_toLp, f.coeFn_toLp 2 (volume : Measure V)] with x h1 h2 h3 h4
  rw [h1, h2, h3, h4]
  simp only [potentialOp_apply hW]
