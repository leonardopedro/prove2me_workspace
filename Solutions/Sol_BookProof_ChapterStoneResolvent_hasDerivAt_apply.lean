-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.hasDerivAt_apply
import Mathlib
import Definitions.Def_ChapterStoneEvolution
open BookProof.ChapterStoneResolvent



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {f : ℝ → (H →L[ℂ] H)} {f' : H →L[ℂ] H} {t : ℝ} (x : H)
    (h : HasDerivAt f f' t) : HasDerivAt (fun s => f s x) (f' x) t := ((ContinuousLinearMap.apply ℂ H x).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt t h
