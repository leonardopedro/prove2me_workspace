-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.lagrangianCore_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_LagrangianFullData_hFull_isSymmetricDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

set_option maxHeartbeats 1000000 in
open BookProof.NavierStokesFlow.LagrangianEsa
theorem solution : SymmetricOn L.D (lagrangianCore L) := fun x y => L.hFull_isSymmetricDom x y
