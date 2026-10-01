-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.coreState_total
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

variable (nu : ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

tes diagonalize the Lagrangian second-order part.** -/
theorem BookProof.NavierStokesFlow.LagrangianCanonical.coreState_total (β : Vel) :
    lagT nu (coreState β) = ((lagLam nu β : ℝ) : ℂ) • coreState β := by
  simp only := by sorry
