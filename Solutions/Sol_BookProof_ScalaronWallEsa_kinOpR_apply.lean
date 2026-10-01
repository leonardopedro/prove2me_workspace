-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.kinOpR_apply
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
ce. -/
def kinOpR : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  constCoeffOp (fun _ : Fin 1 => (-1 : ℝ) :=
  ) (fun _ : Fin 1 => (1 : ℝ)) 0
  
  lemma kinOpR_apply (f : 𝓢(ℝ, ℂ)) (x : ℝ) :
      (kinOpR f) x = -deriv (deriv (f : ℝ → ℂ)) x := by
    have h : kinOpR f
        = (∑ _i : Fin 1, ((-1 :
