-- Generated from ChapterQgTimeIndependentFlow.lean — theorem BookProof.QgTimeIndependent.hasDerivAt_prop
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
open BookProof.QgTimeIndependent








open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.QgTimeIndependent.hasDerivAt_prop (T : UnboundedSelfAdjoint E) (x : T.domain) (t s : ℝ) :
    HasDerivAt (fun r : ℝ => prop T r s (x : E))
      ((-Complex.I) • T.op ⟨T.stoneU (t - s) (x : E), T.stoneU_mem_domain (t - s) x⟩) t := by sorry
