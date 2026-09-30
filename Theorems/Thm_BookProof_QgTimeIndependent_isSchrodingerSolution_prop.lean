-- Generated from ChapterQgTimeIndependentFlow.lean — theorem BookProof.QgTimeIndependent.isSchrodingerSolution_prop
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
open BookProof.QgTimeIndependent








open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.QgTimeIndependent.isSchrodingerSolution_prop (T : UnboundedSelfAdjoint E) (s : ℝ) (x : T.domain) :
    IsSchrodingerSolution T (fun r : ℝ => prop T r s (x : E)) := by sorry
