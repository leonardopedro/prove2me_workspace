-- Generated from ChapterScalaronEdge.lean — theorem BookProof.ScalaronEdge.edge_re_mul_le
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


theorem BookProof.ScalaronEdge.edge_re_mul_le (z w : ℂ) {δ : ℝ} (hδ : 0 < δ) :
    ((starRingEnd ℂ) w * z + (starRingEnd ℂ) z * w).re ≤ δ * ‖z‖ ^ 2 + δ⁻¹ * ‖w‖ ^ 2 := by sorry
