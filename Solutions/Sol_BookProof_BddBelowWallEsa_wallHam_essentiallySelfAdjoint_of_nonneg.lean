-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.wallHam_essentiallySelfAdjoint_of_nonneg
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
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (hVnn : ∀ x, 0 ≤ V x) :
    EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := wallHam_essentiallySelfAdjoint_of_bddBelow V hV (K := 0) (fun x => by simpa using hVnn x)
