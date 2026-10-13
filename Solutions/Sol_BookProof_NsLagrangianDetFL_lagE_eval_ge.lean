-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagE_eval_ge
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_eval_lagEnergy_ge
import Theorems.Thm_BookProof_NsLagrangianDetFL_eval_rename_lagEquiv
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet
open BookProof.HermiteProductCore
open BookProof.NsLagrangianDet

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
