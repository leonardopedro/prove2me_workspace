-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.comm_lagP_lagQ
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical
















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent














variable (nu : ℝ)

theorem BookProof.NavierStokesFlow.LagrangianCanonical.comm_lagP_lagQ (hnu : 0 < nu) (i : Fin 3) :
    (lagP nu i).comp (lagQ nu i) - (lagQ nu i).comp (lagP nu i)
      = (-Complex.I) • LinearMap.id := by sorry
