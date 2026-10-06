-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.posOp_symmetric
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
import Theorems.Thm_BookProof_StrichartzWave_schwartzEquiv_coe
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (b : V) :
    SymmetricOn (schwartzDomain V) (opL2 (posOp b)) := by

  intro x y
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective x
  obtain ⟨g, rfl⟩ := (schwartzEquiv V).surjective y
  rw [opL2_apply, opL2_apply, schwartzEquiv_coe, schwartzEquiv_coe,
    inner_toLp_left, inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [(posOp b g).coeFn_toLp 2 (volume : Measure V),
    g.coeFn_toLp 2 (volume : Measure V)] with x h1 h2
  rw [h1, h2, posOp_apply, posOp_apply]
  simp only [map_mul, Complex.conj_ofReal]
  ring
