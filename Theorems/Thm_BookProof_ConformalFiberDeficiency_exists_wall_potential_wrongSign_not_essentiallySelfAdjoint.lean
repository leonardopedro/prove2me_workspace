-- Generated from ChapterConformalFiberDeficiency.lean — theorem BookProof.ConformalFiberDeficiency.exists_wall_potential_wrongSign_not_essentiallySelfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallDeficiencyObstruction
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.ConformalFiberDeficiency



open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.ConformalFiberDeficiency.exists_wall_potential_wrongSign_not_essentiallySelfAdjoint :
    ∃ (U V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V),
      (∀ y, 0 ≤ U y) ∧ Tendsto U atBot atTop ∧ Tendsto U atTop (𝓝 0) ∧
        (∀ y, V y = -24 * (U y + 1 / 32)) ∧
        ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by sorry
