-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.exists_wall_potential_wrongSign_not_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_contDiff_cfV
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfV_not_essentiallySelfAdjoint
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfWall_nonneg
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfV_eq_wall
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfWall_tendsto_atBot
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfWall_tendsto_atTop
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (U V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V),
      (∀ y, 0 ≤ U y) ∧ Tendsto U atBot atTop ∧ Tendsto U atTop (𝓝 0) ∧
        (∀ y, V y = -24 * (U y + 1 / 32)) ∧
        ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) :=
  ⟨cfWall, cfV, contDiff_cfV, cfWall_nonneg, cfWall_tendsto_atBot, cfWall_tendsto_atTop,
      cfV_eq_wall, cfV_not_essentiallySelfAdjoint⟩
