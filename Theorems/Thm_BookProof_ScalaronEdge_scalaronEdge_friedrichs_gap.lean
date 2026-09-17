-- Generated from ChapterScalaronEdge.lean — theorem BookProof.ScalaronEdge.scalaronEdge_friedrichs_gap
import Mathlib
import Definitions.Def_ChapterScalaronEdge
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

theorem BookProof.ScalaronEdge.scalaronEdge_friedrichs_gap (hM : 0 < M) (halpha : 0 < alpha) (c : ℝ) (hc : 0 < c)
    (hcs : c < edgeShelf M alpha) :
    ∃ E₀ : ℝ, 0 < E₀ ∧ ∃ (Dom : Submodule ℂ (Lp ℂ 2 (volume : Measure ℝ)))
      (A : Dom →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ))
      (S : Lp ℂ 2 (volume : Measure ℝ) →L[ℂ] Lp ℂ 2 (volume : Measure ℝ)),
      IsPositiveSelfAdjointExtension (starobinskyEdgeHam M alpha) A ∧ IsShiftInvert A 1 S ∧
        IsSelfAdjoint S ∧ (∀ y : Dom, E₀ * ‖(y : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
          ≤ quadForm A y) := by sorry
