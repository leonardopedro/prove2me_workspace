-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.crd_numOp
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical
















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

theorem BookProof.NavierStokesFlow.LagrangianCanonical.crd_numOp (i : Fin 3) (x : lpFiniteModes Vel) :
    crd (numOp i x) = fun β => ((β i : ℝ) : ℂ) * crd x β := by sorry
