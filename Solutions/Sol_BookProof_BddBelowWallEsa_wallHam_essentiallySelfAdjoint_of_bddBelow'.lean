-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.wallHam_essentiallySelfAdjoint_of_bddBelow'
import Mathlib
import Theorems.Thm_BookProof_BddBelowWallEsa_wallHam_essentiallySelfAdjoint_of_bddBelow
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterWeakSecondDerivative
import Definitions.Def_ChapterBddBelowWallEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa

noncomputable section

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (hVb : BddBelow (Set.range V)) :
    EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by

  obtain ⟨c, hc⟩ := hVb
  refine wallHam_essentiallySelfAdjoint_of_bddBelow V hV (K := -c) fun x => ?_
  simpa using hc ⟨x, rfl⟩
