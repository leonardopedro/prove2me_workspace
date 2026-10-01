-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.integral_x_wronskian
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterWallEsaBddBelow
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterSchrodingerCutoffEsa
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterA4

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.integral_x_wronskian (f g : ℝ → ℂ)
    (hf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) f) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hfs : HasCompactSupport f) (hgs : HasCompactSupport g) :
    (∫ x : ℝ, (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
        - (starRingEnd ℂ) (deriv (deriv f) x) * g x))
      = -2 * ∫ x : ℝ, (starRingEnd ℂ) (f x) * deriv g x := by sorry
