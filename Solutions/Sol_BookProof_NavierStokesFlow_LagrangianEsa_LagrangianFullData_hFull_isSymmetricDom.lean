-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.hFull_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_LagrangianFullData_kinetic_isSymmetricDom
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_LagrangianFullData_viscous_isSymmetricDom
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_LagrangianFullData_drift_isSymmetricDom
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_IsSymmetricDom_add
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData





open FullEsa
open BookProof.ChapterF7
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.NavierStokesFlow.LagrangianEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

set_option maxHeartbeats 1000000 in

theorem solution : IsSymmetricDom L.hFull :=
  ((L.kinetic_isSymmetricDom.add L.viscous_isSymmetricDom).add
      L.drift_isSymmetricDom).add L.constraint_symm

/-! ### Positivity of the second-order part -/
