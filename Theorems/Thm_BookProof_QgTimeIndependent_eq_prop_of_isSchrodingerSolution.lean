-- Generated from ChapterQgTimeIndependentFlow.lean — theorem BookProof.QgTimeIndependent.eq_prop_of_isSchrodingerSolution
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent
open BookProof.QgTimeIndependent



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.QgTimeIndependent.eq_prop_of_isSchrodingerSolution (T : UnboundedSelfAdjoint E) {y : ℝ → E}
    (hy : IsSchrodingerSolution T y) (t s : ℝ) : y t = prop T t s (y s) := by sorry
