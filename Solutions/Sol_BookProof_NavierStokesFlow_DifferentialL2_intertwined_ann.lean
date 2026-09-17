-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.intertwined_ann
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_intertwine_ann
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) : Intertwined (ann i) (annOp i) :=
  fun x =>
    congrFun (congrArg (fun F : lpFiniteModes Vel →ₗ[ℂ] (polyGaussCore (d := 3)) => ⇑F)
      (intertwine_ann i)) x
