-- Generated from ChapterQgOuterFockCoreFL.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.coreRange_dense
import Mathlib
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData




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
theorem solution : Dense ((d.coreRange : Submodule ℂ F) : Set F) := by

  rw [Metric.dense_iff]
  intro f r hr
  obtain ⟨x, hx⟩ := d.C.surj f
  obtain ⟨y, hyC, hy1, hy2⟩ := d.gc.approx x (r / 3) (by positivity)
  refine ⟨d.coreShift ⟨(y : F), hyC⟩, ?_, ⟨⟨(y : F), hyC⟩, rfl⟩⟩
  have hyy : (⟨(y : F), d.gc.le hyC⟩ : d.C.dom) = y := Subtype.ext rfl
  have hval : d.coreShift ⟨(y : F), hyC⟩ = d.C.op y + (y : F) := by
    rw [coreShift_apply, hyy]
  rw [Metric.mem_ball, dist_eq_norm, hval, ← hx]
  calc ‖d.C.op y + (y : F) - (d.C.op x + (x : F))‖
      = ‖(d.C.op y - d.C.op x) + ((y : F) - (x : F))‖ := by congr 1; abel
    _ ≤ ‖d.C.op y - d.C.op x‖ + ‖(y : F) - (x : F)‖ := norm_add_le _ _
    _ < r / 3 + r / 3 := by linarith
    _ < r := by linarith
