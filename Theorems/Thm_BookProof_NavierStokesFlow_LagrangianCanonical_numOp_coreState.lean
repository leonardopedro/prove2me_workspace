-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.numOp_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

variable (nu : ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

_sum, Finset.smul_sum, Finset.smul_sum]
  rw [← Finset.sum_add_distrib]
  rw [Finset.sum_congr rfl fun i _ => hmode i]
  rw [Finset.sum_add_distrib, hcnt, hbridge]

/-! ## Diagonaliz := by sorry
