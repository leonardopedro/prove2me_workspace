-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.lagT_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

variable (nu : ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

q_P (lagCanData nu hnu f) rfl le_rfl
    (fun v => by simp only [lagCanData]; simp; first | rfl | exact? | done)
    (lagCan_secondOrder_hasZeroDeficiencyOn nu hnu f)

theorem BookProof.NavierStokesFlow.LagrangianCanonical.lagT_not_bounded (β : Vel) : ‖((coreState β : lpF := by sorry
