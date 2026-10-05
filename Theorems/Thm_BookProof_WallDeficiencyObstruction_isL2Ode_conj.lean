-- Generated from ChapterWallDeficiencyObstruction.lean — theorem BookProof.WallDeficiencyObstruction.isL2Ode_conj
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
open BookProof.WallDeficiencyObstruction



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.WallDeficiencyObstruction.isL2Ode_conj {V : ℝ → ℝ} {z : ℂ} {W : ℝ → ℂ} (h : IsL2Ode V z W) :
    IsL2Ode V ((starRingEnd ℂ) z) (fun x => (starRingEnd ℂ) (W x)) := by sorry
