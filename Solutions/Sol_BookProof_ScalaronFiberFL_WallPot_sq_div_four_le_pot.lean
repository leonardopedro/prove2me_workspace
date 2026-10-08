-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.WallPot.sq_div_four_le_pot
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_nonneg
open BookProof.ScalaronFiberFL
open BookProof.ScalaronFiberFL.WallPot




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (W : WallPot) (s : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hs : 0 ≤ s) (x : ℝ) : x ^ 2 / 4 ≤ W.pot s x := by

  have h2 := W.nonneg x
  simp only [pot]
  linarith
