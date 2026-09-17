-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.inner_xCc_ham
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.inner_xCc_ham (W : WallPot) (s : ℝ) (f g : ccSchwartz ℝ) :
    (inner ℂ (xCc (ccEquiv ℝ g)) (W.ham s (ccEquiv ℝ f)) : ℂ)
      = ∫ y : ℝ, (y : ℂ) * ((starRingEnd ℂ) ((g : 𝓢(ℝ, ℂ)) y)
          * (-deriv (deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) y
            + (W.pot s y : ℂ) * (f : 𝓢(ℝ, ℂ)) y)) := by sorry
