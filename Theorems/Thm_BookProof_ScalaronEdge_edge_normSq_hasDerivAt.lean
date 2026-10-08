-- Generated from ChapterScalaronEdge.lean — theorem BookProof.ScalaronEdge.edge_normSq_hasDerivAt
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFriedrichsFormGap
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
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


theorem BookProof.ScalaronEdge.edge_normSq_hasDerivAt (f : ℝ → ℂ) (hf : ContDiff ℝ 2 f) (x : ℝ) :
    HasDerivAt (fun t => ‖f t‖ ^ 2)
      (((starRingEnd ℂ) (deriv f x) * f x + (starRingEnd ℂ) (f x) * deriv f x).re) x := by sorry
