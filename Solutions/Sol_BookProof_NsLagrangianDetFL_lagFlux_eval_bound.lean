-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagFlux_eval_bound
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_abs_eval_lagFlux_le
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagG_flux
import Theorems.Thm_BookProof_NsLagrangianDetFL_eval_rename_lagEquiv
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (y : Vd (lagDim K)) :
    |(MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) (∑ i, lagG S i * pderiv i (lagE S))).re|
      ≤ (2 * S.nu * ∑ j, lam S j)
        * (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) (lagE S)).re := by

  rw [lagG_flux, lagE, eval_rename_lagEquiv, eval_rename_lagEquiv]
  exact abs_eval_lagFlux_le S _
