-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.lagT_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

variable (nu : ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

 congr 1
  push_cast
  ring

theorem BookProof.NavierStokesFlow.LagrangianCanonical.lagT_hasZeroDeficiencyOn (w : L2I Vel)
    (hw : ∀ β : Vel, (inner ℂ ((coreState β : lpFiniteModes Vel) : L2I Vel) w : ℂ) = 0) :
    w = 0 := by
  ext β
  have h := hw β
  rw [show ((coreState β : lpFiniteModes Vel) : L2I Vel) = lp.s := by sorry
