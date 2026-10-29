-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.opL2_potentialOp_apply_eq_mulL2
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterWaveBoundedPotential
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]


private lemma hasTemperateGrowth_ofReal {W : V → ℝ} (hW : Function.HasTemperateGrowth W) :
    Function.HasTemperateGrowth (fun x => (W x : ℂ)) := by
  exact Function.HasTemperateGrowth.comp Complex.ofRealCLM.hasTemperateGrowth hW

@[simp] private theorem potentialOp_apply {W : V → ℝ} (hW : Function.HasTemperateGrowth W)
    (f : 𝓢(V, ℂ)) (x : V) : potentialOp W f x = (W x : ℂ) * f x := by
  simp [potentialOp, SchwartzMap.smulLeftCLM_apply_apply (hasTemperateGrowth_ofReal hW)]

set_option maxHeartbeats 1000000 in

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
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
