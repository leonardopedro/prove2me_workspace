-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_esa
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

variable (nu : ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

s Vel) (lagT nu) :=
  hasZeroDeficiencyOn_of_total_eigenvectors _ _ coreState (lagLam nu)
    (lagT_coreState nu) coreState_total

theorem BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_esa (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    HasZeroDeficiencyOn (lagCanData nu hnu f).D (secondOrder (lagCanData nu hnu f)) := by
  rw [lagCan_secondOrder_eq nu hnu f]
  exact lagT_hasZeroDeficiencyOn nu

/-- **The full trans := by sorry
