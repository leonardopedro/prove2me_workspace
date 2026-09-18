-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.wallHam_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.ScalaronWallEsa












open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.ScalaronWallEsa.wallHam_essentiallySelfAdjoint (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    (hVnn : ∀ x, 0 ≤ V x) :
    EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by sorry
