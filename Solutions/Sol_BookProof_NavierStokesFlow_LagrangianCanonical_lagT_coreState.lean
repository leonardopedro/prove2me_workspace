-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagT_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_numOp_coreState
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (β : Vel) :
    lagT nu (coreState β) = ((lagLam nu β : ℝ) : ℂ) • coreState β :=
  f the second-order part at the Hermite state `e_β`:
  `ω(|β| + 3/2)`. -/
  noncomputable def lagLam (nu : ℝ) (β : Vel) : ℝ :=
    omega nu * (∑ i : Fin 3, (β i : ℝ)) + 3 * omega nu / 2
  
  /-- **The Hermite s
