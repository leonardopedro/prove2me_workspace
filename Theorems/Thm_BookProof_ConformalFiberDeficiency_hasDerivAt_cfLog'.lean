-- Generated from ChapterConformalFiberDeficiency.lean — theorem BookProof.ConformalFiberDeficiency.hasDerivAt_cfLog'
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallDeficiencyObstruction
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency



open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.ConformalFiberDeficiency.hasDerivAt_cfLog_prime (y : ℝ) :
    HasDerivAt cfLog' (((cfP'' y : ℝ) : ℂ) + Complex.I * ((-Real.exp (-y) : ℝ) : ℂ)) y := by sorry
