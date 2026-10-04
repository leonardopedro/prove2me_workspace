-- Generated from ChapterBddBelowWallEsa.lean — theorem BookProof.BddBelowWallEsa.wallHam_essentiallySelfAdjoint_of_bddBelow'
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterA4
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}



open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.BddBelowWallEsa.wallHam_essentiallySelfAdjoint_of_bddBelow_prime (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (hVb : BddBelow (Set.range V)) :
    EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by sorry
