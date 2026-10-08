-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagG_flux
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagFlux_eq
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∑ i, lagG S i * pderiv i (lagE S) = rename lagEquiv (lagFlux S) := by

  rw [← lagFlux_eq, map_sum]
  rw [← (lagEquiv (K := K)).symm.sum_comp]
  refine Finset.sum_congr rfl fun i _ => ?_
  have h := pderiv_rename (lagEquiv (K := K)).injective (lagEquiv.symm i) (lagEnergy S)
  rw [Equiv.apply_symm_apply] at h
  rw [lagG, lagE, h, map_mul]
