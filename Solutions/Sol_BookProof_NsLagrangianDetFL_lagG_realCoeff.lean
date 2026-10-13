-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagG_realCoeff
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_conjQ_lagDrift
import Theorems.Thm_BookProof_NsLagrangianDetFL_realCoeff_rename
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Definitions.Def_ChapterYangMillsHermite
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet
open BookProof.YangMillsHermite

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin (lagDim K)) : RealCoeff (lagG S i) := realCoeff_rename (conjQ_lagDrift S _)
