-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.cc_integrable_sq
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronFiberFL_cc_integrable
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f : ccSchwartz ℝ) :
    Integrable fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by

  simpa using cc_integrable f (W := fun _ => (1 : ℝ)) continuous_const
