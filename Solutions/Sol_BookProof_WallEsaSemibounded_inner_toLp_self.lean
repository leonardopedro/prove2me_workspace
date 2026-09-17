-- Generated from ChapterWallEsaSemibounded.lean — solution of BookProof.WallEsaSemibounded.inner_toLp_self
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
open BookProof.WallEsaSemibounded











open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (g : 𝓢(ℝ, ℂ)) :
    (inner ℂ (g.toLp 2 (volume : Measure ℝ)) (g.toLp 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖g x‖ ^ 2 : ℝ) : ℂ) := by

  rw [inner_toLp_left]
  rw [← integral_complex_ofReal]
  refine integral_congr_ae ?_
  filter_upwards [g.coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx, Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]
