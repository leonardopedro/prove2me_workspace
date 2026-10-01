-- Generated from ChapterStoneEvolution.lean — theorem BookProof.ChapterStoneResolvent.hasDerivAt_apply
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open scoped InnerProductSpace
open Filter Topology NormedSpace



theorem BookProof.ChapterStoneResolvent.hasDerivAt_apply {f : ℝ → (H →L[ℂ] H)} {f' : H →L[ℂ] H} {t : ℝ} (x : H)
    (h : HasDerivAt f f' t) : HasDerivAt (fun s => f s x) (f' x) t := by sorry
