-- Generated from ChapterScalaronEdge.lean — solution of BookProof.ScalaronEdge.starobinskyEdge_self_inner
import Mathlib
import Definitions.Def_ChapterScalaronEdge
import Theorems.Thm_BookProof_ScalaronEsa_ccEquiv_coe
import Theorems.Thm_BookProof_WallEsaSemibounded_inner_toLp_self
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

set_option maxHeartbeats 1000000 in
theorem solution (f : ccSchwartz ℝ) :
    (inner ℂ ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by

  rw [ccEquiv_coe]
  exact inner_toLp_self _
