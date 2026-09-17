-- Generated from ChapterScalaronEdge.lean — theorem BookProof.ScalaronEdge.edge_normSq_hasDerivAt
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
