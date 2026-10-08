-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.wallHam_essentiallySelfAdjoint_of_bddBelow'
import Mathlib
import Theorems.Thm_BookProof_BddBelowWallEsa_wallHam_essentiallySelfAdjoint_of_bddBelow
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (hVb : BddBelow (Set.range V)) :
    EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by

  obtain ⟨c, hc⟩ := hVb
  refine wallHam_essentiallySelfAdjoint_of_bddBelow V hV (K := -c) fun x => ?_
  simpa using hc ⟨x, rfl⟩
