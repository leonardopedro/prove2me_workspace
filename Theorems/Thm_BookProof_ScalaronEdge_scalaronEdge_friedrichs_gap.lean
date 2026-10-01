-- Generated from ChapterScalaronEdge.lean — theorem BookProof.ScalaronEdge.scalaronEdge_friedrichs_gap
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterFriedrichsFormGap
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterScalaronEdge
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.ScalaronEsa
open BookProof.YangMillsFriedrichs
open BookProof.ScalaronEdge

variable (M alpha : ℝ)



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



theorem BookProof.ScalaronEdge.scalaronEdge_friedrichs_gap (hM : 0 < M) (halpha : 0 < alpha) (c : ℝ) (hc : 0 < c)
    (hcs : c < edgeShelf M alpha) :
    ∃ E₀ : ℝ, 0 < E₀ ∧ ∃ (Dom : Submodule ℂ (Lp ℂ 2 (volume : Measure ℝ)))
      (A : Dom →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ))
      (S : Lp ℂ 2 (volume : Measure ℝ) →L[ℂ] Lp ℂ 2 (volume : Measure ℝ)),
      IsPositiveSelfAdjointExtension (starobinskyEdgeHam M alpha) A ∧ IsShiftInvert A 1 S ∧
        IsSelfAdjoint S ∧ (∀ y : Dom, E₀ * ‖(y : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
          ≤ quadForm A y) := by sorry
