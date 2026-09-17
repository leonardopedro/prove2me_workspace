-- Generated from ChapterScalaronEdge.lean — solution of BookProof.ScalaronEdge.edgeKinConst_pos
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

set_option maxHeartbeats 1000000 in
theorem solution {A B : ℝ} (hA : 0 < A) (hB : 0 < B) : 0 < edgeKinConst A B := by

  unfold edgeKinConst
  have : 0 < A + B := by linarith
  positivity
