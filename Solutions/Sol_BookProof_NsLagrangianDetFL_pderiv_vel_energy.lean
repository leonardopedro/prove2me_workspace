-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.pderiv_vel_energy
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_pderiv_vel_potP
import Theorems.Thm_BookProof_NsLagrangianDetFL_pderiv_vel_vsq
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet
open BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (j : DIdx K) :
    pderiv ((true, j) : PIdx K) (lagEnergy S) = X (true, j) := by

  rw [lagEnergy, map_add, map_add, Derivation.map_smul, pderiv_vel_vsq, pderiv_vel_potP,
    smul_smul]
  have : ((1 / 2 : ℝ) : ℂ) * 2 = 1 := by push_cast; ring
  rw [this]
  simp
