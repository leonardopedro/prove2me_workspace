-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.eval_potP
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
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
    MvPolynomial.eval (fun i => ((z i : ℝ) : ℂ)) (potP S)
      = ev (fun j => z (dispVar j)) (volPot S.kappa S.kvec) := by

  rw [potP, eval_rename]
  rfl
