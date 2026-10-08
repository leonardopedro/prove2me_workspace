-- Generated from ChapterScalaronEdge.lean — theorem BookProof.ScalaronEdge.edgeShelf_pos
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


theorem BookProof.ScalaronEdge.edgeShelf_pos (hM : 0 < M) (halpha : 0 < alpha) : 0 < edgeShelf M alpha := by sorry
