-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.realCoeff_rename
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

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
