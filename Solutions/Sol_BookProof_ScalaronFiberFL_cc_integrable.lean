-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.cc_integrable
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f : ccSchwartz ℝ) {W : ℝ → ℝ} (hW : Continuous W) :
    Integrable fun x => W x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by

  have hsq : Continuous fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by fun_prop
  have hsupp : HasCompactSupport fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    f.2.comp_left (g := fun z : ℂ => ‖z‖ ^ 2) (by simp)
  exact ((hW.mul hsq)).integrable_of_hasCompactSupport hsupp.mul_left
