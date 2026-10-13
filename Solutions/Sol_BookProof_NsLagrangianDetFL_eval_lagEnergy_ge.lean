-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.eval_lagEnergy_ge
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_eval_lagEnergy_re
import Theorems.Thm_BookProof_NsLagrangianDet_volPot_eval_nonneg
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet
open BookProof.NsLagrangianDet
open BookProof.SqueezedGaussStates

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (z : PIdx K → ℝ) :
    1 + (1 / 2) * ∑ j : DIdx K, z (true, j) ^ 2
      ≤ (MvPolynomial.eval (fun i => ((z i : ℝ) : ℂ)) (lagEnergy S)).re := by

  rw [eval_lagEnergy_re]
  have := volPot_eval_nonneg S.kappa_nonneg S.kvec (fun j => z (dispVar j))
  linarith
