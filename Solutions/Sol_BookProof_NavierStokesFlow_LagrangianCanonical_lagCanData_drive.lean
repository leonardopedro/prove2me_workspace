-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagCanData_drive
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    (lagCanData nu hnu f).drive = (lagCanData nu hnu f).P := rfl
