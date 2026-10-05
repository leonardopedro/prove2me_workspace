-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.pderiv_vel_vsq
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (j : DIdx K) :
    pderiv ((true, j) : PIdx K)
      (∑ l : DIdx K, (X (true, l) : MvPolynomial (PIdx K) ℂ) * X (true, l))
      = (2 : ℂ) • X (true, j) := by

  classical
  rw [map_sum, Finset.sum_eq_single j (fun l _ hl => by
    rw [pderiv_mul, pderiv_X_of_ne (by simpa using hl)]
    simp) (fun h => absurd (Finset.mem_univ j) h)]
  rw [pderiv_mul, pderiv_X_self, one_mul, mul_one]
  module
