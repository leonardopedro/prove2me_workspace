-- Generated from ChapterWallEsaSemibounded.lean — solution of BookProof.WallEsaSemibounded.wallHam_nonneg_form
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Theorems.Thm_BookProof_WallEsaSemibounded_wallHamBddBelow_semibounded
open BookProof.WallEsaSemibounded











open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (hVnn : ∀ x, 0 ≤ V x) :
    SemiboundedBelowOn (ccDomain ℝ) (wallHam V hV) 0 := wallHamBddBelow_semibounded V hV fun x => by simpa using hVnn x
