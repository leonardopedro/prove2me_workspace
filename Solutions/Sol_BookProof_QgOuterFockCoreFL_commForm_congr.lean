-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.commForm_congr
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL




open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.QgOuterFockFL
open BookProof.YangMillsFriedrichs
open BookProof.EsaClosure
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore
open Filter Topology

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {D D' : Submodule ℂ F} (H N : D →ₗ[ℂ] F) (H' N' : D' →ₗ[ℂ] F)
    (x : D) (x' : D') (hH : H x = H' x') (hN : N x = N' x') :
    commForm H N x = commForm H' N' x' := by

  unfold commForm
  rw [hH, hN]
