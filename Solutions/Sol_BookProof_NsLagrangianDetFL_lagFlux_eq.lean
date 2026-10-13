-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagFlux_eq
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_pderiv_disp_energy
import Theorems.Thm_BookProof_NsLagrangianDetFL_pderiv_vel_energy
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
theorem solution : ∑ i, lagDrift S i * pderiv i (lagEnergy S) = lagFlux S := by

  rw [Fintype.sum_prod_type, Fintype.sum_bool]
  simp only [lagDrift, pderiv_disp_energy, pderiv_vel_energy]
  rw [← Finset.sum_add_distrib, lagFlux]
  refine Finset.sum_congr rfl fun j _ => ?_
  simp only [MvPolynomial.smul_eq_C_mul, Complex.ofReal_neg, map_neg]
  ring
