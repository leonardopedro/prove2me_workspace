-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.wallHamBddBelow_semibounded
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterWallEsaBddBelow
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


theorem BookProof.WallEsaSemibounded.wallHamBddBelow_semibounded (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {c : ℝ} (hVc : ∀ x, -c ≤ V x) :
    SemiboundedBelowOn (ccDomain ℝ) (wallHam V hV) c := by sorry
