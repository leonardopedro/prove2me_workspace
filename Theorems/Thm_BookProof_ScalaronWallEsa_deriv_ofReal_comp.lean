-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.deriv_ofReal_comp
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronWallEsa



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.ScalaronWallEsa.deriv_ofReal_comp {g : ℝ → ℝ} (hg : Differentiable ℝ g) :
    deriv (fun y => ((g y : ℝ) : ℂ)) = fun x => ((deriv g x : ℝ) : ℂ) := by sorry
