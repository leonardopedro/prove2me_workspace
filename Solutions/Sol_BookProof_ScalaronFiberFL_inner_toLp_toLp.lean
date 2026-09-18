-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.inner_toLp_toLp
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (g h : 𝓢(ℝ, ℂ)) :
    (inner ℂ (g.toLp 2 (volume : Measure ℝ)) (h.toLp 2 (volume : Measure ℝ)) : ℂ)
      = ∫ x, (starRingEnd ℂ) (g x) * h x := by

  rw [inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [h.coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx]
