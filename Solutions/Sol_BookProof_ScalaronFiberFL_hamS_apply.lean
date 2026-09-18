-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.hamS_apply
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronWallEsa_kinOpR_apply
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) (x : ℝ) :
    hamS W s f x
      = -deriv (deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) x + (W.pot s x : ℂ) * (f : 𝓢(ℝ, ℂ)) x := by

  simp [hamS, kinOpR_apply]
