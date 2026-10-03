-- Generated from ChapterWallDeficiencyObstruction.lean — theorem BookProof.WallDeficiencyObstruction.IsL2Ode.memLp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterA4



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.WallDeficiencyObstruction.IsL2Ode.memLp {V : ℝ → ℝ} {z : ℂ} {W : ℝ → ℂ} (h : IsL2Ode V z W) :
    MemLp W 2 (volume : Measure ℝ) := by sorry
