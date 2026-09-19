-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.deriv_ofReal_comp
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronWallEsa




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {g : ℝ → ℝ} (hg : Differentiable ℝ g) :
    deriv (fun y => ((g y : ℝ) : ℂ)) = fun x => ((deriv g x : ℝ) : ℂ) := funext fun x => ((hg x).hasDerivAt.ofReal_comp).deriv
