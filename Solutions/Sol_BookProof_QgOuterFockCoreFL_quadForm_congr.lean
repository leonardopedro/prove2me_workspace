-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.quadForm_congr
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
theorem solution {D D' : Submodule ℂ F} (N : D →ₗ[ℂ] F) (N' : D' →ₗ[ℂ] F)
    (x : D) (x' : D') (hx : (x : F) = (x' : F)) (hN : N x = N' x') :
    quadForm N x = quadForm N' x' := by

  unfold quadForm
  rw [hx, hN]
