-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.integral_x_wronskian
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.integral_x_wronskian (f g : ℝ → ℂ)
    (hf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) f) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hfs : HasCompactSupport f) (hgs : HasCompactSupport g) :
    (∫ x : ℝ, (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
        - (starRingEnd ℂ) (deriv (deriv f) x) * g x))
      = -2 * ∫ x : ℝ, (starRingEnd ℂ) (f x) * deriv g x := by sorry
