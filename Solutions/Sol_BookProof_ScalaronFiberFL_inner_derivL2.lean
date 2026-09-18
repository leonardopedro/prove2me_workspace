-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.inner_derivL2
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronFiberFL_inner_toLp_toLp
import Theorems.Thm_BookProof_ScalaronEsa_ccEquiv_coe
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f g : ccSchwartz ℝ) :
    (inner ℂ ((ccEquiv ℝ f : ccDomain ℝ) : L2R) (derivL2 g) : ℂ)
      = ∫ y : ℝ, (starRingEnd ℂ) ((f : 𝓢(ℝ, ℂ)) y)
          * deriv ((g : 𝓢(ℝ, ℂ)) : ℝ → ℂ) y := by

  rw [ccEquiv_coe, derivL2, inner_toLp_toLp]
  refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
  simp
