-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.dispVar_injective
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

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective (dispVar (K := K)) := by

  intro a b h; simpa [dispVar] using h
