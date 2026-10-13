-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.realCoeff_rename
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
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
theorem solution {p : MvPolynomial (PIdx K) ℂ} (hp : conjQ p = p) :
    RealCoeff (rename (lagEquiv (K := K)) p) := by

  change map (starRingEnd ℂ) (rename lagEquiv p) = rename lagEquiv p
  rw [map_rename]
  change rename lagEquiv (conjQ p) = _
  rw [hp]
