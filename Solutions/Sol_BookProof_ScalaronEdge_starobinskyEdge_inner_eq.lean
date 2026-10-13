-- Generated from ChapterScalaronEdge.lean — solution of BookProof.ScalaronEdge.starobinskyEdge_inner_eq
import Mathlib
import Definitions.Def_ChapterScalaronEdge
import Theorems.Thm_BookProof_WallEsaSemibounded_kinCcR_quadratic_form
import Theorems.Thm_BookProof_WallEsaSemibounded_opCc_quadratic_form
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFriedrichsFormGap
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronEdge




open Complex Real MeasureTheory Function SchwartzMap ComplexOrder
open BookProof.Starobinsky
open BookProof.ScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.FarisLavine
open BookProof.WallEsaSemibounded
open BookProof.FriedrichsExtension
open BookProof.FriedrichsFormGap
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert


variable (M alpha : ℝ)

variable (M alpha : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (f : ccSchwartz ℝ) :
    (inner ℂ (starobinskyEdgeHam M alpha (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = (((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2)
          + ∫ x, scalV M alpha x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by

  have hk := kinCcR_quadratic_form f
  have hp := opCc_quadratic_form (scalV M alpha) (scalV_smooth M alpha) f
  simp only [starobinskyEdgeHam, wallHam, LinearMap.add_apply, inner_add_left, hk, hp]
  push_cast
  ring
