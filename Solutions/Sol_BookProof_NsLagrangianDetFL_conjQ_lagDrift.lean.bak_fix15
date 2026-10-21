-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.conjQ_lagDrift
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_conjQ_potP
import Theorems.Thm_BookProof_NsLagrangianDetFL_conjQ_pderiv
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (i : PIdx K) : conjQ (lagDrift S i) = lagDrift S i := by

  obtain ⟨b, j⟩ := i
  cases b
  · simp [lagDrift, conjQ]
  · simp only [lagDrift]
    rw [conjQ, map_sub, map_neg, MvPolynomial.smul_eq_C_mul, map_mul, map_C, map_X,
      Complex.conj_ofReal]
    change _ - conjQ _ = _
    rw [conjQ_pderiv, conjQ_potP]
