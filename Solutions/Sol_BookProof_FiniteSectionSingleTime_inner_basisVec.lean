-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.inner_basisVec
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
open BookProof.FiniteSectionSingleTime



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution (k : ι) (y : L2I ι) : (inner ℂ (basisVec k) y : ℂ) = (y : ι → ℂ) k := by

  rw [basisVec, lp.inner_single_left]
  simp
