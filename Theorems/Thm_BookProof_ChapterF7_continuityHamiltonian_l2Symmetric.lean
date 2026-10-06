-- Generated from ChapterF7.lean — theorem BookProof.ChapterF7.continuityHamiltonian_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterF7


open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF7.continuityHamiltonian_l2Symmetric (v : ℝ → ℝ)
    (hv : Function.HasTemperateGrowth (fun x => (v x : ℂ))) :
    IsL2Symmetric
      (((1 : ℂ) / 2) • (momentum.comp (mulOp v hv) + (mulOp v hv).comp momentum)) := by sorry
