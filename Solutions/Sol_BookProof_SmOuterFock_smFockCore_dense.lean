-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.smFockCore_dense
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Theorems.Thm_BookProof_DirectSumEsa_dsCore_dense
open BookProof.SmOuterFock




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((smFockCore : Submodule ℂ smFockSpace) : Set smFockSpace) := dsCore_dense fun _ => polyGaussCore_dense
