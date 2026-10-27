-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.potentialOp_symmetric
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
import Theorems.Thm_BookProof_StrichartzWave_schwartzEquiv_coe
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (W : V → ℝ) (hW : Function.HasTemperateGrowth W) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 (potentialOp W)) := by

  intro x y
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective x
  obtain ⟨g, rfl⟩ := (schwartzEquiv V).surjective y
  rw [opL2_apply, opL2_apply, schwartzEquiv_coe, schwartzEquiv_coe, inner_toLp_left,
    inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [g.coeFn_toLp 2 (volume : Measure V),
    (potentialOp W g).coeFn_toLp 2 (volume : Measure V)] with x hx hy
  rw [hx, hy]
  simp only [potentialOp_apply hW, map_mul, Complex.conj_ofReal]
  ring
