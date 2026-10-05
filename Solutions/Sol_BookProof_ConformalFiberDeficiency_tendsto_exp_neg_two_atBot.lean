-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.tendsto_exp_neg_two_atBot
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    Tendsto (fun y : ℝ => Real.exp (-(2 * y))) atBot atTop := by

  have h1 : Tendsto (fun y : ℝ => 2 * y) atBot atBot :=
    Filter.Tendsto.const_mul_atBot two_pos tendsto_id
  have h2 : Tendsto (fun y : ℝ => -(2 * y)) atBot atTop := tendsto_neg_atBot_atTop.comp h1
  exact Real.tendsto_exp_atTop.comp h2
