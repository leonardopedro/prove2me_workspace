-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.eval_lagFlux_re
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
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
theorem solution (z : PIdx K → ℝ) :
    (MvPolynomial.eval (fun i => ((z i : ℝ) : ℂ)) (lagFlux S)).re
      = -(S.nu * ∑ j : DIdx K, lam S j * z (true, j) ^ 2) := by

  rw [lagFlux, map_sum, Complex.re_sum, Finset.mul_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [MvPolynomial.smul_eq_C_mul, map_mul, MvPolynomial.eval_C, map_mul, MvPolynomial.eval_X,
    ← Complex.ofReal_mul, ← Complex.ofReal_mul, Complex.ofReal_re]
  ring
