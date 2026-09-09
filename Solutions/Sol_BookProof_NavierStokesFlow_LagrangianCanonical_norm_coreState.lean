-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.norm_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (β : Vel) : ‖((coreState β : lpFiniteModes Vel) : L2I Vel)‖ = 1 := by

  have : ‖((coreState β : lpFiniteModes Vel) : L2I Vel)‖ = ‖(1 : ℂ)‖ :=
    lp.norm_single (by norm_num) β 1
  simpa using this
