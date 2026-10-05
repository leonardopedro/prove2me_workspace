-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.conjQ_lagEnergy
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_conjQ_potP
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution : conjQ (lagEnergy S) = lagEnergy S := by

  rw [lagEnergy, conjQ, map_add, map_add, map_one, MvPolynomial.smul_eq_C_mul, map_mul, map_C,
    Complex.conj_ofReal, map_sum]
  simp only [map_mul, map_X]
  change _ + conjQ _ = _
  rw [conjQ_potP]
