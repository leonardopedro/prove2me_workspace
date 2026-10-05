-- Generated from ChapterWallDeficiencyObstruction.lean — theorem BookProof.WallDeficiencyObstruction.deficiencyTrivialAt_conj_iff
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.WallDeficiencyObstruction.deficiencyTrivialAt_conj_iff (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z
      ↔ DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) ((starRingEnd ℂ) z) := by sorry
