-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.eval_rename_lagEquiv
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Definitions.Def_ChapterHermiteProductCore
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet
open BookProof.HermiteProductCore

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (y : Vd (lagDim K)) (p : MvPolynomial (PIdx K) ℂ) :
    MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) (rename lagEquiv p)
      = MvPolynomial.eval (fun i => (((fun j => y (lagEquiv j)) i : ℝ) : ℂ)) p := by

  rw [eval_rename]
  rfl
