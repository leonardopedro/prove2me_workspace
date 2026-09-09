-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.secondOrder_inner
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich

















open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

set_option maxHeartbeats 1000000 in
theorem solution (v : L.D) :
    (inner ℂ (v : F) (secondOrder L v : F) : ℂ).re
      = (inner ℂ (v : F) (L.kinetic v : F) : ℂ).re
        + (inner ℂ (v : F) (L.viscous v : F) : ℂ).re := by

  simp only [secondOrder, LinearMap.add_apply, Submodule.coe_add, inner_add_right,
    Complex.add_re]
