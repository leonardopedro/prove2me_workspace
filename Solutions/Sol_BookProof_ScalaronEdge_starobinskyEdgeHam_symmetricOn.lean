-- Generated from ChapterScalaronEdge.lean — solution of BookProof.ScalaronEdge.starobinskyEdgeHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterScalaronEdge
import Theorems.Thm_BookProof_ScalaronWallEsa_wallHam_symmetricOn
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFriedrichsFormGap
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
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
theorem solution :
    SymmetricOn (ccDomain ℝ) (starobinskyEdgeHam M alpha) := wallHam_symmetricOn _ (scalV_smooth M alpha)
