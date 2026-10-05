-- Generated from ChapterWallDeficiencyObstruction.lean — theorem BookProof.WallDeficiencyObstruction.deficiencyTrivialAt_iff_no_l2_solution
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv
open BookProof.WeakSecondDeriv.IsTestFun
open BookProof.WallDeficiencyObstruction



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.WallDeficiencyObstruction.deficiencyTrivialAt_iff_no_l2_solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z
      ↔ ∀ W : ℝ → ℂ, IsL2Ode V z W → ∀ x, W x = 0 := by sorry
