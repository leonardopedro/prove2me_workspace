-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagE_eval_ge
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_eval_lagEnergy_ge
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
    1 ≤ (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) (lagE S)).re := by

  rw [lagE, eval_rename_lagEquiv]
  have := eval_lagEnergy_ge S (fun j => y (lagEquiv j))
  have hsq : (0 : ℝ) ≤ ∑ j : DIdx K, (y (lagEquiv (true, j))) ^ 2 :=
    Finset.sum_nonneg fun j _ => sq_nonneg _
  linarith
