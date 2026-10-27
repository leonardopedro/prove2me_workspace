-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.eval_lagEnergy_re
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_eval_potP
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (z : PIdx K → ℝ) :
    (MvPolynomial.eval (fun i => ((z i : ℝ) : ℂ)) (lagEnergy S)).re
      = 1 + (1 / 2) * ∑ j : DIdx K, z (true, j) ^ 2
        + (ev (fun j => z (dispVar j)) (volPot S.kappa S.kvec)).re := by

  rw [lagEnergy, map_add, map_add, eval_potP, MvPolynomial.smul_eq_C_mul, map_mul,
    MvPolynomial.eval_C, map_sum]
  simp only [map_mul, MvPolynomial.eval_X, map_one, Complex.add_re, Complex.one_re,
    Complex.re_ofReal_mul]
  have hs : (∑ x : DIdx K, ((z (true, x) : ℝ) : ℂ) * ((z (true, x) : ℝ) : ℂ)).re
      = ∑ j : DIdx K, z (true, j) ^ 2 := by
    rw [Complex.re_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [← Complex.ofReal_mul, Complex.ofReal_re]
    ring
  rw [hs]
