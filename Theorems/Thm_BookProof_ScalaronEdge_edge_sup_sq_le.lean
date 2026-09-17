-- Generated from ChapterScalaronEdge.lean — theorem BookProof.ScalaronEdge.edge_sup_sq_le
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

theorem BookProof.ScalaronEdge.edge_sup_sq_le (f : ℝ → ℂ) (hf : ContDiff ℝ 2 f) (hs : HasCompactSupport f)
    {δ : ℝ} (hδ : 0 < δ) (x : ℝ) :
    ‖f x‖ ^ 2 ≤ ∫ t, (δ * ‖f t‖ ^ 2 + δ⁻¹ * ‖deriv f t‖ ^ 2) := by sorry
