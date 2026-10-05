-- Generated from ChapterLimitCircleExample.lean — theorem BookProof.LimitCircleExample.exists_smooth_potential_not_essentiallySelfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallDeficiencyObstruction
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.LimitCircleExample



open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.LimitCircleExample.exists_smooth_potential_not_essentiallySelfAdjoint :
    ∃ (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V),
      ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by sorry
